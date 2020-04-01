#!/bin/bash

###############
# RUN AS A ROOT #
###############

SUDO_USER="foo"

SOME_USER="bar"

#PUBLIC_KEY="ssh-rsa AAAA ... rsa-key-foo"

apt install curl htop vim mc

apt update && apt upgrade 

adduser $SUDO_USER
usermod -aG sudo $SUDO_USER

mkdir $HOME/.ssh
#echo $PUBLIC_KEY > $HOME/.ssh/authorized_keys
touch $HOME/.ssh/authorized_keys
chmod go-w $HOME $HOME/.ssh
chmod 600 $HOME/.ssh/authorized_keys
chown $WHOAMI $HOME/.ssh/authorized_keys
systemctl restart sshd

echo -e "syntax on\n set autoindent\n set background=dark\n set incsearch\n set hlsearch" >> $HOME/.vimrc

echo "alias l.='ls -d .* --color=auto'
#alias subdomainFoo='cd /var/www/html/sub.domain.com'
#alias exampleFoo='cd /var/www/html/example.com'

alias ports='netstat -tulanp'

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../' 
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..' ">> $HOME/.bashrc
source $HOME/.bashrc

#Install 2FA
apt install libpam-google-authenticator && google-authenticator
echo "auth [success=done default=ignore] pam_succeed_if.so user ingroup without-otp" >> /etc/pam.d/sshd 
echo "auth requigroured pam_google_authenticator.so" >> /etc/pam.d/sshd
# DO NOT CHANGE THE SEQUENCE OF ABOVE LINES
sed -i 's/UsePAM no/UsePAM yes/' /etc/ssh/sshd_config
sed -i 's/\(ChallengeResponseAuthentication\) yes/\1 no/g' /etc/ssh/sshd_config
systemctl restart sshd.service

groupadd without-otp
usermod -a -G without-otp $SOME_USER
service sshd restart

#Install ffsend
cd $HOME
wget https://github.com/timvisee/ffsend/releases/download/v0.2.58/ffsend-v0.2.58-linux-x64-static
mv ./ffsend-* ./ffsend
chmod a+x ffsend
mv ./ffsend /usr/local/bin/

mkdir /backup/

#curl https://rclone.org/install.sh | sudo bash
#rclone config

echo "#!/bin/bash

rm -rf /backup/old
mv /backup/new/* /backup/old/
mkdir /backup/new

mkdir -p /backup/from_root

cp -aR -- .config /root/backup/from_root
cp -aR -- /root/.[bglmnpsvw]* /backup/from_root/

TIME=$(date +"%m-%d-%Y")

FILENAME=backup-root-$TIME.tar.gz
SRCDIR=/backup/from_root/
DESDIR=/backup/new/
tar -cvpzf $DESDIR/$FILENAME $SRCDIR

FILENAME=backup-etc-$TIME.tar.gz
SRCDIR=/etc/
DESDIR=/backup/new/
tar -cvpzf $DESDIR/$FILENAME $SRCDIR

FILENAME=backup-var-www--$TIME.tar.gz
SRCDIR=/var/www/
DESDIR=/backup/new/
tar -cvpzf $DESDIR/$FILENAME $SRCDIR

FILENAME=backup-var-log-$TIME.tar.gz
SRCDIR=/var/log/
DESDIR=/backup/new/
tar -cvpzf $DESDIR/$FILENAME $SRCDIR

rm -rf /backup/from_root/.[^.]*

#rclone copy /backup/new/ mega:server  --buffer-size 0M" > /root/backup.sh

chmod +x backup.sh

# Add it to cron:
# 00 04 * * * /bin/sh  /root/backup.sh
