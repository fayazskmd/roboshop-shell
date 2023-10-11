source common.sh

echo -e "${color}Installing Nginx Server${nocolor}"

dnf install nginx -y &>>/tmp/roboshop.log
echo -e "${color}Removing Old App Content${nocolor}"
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log
echo -e "${color}Downloading Frontend Content${nocolor}"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log
echo -e "${color}Extract Frontend Content${nocolor}"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/roboshop.log

# we need to copying
echo -e "${color}UPDATE frontend configuration${nocolor}"
cp /home/centos/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "${color}Starting Nginx Server${nocolor}"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log