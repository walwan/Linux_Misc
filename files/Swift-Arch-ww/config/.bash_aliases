## Aliases
# Alias from Manjaro default profile
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB

alias lat='ls -laht'

alias du='du -h'
alias du1='du -hd1'

# Personal aliases
alias v='nvim'
alias sv='sudo nvim'
alias R='source ranger'
alias o='xdg-open'

alias yay='yay --removemake'
alias yaye='yay --removemake --editmenu'

alias gits='git status'
alias gitss='git status -s'
alias gitd='git diff'
alias gitdc='git diff --cached'
alias gitl='git log'
alias gitsh='git show'
alias gita='git add'
alias gitau='git add -u'
alias gitc='git commit'
alias gitca='git commit -a'
alias gitcam='git commit --amend'
alias gitp='git push'
alias gitf='git fetch'
alias gitfa='git fetch --all'

alias restronedrive='systemctl --user restart onedrive'
alias stoponedrive='systemctl --user stop onedrive'
# alias logonedrive='journalctl --user-unit=onedrive -f'
alias logonedrive='/home/ww/WW/Misc/onedrive_log/onedrive_log'

#alias setcapnodelay='sudo systemctl restart capnodelay'
#alias logcapnodelay='journalctl -u capnodelay'

#alias connsjtustuvpn='sudo ipsec up SJTU_Stu_Proxy'
#alias discsjtustuvpn='sudo ipsec down SJTU_Stu_Proxy'
#alias logsjtustuvpn='journalctl -b -f -u strongswan-starter.service'

alias setgithubname='git config --local user.name walwan'
alias setgithubemail='git config --local user.email 11062281+walwan@users.noreply.github.com'
alias setumgitlabname='git config --local user.name "Walter W"'
alias setumgitlabemail='git config --local user.email 5600-walwan@users.noreply.gitlab.umich.edu'

alias pkginfo='yay -Qi'
alias pkgsearch='yay -Ss'
alias pkgsearchi='yay -Qs'
alias checkpkgupdate='yay -Qu'

alias jicanvasfd='cd $JICANVAS'
alias umcanvasfd='cd $UMCANVAS'

alias poweroff='systemctl poweroff'
alias shutdown='systemctl poweroff'
alias halt='systemctl halt'
alias reboot='systemctl reboot'
alias sleep='systemctl suspend'
alias suspend='systemctl suspend'
alias hibernate='systemctl hibernate'
alias hsleep='systemctl hybrid-sleep'

# alias for screen display configuration
## SJTU Dorm
#alias scr_sjtu_dorm_mon_on='kscreen-doctor output.HDMI-0.enable output.HDMI-0.position.0,0 output.LVDS.position.0,1080 output.HDMI-0.mode.99'
#alias scr_sjtu_dorm_mon_off='kscreen-doctor output.HDMI-0.disable output.LVDS.position.0,0'

## TR
#alias scr_tr_mon_on='xrandr --output "HDMI-0" --auto --primary --mode 1920x1080 --rate 60 --left-of "LVDS"'
#alias scr_tr_mon_off='xrandr --output "LVDS" --primary --output "HDMI-0" --off'

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
