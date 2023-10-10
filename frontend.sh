echo -e "\e[33mInstalling Nginx Server\e[0m"

dnf install nginx -y
echo -e "\e[33mRemoving Old App Content\e[0m"
rm -rf /usr/share/nginx/html/*
echo -e "\e[33mDownloading Frontend Content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
echo -e "\e[33mExtract Frontend Content\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

# we need to copying

echo -e "\e[33mStarting Nginx Server\e[0m"
systemctl enable nginx
systemctl restart nginx