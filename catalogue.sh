#!/bin/bash



source ./common.sh
app_name=catalogue

check_root
app_setup
nodejs_setup
systemd_setup


cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-mongosh -y &>>$LOG_FILE
VALIDATE $? "Installing MngoDB Client"

STATUS=$(mongosh --host MONGODB-SERVER-IPADDRESS --eval 'db.getMongo().getDBNames().indexof("Catalogue")') #to check if db is already there, if output(-1), them db is not there
if [ $STATUS -lt 0 ]
then
    mongosh --host MONGODB-SERVER-IPADDRESS </app/db/master-data.js &>>$LOG_FILE #change the IP ADDRESS
    VALIDATE $?  "LOADING DATA into MongoDB"
else
    echo -e "Data is already loaded.. $Y SKIPPING $N"
fi

print_time



#less /var/log/roboshop-logs/catalogue.log (for logs)