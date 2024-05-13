--- Mac Setup ---
This repository contains instructions organised into a single Makefile to
streamline setting up a new Mac.

--- Steps ---
* Old machine *
make old

* New machine *
mkdir -p ~/developer/admin && git clone git@github.com:ericjanto/mac-setup.git ~/developer/admin/mac-setup/
cd ~/developer/admin/
make

--- TODO ---
Include dotfiles in this repository
Code review the Makefile
Sometimes the default make target won't be able to run through all steps - for
    this case, don't run through steps that have already been complete