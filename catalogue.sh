source common.sh
component=catalogue

nodejs
echo -e "${color}Copy mongodb repo${nocolor}"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>$log_file
echo -e "${color}Installing mongodb client${nocolor}"
dnf install mongodb-org-shell -y &>>$log_file
echo -e "${color}Load schema${nocolor}"
mongo --host mongodb-dev.devopsb96.store <${app_path}/schema/$component.js &>>$log_file