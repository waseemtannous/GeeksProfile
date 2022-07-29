# Geeks Profile

In this repo, I collected the [base code](https://www.geeksforgeeks.org/profile-application-using-python-flask-and-mysql/) from geeks for geeks. It is a simple web application that allows users to create their own profile. It uses [Flask](https://flask.palletsprojects.com/) and [MySQL](https://www.mysql.com/).

The main objective is to:

1. Run the app on a linux server.
2. Dockerize the app.
3. Create a Jenkins pipeline to build and push the docker images to Docker Hub.
4. Run the app with Kubernetes over Minikube.

## 1 - Run the app on a linux server

Started by creating an EC2 instance in AWS running Ubuntu and opening port 8080 as the app will listen to this port.

Now, install python dependencies and MySQL.

```bash
sudo apt-get update

# install git
sudo apt install git -y

# clone code
git clone https://github.com/waseemtannous/GeeksProfile.git

# install python3 and pip3
sudo apt install python3 python3-pip -y
sudo apt install libpython3.10
sudo apt-get install default-libmysqlclient-dev libssl-dev -y

# check if installed correctly by running the following commands
python3 --version
pip3 --version

# install dependencies
pip3 install flask
pip3 install flask-mysqldb
```

```bash
# install mysql
sudo apt install mysql-server -y

# chek if installed correctly by running the following command (should show Active: active (runing))
sudo systemctl status mysql

# start mysql CLI
sudo mysql

# set password
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password by 'password';

exit

# check if password is set correctly. Don't change password and apply using y to all questions.
sudo mysql_secure_installation

# now login to mysql CLI
sudo mysql -u root -p

# run sql file to create database and table
source /home/ubuntu/GeeksProfile/table.sql

# check if database created correctly
SHOW DATABASES; # should show geekprofile database

# exit mysql CLI
exit

# now run the app
cd GeeksProfile
python3 app.py
```

Now, acces the app by going to http://"INSTANCE IP":8080/

You can register with a new user and login to the system.
