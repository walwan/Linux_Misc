## Aliases
# Alias from Manjaro default profile
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'

alias ll='ls -lh'
alias la='ls -ah'
alias lla='ls -lah'

alias du='du -h'
alias du1='du -h --max-depth=1'

alias restronedrive='systemctl --user restart onedrive'
alias stoponedrive='systemctl --user stop onedrive'
# alias logonedrive='journalctl --user-unit=onedrive -f'
alias logonedrive='/home/ww/WW/Misc/onedrive_log/onedrive_log'

alias setcapnodelay='sudo systemctl restart capnodelay'
alias logcapnodelay='journalctl -u capnodelay'

alias connsjtustuvpn='sudo ipsec up SJTU_Stu_Proxy'
alias discsjtustuvpn='sudo ipsec down SJTU_Stu_Proxy'
alias logsjtustuvpn='journalctl -b -f -u strongswan-starter.service'

alias setgithubname='git config --local user.name walwan'
alias setgithubemail='git config --local user.email 11062281+walwan@users.noreply.github.com'

alias pkginfo='pacman -Qi'
alias pkgsearch='pamac search'

## Functions
unsetproxy(){
	unset http_proxy
	unset https_proxy
	echo "HTTP proxy settings unset!"
}

setproxy(){
	export http_proxy="http://127.0.0.1:7891/"
	export https_proxy="http://127.0.0.1:7891/"
	echo "HTTP proxy settings set!"
}
