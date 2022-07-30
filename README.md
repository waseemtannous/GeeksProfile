# Geeks Profile

In this repo, I collected the [base code](https://www.geeksforgeeks.org/profile-application-using-python-flask-and-mysql/) from geeks for geeks. It is a simple web application that allows users to create their own profile. It uses [Flask](https://flask.palletsprojects.com/) and [MySQL](https://www.mysql.com/).

The main objective is to:

1. Run the app on a linux server.
2. Dockerize the app.
3. Create a Jenkins pipeline to build and push the docker images to Docker Hub.
4. Run the app with Kubernetes over Minikube.

## 1 - Run the app on a linux server

Started by creating an EC2 instance in AWS running Ubuntu and opening port 8080 as the app will listen to this port.

Clone app:

```bash
sudo apt-get update

# install git
sudo apt install git -y

# clone code
git clone https://github.com/waseemtannous/GeeksProfile.git
```

Install python dependencies:

```bash
# install python3 and pip3
sudo apt install python3 python3-pip -y
sudo apt install libpython3.10
sudo apt-get install default-libmysqlclient-dev libssl-dev -y

# check if installed correctly by running the following commands
python3 --version
pip3 --version

# install dependencies
pip install -r requirements.txt
```

Install MySQL:

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
```

Now init the database:

```bash
# login to mysql CLI
sudo mysql -u root -p

# run sql file to create database and table
source /home/ubuntu/GeeksProfile/db/init.sql

# check if database created correctly
SHOW DATABASES; # should show geekprofile database

# exit mysql CLI
exit
```

Finally, run the app:

```bash
cd GeeksProfile
python3 app.py
```

Now, acces the app by going to http://"INSTANCE IP":8080/

You can register with a new user and login to the system.

## 2 - Dockerize the app

Started by creating dockerfile containing all the dependencies and the app and a docker compose file to run the app with mysql database.

To run the app, run the following commands:

```bash
git clone https://github.com/waseemtannous/GeeksProfile.git
cd GeeksProfile
docker-compose up --build -d
```

To stop the app, run the following command:

```bash
docker-compose down
```

## 3 - Create a Jenkins pipeline to build and push the docker images to Docker Hub

Start by creating a new EC2 instance in AWS running Ubuntu and installing Jenkins.

Create a new pipeline job with GitHub hook for triggering the pipeline.

Create a token from docker hub in order to push the images to docker hub. Create a new credential in Jenkins and set the token.

Create a Jenkinsfile which builds the docker image and pushes it to docker hub.

finally, the pipeline sends a build status to slack. Set slack secret key in order to send the message.
