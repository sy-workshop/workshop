@echo off

echo "> Installing network drives ... "
echo "| > Cleaning up old drives "

net use O: /DELETE
net use S: /DELETE

echo "| > Installing new network drives ... "

net use O: "\\hub.local\archive"
net use S: "\\hub.local\labshare"

echo "done!"