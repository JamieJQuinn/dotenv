# Python
eval (python -m virtualfish)

# RVM 
rvm default
set PATH /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/games /usr/local/games /snap/bin /home/jamie/.rvm/bin ~/.rvm/bin
function be
	bundle exec $argv
end
set RUBYGEMS_GEMDEPS -

function fish_user_key_bindings
  bind \cz fg
end

function a
	xdg-open $argv
end
