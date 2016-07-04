# Python
#eval (python -m virtualfish)

# RVM 
#set PATH $PATH ~/.rvm/bin
#rvm default
#alias be="bundle exec"
#set RUBYGEMS_GEMDEPS -

# ASDF
#source ~/.asdf/asdf.fish

function fish_user_key_bindings
  bind \cz fg
end

function a
	xdg-open $argv
end
