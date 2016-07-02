set PATH /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/games /usr/local/games /snap/bin /home/jamie/.rvm/bin ~/.rvm/bin
rvm default
function be
	bundle exec $argv
end
set RUBYGEMS_GEMDEPS -
set EDITOR /usr/bin/vim

function a
	xdg-open $argv
end

function t 
  eval $arvg
  notify-send "$argv complete" 
end

function sendtext 
  curl http://textbelt.com/intl -d number="07473957183" -d "message=$argv"
end
