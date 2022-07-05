course-project
--------------------------------------------------------

in these project we are doing three tasks

1.we are creating an EC2 instance and assigning IAM role to the ec2 instance with Amazons3FullAccess, and also we are assigning security group to the ec2 instance with three ports enabled that are ssh port and http port and https port

2.in second task we are automating installation of apache server through script and also checking that whether it is running or not, and also we are creating tar file for apache2 logs and storing that tar files are stored in s3 bucket

3.in the third task we are creating a file named inventory.html in that it stores logs, whenever we create a tar file and appended in to the s3 bucket the logs of that stores in inventory.html file and also we are creating a cronjob to execute this automation script everyday
