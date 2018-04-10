#!/usr/bin/fish

sudo nano /etc/fish/functions/zen-init.fish
function zen-init --on-event zen.init -d 'Initialize primary tmux window'
  if builtin test (builtin count (zen command list-windows)) -le 1
    zen tmux split-window -h
    zen tmux send-keys -t "0:0.2" 'command htop' Enter
    zen tmux resize-pane -R 35
    zen tmux send-keys -t "0:0.1" 'command clear' Enter
    zen tmux select-pane -t "0:0.1"
  end
end
