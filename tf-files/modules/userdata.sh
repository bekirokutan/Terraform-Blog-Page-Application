#! /bin/bash
apt-get update -y
apt-get install git -y
apt-get install python3 -y
cd /home/ubuntu/
REPO=${userdata-git-repo}
USER=${userdata-git-user}
git clone https://github.com/$USER/$REPO.git 
cd /home/ubuntu/$REPO
apt install python3-pip -y
apt-get install python3.7-dev libmysqlclient-dev -y
cd /home/ubuntu/$REPO/src 
pip3 install -r requirements.txt
python3 manage.py collectstatic --noinput
python3 manage.py makemigrations
python3 manage.py migrate
python3 manage.py runserver 0.0.0.0:80