echo "##########################"
echo "#    HUB SETUP SCRIPT    #"
echo "##########################"
echo ""
echo "> Version: Mk1.0.0/2024/10/14"
echo ""

# Update apt
echo "> Updating APT ... "
sudo apt update
sudo apt upgrade

# Install essentials
sudo apt insall build-essential checkinstall -y

# Install dependencies
echo ""
echo "> Installing programming languages ... "
sudo apt install python3        
sudo apt install python3-pip
sudo apt install lua5.4
curl https://sh.rustup.rs -sSf | sh -s -- -y

# Install repos
git submodule update --init --recursive

# Installing cool services
## Mosquitto
echo ""
echo "> Installing mosquitto ... "
sudo apt install mosquitto
sudo cp mosquitto.conf /etc/mosquitto/mosquitto.conf
sudo service mosquitto restart

## Samba
echo ""
echo "> Installing samba ... "
sudo apt install samba
mkdir /home/sy/labshare
sudo cp smb.conf /etc/samba/smb.conf
sudo service smbd restart
sudo ufw allow samba

## Nextcloud dependencies
sudo apt install apache2


# Installing syhub
cd syhub
sudo sh install.sh
cd ..

echo ""
echo "> Installation done!"
echo " => Starting configuration prompts: "

sudo smbpasswd -a sy