# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
clear
figlet KaliLinux
echo "KaliLinux for termux-x11 by ©mjc
commands:-
desktop ☞Install xfce4-desktop 
xstart   ☞Start termux-x11 gui
myip    ☞Your ipaddress information
termux  ☞ermux home directory
Note    ☞Default password for sudo is kali"

# Jika tidak berjalan secara interaktif
case $- in
    *i*) ;;
      *) return;;
esac
alias desktop="sudo apt install dbus-x11 xwayland kali-desktop-xfce -y"
alias myip="curl ip-api.com"
alias termux="cd /data/data/com.termux/files/home"
# jangan menaruh baris duplikat atau baris yang dimulai dengan spasi dalam riwayat/log.
# lihat bash(1) untuk opsi lainnya
HISTCONTROL=ignoreboth

# tambahkan ke file riwayat(jangan ditimpa)
shopt -s histappend

# untuk mengatur panjang riwayat lihat HISTSIZE and HISTFILESIZE di bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# periksa ukuran jendela di setiap perintah(jika diperlukan)
# memperbarui nilai COLUMNS.
shopt -s checkwinsize

# Jika diatur, pola "**" yang digunakan dalam konteks perluasan nama jalur.
# mencocokkan semua file dan nol atau lebih direktori dan subdirektori.
#shopt -s globstar

# membuat less lebih ramah untuk file input non-teks, lihat lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# tetapkan variabel yang mengidentifikasi chroot tempat Anda(digunakan dalam prompt di bawah ini)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# menetapkan perintah yang menarik (non-warna)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# batalkan komentar untuk prompt berwarna
#mati secara default agar tidak mengganggu pengguna: berfokus di jendela terminal
# harus pada keluaran perintah, bukan pada prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # Kami memiliki dukungan warna; Ecma-48
        # (ISO/IEC-6429)
        # mendukung setf daripada setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Blok berikut dikelilingi oleh dua pembatas
# Pembatas ini tidak boleh diubah. Terima kasih.
# START KALI CONFIG VARIABLES
PROMPT_ALTERNATIVE=twoline
NEWLINE_BEFORE_PROMPT=yes
# STOP KALI CONFIG VARIABLES

if [ "$color_prompt" = yes ]; then
    # mengganti indikator virtualenv default dalam prompt
    VIRTUAL_ENV_DISABLE_PROMPT=1

    prompt_color='\[\033[;32m\]'
    info_color='\[\033[1;34m\]'
    prompt_symbol=㉿
    if [ "$EUID" -eq 0 ]; then # Mengubah warna prompt untuk pengguna root
        prompt_color='\[\033[;94m\]'
        info_color='\[\033[1;31m\]'
        # Skull emoji untuk root terminal
        #prompt_symbol=💀
    fi
    case "$PROMPT_ALTERNATIVE" in
        twoline)
            PS1=$prompt_color'┌──${debian_chroot:+($debian_chroot)──}${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)'$prompt_color')}('$info_color'\u'$prompt_symbol'\h'$prompt_color')-[\[\033[0;1m\]\w'$prompt_color']\n'$prompt_color'└─'$info_color'\$\[\033[0m\] ';;
        oneline)
            PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}'$info_color'\u@\h\[\033[00m\]:'$prompt_color'\[\033[01m\]\w\[\033[00m\]\$ ';;
        backtrack)
            PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ ';;
    esac
    unset prompt_color
    unset info_color
    unset prompt_symbol
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# xterm, tetapkan judulnya menjadi user@host:dir
case "$TERM" in
xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

[ "$NEWLINE_BEFORE_PROMPT" = yes ] && PROMPT_COMMAND="PROMPT_COMMAND=echo"

# mengaktifkan dukungan warna ls, less dan man
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
fi

# warna GCC untuk peringatan dan kerusakan
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# beberapa alias ls
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Alias definisi
# meletakkan semua tambahan Anda ke dalam file terpisah seperti
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# mengaktifkan fitur penyelesaian yang dapat diprogram (pengguna tidak perlu mengaktifkan)
# sudah di akfitkan pada /etc/bash.bashrc and /etc/profile
# sumber /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
