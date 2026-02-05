#!/bin/bash


source ./common.sh
app_name=mongodb

check_root

cp mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "Coping MangoDB repo"

dnf install mongodb-org -y &>>$LOG_FILE
VALIDATE $? "Installing mongodb server"

systemctl enable mangod &>>$LOG_FILE
VALIDATE $? "Enabling MongoDB"

systemctl start mongod &>>$LOG_FILE
VALIDATE $? "starting MongoDB"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "Editing MongoDB conf file for remote connectios"

systemctl restart mongod &>>$LOG_FILE
VALIDATE $? "Restarting MogoDB"

print_time

# sed editor --> stream editor

# adding the lines
# deleting the lines
# replace the words

# sed -i/-e 'expression' filename

# adding the line

# sed -e '1 a Hello Wolrd' users (i insert after first line)
# sed -i '1 a Hello Wolrd' users

# sed -i '1 i Hello Wolrd' users(i insert before first line)

# -e --> temp change onto the screen
# -i --> perm change

# sed -i '1 d' users (deleting the line)
# sed -e '1 d' users (deleting the line)(e visible on screen)

# sed -e 's/root/ADMINS/' users (replacing root word with ADMINS)
# sed -e 's/root/ADMINS/g' users (replacing root word with ADMINS in entire line)
# sed -e '/Overflow/ d' users  ( deleting perticual word line)