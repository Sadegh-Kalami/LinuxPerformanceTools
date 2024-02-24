free -h
# 30G /swapfile size of sawpfile
echo '<SYSTEM-Password>' | sudo -S fallocate -l 30G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show
<<<<<<< HEAD
free -h 
=======
free -h
>>>>>>> 6551db5447f2fb0d470ab64203b92f25268f4598
