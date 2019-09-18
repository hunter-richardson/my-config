sudo mkdir /apartment # create disk directory
sudo mkfs.ext4 /dev/sdb # recreate filesystem on device desired
sudo mount -v /dev/sdb /apartment # mount device onto directory
grep 'home' /etc/mtab | sudo tee -a /etc/fstab # ensure system keeps new mount
