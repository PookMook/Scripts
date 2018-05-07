#!/bin/sh

### Variables here
email = YourEmail@domain.com


sudo apt-get install git
sudo apt-get install chromium-browser gimp vlc
wget https://az764295.vo.msecnd.net/stable/7c7da59c2333a1306c41e6e7b68d7f0caa7b3d45/code_1.23.0-1525361119_amd64.deb
sudo dpkg -i code_1.23.0-1525361119_amd64.deb

#Docker
sudo apt install docker.io docker-compose


#Set you public identity, add it to your github account
ssh-keygen -t rsa -b 4096 -C $email
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
sudo npm install npm@latest -g


#check install
sudo docker run hello-world
docker-compose --version
node -v

echo "add the following public key to your github account :"
cat ~/.ssh/id_rsa
