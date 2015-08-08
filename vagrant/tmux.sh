#!/bin/bash

tmux new-session -d -s postboard -n web
tmux send-keys -t postboard "vagrant ssh -c \"bash -c 'cd /vagrant/postboard; exec bash'\"" ^m "rails server -b 0.0.0.0" ^m
sleep 1

tmux new-window -n "db"
tmux send-keys -t postboard "vagrant ssh -c \"exec bash\"" ^m "mysql -u root -D postboard_development" ^m
sleep 1

tmux new-window -n "tests"
tmux send-keys -t postboard "vagrant ssh -c \"bash -c 'cd /vagrant; exec bash'\"" ^m "python3 "
sleep 1

tmux attach -t postboard
