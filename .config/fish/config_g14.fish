if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket

set PATH ~/.zvm/bin $PATH
