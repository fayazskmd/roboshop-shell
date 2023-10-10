
echo -e "\e[33m diable mysql\e[0m"

dnf module disable mysql -y &>>/tmp/roboshop.log
echo -e "\e[33m copy mysql repo\e[0m"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo
echo -e "\e[33m install mysql\e[0m"
dnf install mysql-community-server -y &>>/tmp/roboshop.log
echo -e "\e[33m start mysql\e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log
echo -e "\e[33m mysql password\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log
