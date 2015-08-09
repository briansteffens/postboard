# postboard
Originally meant to share links and bits of text across computers or between
people, it pretty much ended up being an anonymous message board. Anyone can
create new boards, which are managed with a moderator password. Boards can
be listed (showing up on the main page) or unlisted (requires knowing or
guessing the board URL).

# Dependencies
The host requires Git, Vagrant, and VirtualBox. On Debian-based systems, the
following should get everything needed:
```
$ sudo apt-get install git vagrant virtualbox
```

# Downloading
Use Git to download the source code. The `--recursive` flag is needed to
include submodules.
```
$ git clone --recursive https://github.com/briansteffens/postboard
$ cd postboard
```

# Building the development VM
Use Vagrant to build the development VM:
```
$ vagrant up
$ vagrant ssh
$ cd /vagrant/postboard
```

# First-time setup
The first time the VM is built, Rails dependencies must be downloaded and the
database must be created and migrated.
```
bundle install
rake db:create
rake db:migrate
```

# Running the app
Start the rails server, binding to all network interfaces:
```
rails s -b 0.0.0.0
```
The app should now be accessible through a browser at the URL
http://localhost:9090/.

After the initial setup, the VM can be brought back up faster by using
`vagrant/up` which also sets up a tmux session and starts the Rails server
automatically.
