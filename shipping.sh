#!/bin/bash

source ./cpmmon.sh
app_name=shipping

check_root
echo "Please enter root password to setup"
read -s MYSQL_ROOT_PASSWORD


app_setup
maven_setup
systemd_setup

mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -p$MYSQL_ROOT_PASSWORD -e 'use cities'
if [ $? -ne 0 ]
then
    mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/schema.sql &>>$LOG_FILE
    mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/app-user.sql &>>$LOG_FILE
    mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/master-data.sql &>>$LOG_FILE
    VALIDATE $? "Loading data into MySQL"
else
    echo -e "Data is already loaded into MySQL ... $Y SKIPPING $N"
fi

systemctl restart shipping &>>$LOG_FILE
VALIDATE $? "Restart Shipping"

print_time

##CHANGE THE IP ADDRESS"
#PW RoboShop@1
# to check if PW is correct and connected
#mysql -h <MYSQL-SERVER-IPADDRESS> -u root -pRoboshop@1
#mysql -h I<MYSQL-SERVER-IPADDRESS> -u root -pRoboshop@1 -e 'user cities' , to check if schema is created exit code echo $? should be 0
