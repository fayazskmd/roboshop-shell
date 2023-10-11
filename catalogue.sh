source common.sh
component=catalogue
echo -e "${color}Configuring nodejs repos${nocolor}"

curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
echo -e "${color}Installing Nodejs Server${nocolor}"
dnf install nodejs -y &>>$log_file
echo -e "${color}User add${nocolor}"
useradd roboshop &>>$log_file
echo -e "${color}Create Application directory${nocolor}"
rm -rf ${app_path} &>>$log_file
mkdir ${app_path}
echo -e "${color}Download application${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>$log_file
cd ${app_path}
echo -e "${color}Unzip File${nocolor}"
unzip /tmp/$component.zip &>>$log_file
cd ${app_path}
echo -e "${color}Installing dependencies${nocolor}"
npm install &>>$log_file
echo -e "${color}Update setup${nocolor}"
cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>$log_file
echo -e "${color}Start service${nocolor}"
systemctl daemon-reload &>>$log_file
systemctl enable $component &>>$log_file
systemctl start $component &>>$log_file
echo -e "${color}Copy mongodb repo${nocolor}"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>$log_file
echo -e "${color}Installing mongodb client${nocolor}"
dnf install mongodb-org-shell -y &>>$log_file
echo -e "${color}Load schema${nocolor}"
mongo --host mongodb-dev.devopsb96.store <${app_path}/schema/$component.js &>>$log_file