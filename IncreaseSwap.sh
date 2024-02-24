free -h
# 30G /swapfile size of sawpfile
echo '<SYSTEM-Password>' | sudo -S fallocate -l 30G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show
free -h 