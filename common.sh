color="\e[35m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"

nodejs()
{
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
}

mongo_schema_setup ()
{
  echo -e "\e[33mCopy mongodb repo\e[0m"
  cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
  echo -e "\e[33mInstalling mongodb client\e[0m"
  dnf install mongodb-org-shell -y &>>/tmp/roboshop.log
  echo -e "\e[33mLoad schema\e[0m"
  mongo --host mongodb-dev.devopsb96.store </app/schema/user.js &>>/tmp/roboshop.log
}

