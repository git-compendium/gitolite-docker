#!/bin/sh

echo $ADMIN_KEY > /tmp/admin.pub
su - git -c "/home/git/bin/gitolite setup -pk /tmp/admin.pub"

exec /usr/sbin/sshd -D
