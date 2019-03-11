# Ctrl Alt F2 -> better to work in simple CLI than a desktop
sudo apt-get install -y secure-delete 
sudo mkdir /apartment # create a temporary directory
sudo scp -rv /home/* /apartment/ # copy /home to temporary directory
sudo mkfs.ext4 /dev/sdb # recreate filesystem on device desired
sudo srm -lrvz /home # zero out /home
sudo mkdir /home # recreate /home directory
sudo mount -v /dev/sdb /home # mount device onto home
sudo rsync -ADhorX /apartment/* /home/ # copy temporary directory back to /home
cat /etc/mtab | grep home | sudo tee -a /etc/fstab # ensure system keeps new mount
sudo reboot # restart system