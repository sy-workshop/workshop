echo "#############################"
echo "#    SYHUB UPDATE SCRIPT    #"
echo "#############################"
echo ""

# Set variables
export INSTALL_DIR="/opt/workshop"
export SYHUB_SERVICE_FILE="/etc/systemd/system/syhub.service"

echo "> Configuration: "
echo "| - Installation directory: $INSTALL_DIR"
echo "| - Service file destination: $SYHUB_SERVICE_FILE"

# Go into directory
cd "$INSTALL_DIR"

sudo systemctl stop syhub

# Give all permissions
sudo chmod a+rwx "$INSTALL_DIR"
sudo chmod -R 777 "$INSTALL_DIR"

# Update git repo
echo "> Updating git repo ... "
git fetch
git pull
git update

# Give all permissions
sudo chmod a+rwx "$INSTALL_DIR"
sudo chmod -R 777 "$INSTALL_DIR"

# Remove service file if it exists
if [ -f "$SYHUB_SERVICE_FILE" ]; then
    echo "> Service file found! Removeing ... " 
    sudo rm -f "$SYHUB_SERVICE_FILE"
fi

# Install new service file to system
sudo cp "syhub/syhub.service" "$SYHUB_SERVICE_FILE"

cd "syhub"

cargo build

cd ".."

# Reload systemd
sudo systemctl daemon-reload

# Start service
sudo systemctl start syhub

# Helper restart
sudo systemctl restart syhub

echo "> Update done! Thank you."