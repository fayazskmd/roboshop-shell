echo -e "\e[33m install python\e[0m"

dnf install python36 gcc python3-devel -y &>>/tmp/roboshop.log
echo -e "\e[33m user add\e[0m"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[33m app directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log
echo -e "\e[33m download\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[33m unzip\e[0m"
unzip /tmp/payment.zip &>>/tmp/roboshop.log


echo -e "\e[33m install dependencies\e[0m"
cd /app
pip3.6 install -r requirements.txt &>>/tmp/roboshop.log
 echo -e "\e[33m configure payment service\e[0m"
cp /home/centos/roboshop-shell/payment.service /etc/systemd/system/payment.service

echo -e "\e[33m start payment servicesl\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log

systemctl enable payment &>>/tmp/roboshop.log
systemctl restart payment &>>/tmp/roboshop.log