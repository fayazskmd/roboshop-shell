
echo -e "\e[33mConfiguring nodejs repos\e[0m"

curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
echo -e "\e[33mInstalling Nodejs Server\e[0m"
dnf install nodejs -y &>>/tmp/roboshop.log
echo -e "\e[33mUser add\e[0m"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[33mCreate Application directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app
echo -e "\e[33mDownload application\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[33mUnzip File\e[0m"
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[33mInstalling dependencies\e[0m"
npm install &>>/tmp/roboshop.log
echo -e "\e[33mUpdate setup\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log
echo -e "\e[33mStart service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl start catalogue &>>/tmp/roboshop.log
echo -e "\e[33mCopy mongodb repo\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
echo -e "\e[33mInstalling mongodb client\e[0m"
dnf install mongodb-org-shell -y &>>/tmp/roboshop.log
echo -e "\e[33mLoad schema\e[0m"
mongo --host mongodb-dev.devopsb96.store </app/schema/catalogue.js &>>/tmp/roboshop.log