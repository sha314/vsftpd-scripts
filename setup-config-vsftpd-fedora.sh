dnf install vsftpd ftp



## Create ftp user james
adduser james
passwd james


## Copy configurations to /etc/vsftpd
cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.bak
cp vsftpd.conf /etc/vsftpd/
cp vsftpd.userlist  /etc/vsftpd/vsftpd.userlist
# secure_chroot_dir
mkdir -p /home/vsftpd/empty
mkdir -p /home/james/ftp/ftp_shared


# restart vsftpd
systemctl enable vsftpd
systemctl restart vsftpd
systemctl status vsftpd


ip address

# log in to your localhost
# you may want to replace the localhost text by your network IP
ftp localhost

# this will may work initially
# SELinux will prevent you
# you need to relabel things and set booleans
getenforce
setenforce 0
getenforce

# Now the SELinux is in permissive mode and you can run
ftp localhost
# SELinux will still log the error messages and we can fix it.

# SE troubleshoot will show some error messages
# You can use journalctl
journalctl --since "5 minutes  ago"

# journal control will show you some suggestion to repair things

# probably the following two commands will solve the problem
restorecon -v /home/vsftpd/empty
setsebool -P ftpd_full_access 1


# Now turn on the enforcing and try to log in to ftp
setenforce 1
getenforcing
ftp localhost



### Configuring firewall
##You need to add the port and service to firewall
# To add port 20
firewall-cmd --zone=public --add-port=20/tcp
firewall-cmd --add-service=ftp

firewall-cmd --permanent --zone=public --add-port=20/tcp
firewall-cmd --permanent --add-service=ftp
firewall-cmd --list-all

#If you want it to be permanent then add "--permanent" to first two command






