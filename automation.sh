name="jayakrishna"
bucket="upgrad-jayakrishna"
timestamp=$(date '+%d%m%Y-%H%M%S')
apt update -y
dpkg --get-selections | grep -i "apache2"
var=$(echo $?)
if [ $var -eq 0 ]
then
        continue
else
        apt install apache2
fi
systemctl status apache2
a=$(echo $?)
if [ $a -eq 0 ]
then
        continue
else
        systemctl start apache2
fi
systemctl enable apache2
var1=$(echo $?)
if [ $var1 -eq 0 ]
then
        continue
else
        systemctl disable apache2
fi

tar -cvf $name-httpd-logs-$timestamp.tar /var/log/apache2/access.log
tar -rvf $name-httpd-logs-$timestamp.tar /var/log/apache2/error.log
cp -f $name-httpd-logs-$timestamp.tar /tmp/
if [ -e /root/Automation_project/$name-httpd-logs-$timestamp.tar ]
then
	aws s3 mv /tmp/$name-httpd-logs-$timestamp.tar s3://$bucket
else
	continue
fi
