echo ""
echo "##############################"
echo "#    SYHUB INSTALL SCRIPT    #"
echo "##############################"
echo "|"

# Set variables
export INSTALL_DIR="/opt/workshop"
export SYHUB_SERVICE_FILE="/etc/systemd/system/syhub.service"

echo "> Configuration: "
echo "| - Installation directory: '$INSTALL_DIR'"
echo "| - SyHub service file destination: '$SYHUB_SERVICE_FILE'"

# Remove current install if it exists
if [ -d "$INSTALL_DIR" ]; then
    echo "> Installation found! Removing ... "
    sudo rm -d -R "$INSTALL_DIR"
fi

# Remove service file if it exists
if [ -f "$SYHUB_SERVICE_FILE" ]; then
    echo "> SyHub service file found! Removing ... " 
    sudo rm -f "$SYHUB_SERVICE_FILE"
fi

# Install repo to system
sudo cp -r ./ "$INSTALL_DIR"
sudo cp "syhub/syhub.service" "$SYHUB_SERVICE_FILE"

# Give all permissions
sudo chmod a+rwx "$INSTALL_DIR"
sudo chmod -R 777 "$INSTALL_DIR"

echo "> Installing syhub ... "

cd "syhub"

cargo build

cd ".."

# Reload systemd
sudo systemctl daemon-reload

# Start service
sudo systemctl start syhub
sudo systemctl enable syhub

# Helper restart
sudo systemctl restart syhub

echo "> INSTALLATION DONE! Thank you."