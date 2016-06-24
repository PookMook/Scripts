#!/bin/sh
sudo apt-get update
sudo apt-get install gimp vlc unity-tweak-tool -y
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window true
gsettings set com.canonical.Unity.Launcher launcher-position Bottom

#windows10 theme
sudo add-apt-repository ppa:noobslab/themes
sudo apt-get update
sudo apt-get install windos-10-themes

#Moka icons
sudo add-apt-repository ppa:moka/stable
sudo apt-get update
sudo apt-get install moka-icon-theme
