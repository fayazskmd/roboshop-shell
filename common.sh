color="\e[35m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"
app_presetup()
{
    echo -e "${color}User add${nocolor}"
  useradd roboshop &>>$log_file
  echo $?
   echo -e "${color}Create Application directory${nocolor}"
   rm -rf ${app_path} &>>$log_file
     mkdir ${app_path}
     echo $?
      echo -e "${color}Download application${nocolor}"
       curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>$log_file

       cd ${app_path}
        echo $?
       echo -e "${color}Unzip File${nocolor}"
         unzip /tmp/$component.zip &>>$log_file

         cd ${app_path}
          echo $?
   }
nodejs()
{
  echo -e "${color}Configuring nodejs repos${nocolor}"

  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
  echo -e "${color}Installing Nodejs Server${nocolor}"
  dnf install nodejs -y &>>$log_file

  app_presetup



  echo -e "${color}Installing dependencies${nocolor}"
  npm install &>>$log_file
  echo -e "${color}Update setup${nocolor}"
  cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>$log_file
  echo -e "${color}Start service${nocolor}"
  systemctl daemon-reload &>>$log_file
  systemctl enable $component &>>$log_file
  systemctl start $component &>>$log_file
}

mongo_schema_setup()
{
  echo -e "${color}Copy mongodb repo${nocolor}"
  cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}
  echo -e "${color}Installing mongodb client${nocolor}"
  dnf install mongodb-org-shell -y &>>${log_file}
  echo -e "${color}Load schema${nocolor}"
  mongo --host mongodb-dev.devopsb96.store <${app_path}/schema/$component.js &>>${log_file}
}

maven()
{

echo -e "${color} install maven${nocolor}"
dnf install maven -y &>>${log_file}
app_presetup

echo -e "${color} cleaned package${nocolor}"
mvn clean package &>>${log_file}
mv target/shipping-1.0.jar shipping.jar &>>${log_file}

echo -e "${color} install mysql${nocolor}"
dnf install mysql -y &>>${log_file}
echo -e "${color} mysql client${nocolor}"
mysql -h mysql-dev.devopsb96.store -uroot -pRoboShop@1 <${app_path}/schema/shipping.sql &>>${log_file}
echo -e "${color} system setup${nocolor}"
cp /home/centos/roboshop-shell/shipping.service /etc/systemd/system/shipping.service

echo -e "${color} start shipping${nocolor}"
systemctl daemon-reload &>>${log_file}

systemctl enable shipping &>>${log_file}
systemctl restart shipping &>>${log_file}
}
python()
{
  echo -e "${color} install python${nocolor}"

  dnf install python36 gcc python3-devel -y &>>${log_file}
  echo $?
  app_presetup

  echo -e "${color} install dependencies${nocolor}"
  cd ${app_path}
  pip3.6 install -r requirements.txt &>>${log_file}
   echo -e "${color} configure payment service${nocolor}"
  cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service



  echo -e "${color} start payment servicesl${nocolor}"
  systemctl daemon-reload &>>${log_file}

  systemctl enable payment &>>${log_file}
  systemctl restart payment &>>${log_file}


}