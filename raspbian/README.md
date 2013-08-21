## Raspbian
This directory contains all my stuff related to Raspbian

* post-install.sh : script to run all the post-install
* config : configuration's files for programms (ie : samba, minidlna etc.)
* dotfiles : configuration's files for home directory user


### Install script

To install you could use the [post-install script](https://github.com/moriame/raspberry/blob/master/raspbian/postinstall_raspbian.sh) using cURL:

    curl https://raw.github.com/moriame/raspberry/master/raspbian/post-install.sh | sudo sh

or Wget:

    wget -qO- https://raw.github.com/moriame/raspberry/master/raspbian/post-install.sh | sudo sh
