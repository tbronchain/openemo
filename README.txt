Patch aimed to make the Emotic EPOC EEG headset working on Linux with OpenViBE
Tested on Ubuntu 12.04

1- Download the openemo patch
	-> we will assumes that the sources are located in "$HOME/openemo"
2- Install Emotiv EPOC installer
	-> let's assume that the installation folder is "$HOME/EmotivEducation_1.0.0.5"
3- Install subversion
	-> sudo apt-get install subversion
4- Checkout openvibe sources (let's assumer that you are downloading them in your home folder)
	-> cd && svn checkout svn://scm.gforge.inria.fr/svn/openvibe/trunk openvibe
5- Patch openvibe sources using the script "patchEmotiv.sh"
	-> you can modify the user variables at the head of the script if needed
	-> cd ~/openemo && bash patchEmotiv.sh
6- Compile openvibe
	-> cd ~/openvibe/scripts
	-> sudo su
	-> ./linux-install_dependencies #(select yes on native package installation)
	-> ./linux-build
