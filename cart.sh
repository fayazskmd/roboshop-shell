
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
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[33mUnzip File\e[0m"
unzip /tmp/cart.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[33mInstalling dependencies\e[0m"
npm install &>>/tmp/roboshop.log
echo -e "\e[33mUpdate setup\e[0m"
cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log
echo -e "\e[33mStart service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable cart &>>/tmp/roboshop.log
systemctl start cart &>>/tmp/roboshop.log
