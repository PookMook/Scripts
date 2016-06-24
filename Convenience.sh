#!/bin/sh
sudo apt-get update
sudo apt-get install gimp vlc -y
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window true
gsettings set com.canonical.Unity.Launcher launcher-position Bottom
