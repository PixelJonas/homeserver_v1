# dont install all the junk
echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf.d/99local
echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/99local

# Configure APT to use Docker-Repo
apt-get install apt-transport-https ca-certificates

sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

apt-get install zfs docker.io powertop hdparm

# powertop
echo "powertop --auto-tune" >>  /etc/rc.local
echo "exit 0" >>  /etc/rc.local

# Ab hier automatisch :)
