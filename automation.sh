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
        systemctl enable apache2
fi

tar -cvf /root/Automation_project/$name-httpd-logs-$timestamp.tar /var/log/apache2/access.log
tar -rvf /root/Automation_project/$name-httpd-logs-$timestamp.tar /var/log/apache2/error.log
cp  /root/Automation_project/$name-httpd-logs-$timestamp.tar /tmp/
if [ -e /root/Automation_project/$name-httpd-logs-$timestamp.tar ]
then
	aws s3 mv /tmp/$name-httpd-logs-$timestamp.tar s3://$bucket
else
	continue
fi

if [ -e /var/www/html/inventory.html ]
then
	continue

else
	echo "Log Type		Time Created		Type		Size " > /var/www/html/inventory.html 
fi

size2="/root/Automation_project/$name-httpd-logs-$timestamp.tar"

size1=$(du -sh $size2 | awk '{print$1}')


echo -e "httpd-logs		$timestamp		Tar		$size1" >> /var/www/html/inventory.html



cr="0 0 * * * /bin/bash /root/Automation_project/automation.sh"
if [ -e /etc/cron.d/automation ]
then
        continue
else
        touch /etc/cron.d/automation
        echo "$cr" > /etc/cron.d/automation
        touch /root/Automation_project/cronjob-creating
        crontab -l > /root/Automation_project/cronjob-creating
        echo "$cr" > /root/Automation_project/cronjob-creating
        crontab cronjob-creating
fi

