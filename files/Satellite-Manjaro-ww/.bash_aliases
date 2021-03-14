## Aliases
# Alias from Manjaro default profile
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'

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
	PROXY_ENV=(	http_proxy
				ftp_proxy
				https_proxy
				all_proxy
				rsync_proxy
				HTTP_PROXY
				HTTPS_PROXY
				FTP_PROXY
				ALL_PROXY
				RSYNC_PROXY)

	for envar in $PROXY_ENV; do
       unset $envar
    done
	
	if test -z $1 || test $1 != "NO_OUTPUT"; then
		echo "HTTP proxy settings unset!"
	fi
}

setproxy(){
	proxy_setting="http://127.0.0.1:7891/"
	no_proxy_setting="localhost,127.0.0.1,LocalAddress,LocalDomain.com"

	PROXY_ENV=(	http_proxy
				ftp_proxy
				https_proxy
				all_proxy
				rsync_proxy
				HTTP_PROXY
				HTTPS_PROXY
				FTP_PROXY
				ALL_PROXY
				RSYNC_PROXY)

   	for envar in $PROXY_ENV; do
      	export $envar=$proxy_setting
   	done

	for envar in no_proxy NO_PROXY; do
		export $envar=$no_proxy_setting
	done

	if test -z $1 || test $1 != "NO_OUTPUT"; then
		echo "HTTP proxy settings set!"
	fi
}
