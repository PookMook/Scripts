#!/bin/sh

### Variables here
dockerComposeVersion = 1.14.0
email = YourEmail@domain.com


sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install terminator git chromium-browser -y
wget https://atom.io/download/deb
sudo dpkg -i deb
rm deb
sudo apt-get -f install

wget https://downloads.slack-edge.com/linux_releases/slack-desktop-2.6.3-amd64.deb
sudo dpkg -i slack-desktop-2.6.3-amd64.deb
rm slack-desktop-2.6.3-amd64.deb
sudo apt-get -f install


sudo apt-get update
sudo apt-get install gimp vlc unity-tweak-tool -y

sudo apt-get remove docker docker-engine
sudo apt-get update
sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce
curl -L https://github.com/docker/compose/releases/download/$dockerComposeVersion/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
sudo npm install npm@latest -g

#Set you public identity, add it to your github account
ssh-keygen -t rsa -b 4096 -C $email
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa


#check install
sudo docker run hello-world
docker-compose --version
node -v

cat "add the following public key to your github account :"
cat ~/.ssh/id_rsa
