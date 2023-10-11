component=catalogue
color="\e[33m"
nocolor="\e[0m"
echo -e "${color}Configuring nodejs repos${nocolor}"

curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
echo -e "${color}Installing Nodejs Server${nocolor}"
dnf install nodejs -y &>>/tmp/roboshop.log
echo -e "${color}User add${nocolor}"
useradd roboshop &>>/tmp/roboshop.log
echo -e "${color}Create Application directory${nocolor}"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app
echo -e "${color}Download application${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>/tmp/roboshop.log
cd /app
echo -e "${color}Unzip File${nocolor}"
unzip /tmp/$component.zip &>>/tmp/roboshop.log
cd /app
echo -e "${color}Installing dependencies${nocolor}"
npm install &>>/tmp/roboshop.log
echo -e "${color}Update setup${nocolor}"
cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>/tmp/roboshop.log
echo -e "${color}Start service${nocolor}"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable $component &>>/tmp/roboshop.log
systemctl start $component &>>/tmp/roboshop.log
echo -e "${color}Copy mongodb repo${nocolor}"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
echo -e "${color}Installing mongodb client${nocolor}"
dnf install mongodb-org-shell -y &>>/tmp/roboshop.log
echo -e "${color}Load schema${nocolor}"
mongo --host mongodb-dev.devopsb96.store </app/schema/$component.js &>>/tmp/roboshop.log