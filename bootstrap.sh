# bootstrap.sh
#
# * Install puppet
# * Install rsync
# * Add SSH key to root user
#
# This should be run as the root user on the host
#
ssh_key="ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIEAvB0+RxQ4kEBOAEPR2gdUAlPFfQZzYE7MnJohpDlPRCYbgb+GyvSNUNgaYPEZ/l4H0oSg4IYTSCshjQpep1KZDGditf+YE6CCvENwmt00CyTdNIKOTeKUQab7cm5DhU7c1OWOegDazJdwe8I3bJI4R2Ynt6Kwmq/K8nwY4dSPYTk= eric.harth@re-m.com"

yum makecache
yum -y install puppet rsync

# For CentOS 5.x
#wget http://download.fedoraproject.org/pub/epel/5/i386/epel-release-5-4.noarch.rpm && rpm -ivh epel-release-5-4.noarch.rpm
# For CentOS 6.x
wget http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm && rpm -ivh epel-release-6-8.noarch.rpm

mkdir -p /root/.ssh/
chmod 700 /root/.ssh/
echo $ssh_key > /root/.ssh/authorized_keys
