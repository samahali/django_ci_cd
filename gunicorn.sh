#!/bin/bash

source  env/bin/activate

cd /var/lib/jenkins/workspace/django_cicd/app

python3 manage.py makemigrations
python3 manage.py migrate
python3 manage.py collectstatic -- no-input

echo "Migrations Done :D :D"

cd /var/lib/jenkins/workspace/django_cicd

sudo cp -rf gunicorn.socket /etc/systemd/system/
sudo cp -rf gunicorn.service /etc/systemd/system/

echo "$USER"
echo  "$PWD"

sudo systemctl daemon-reload
sudo systemctl start gunicorn
echo  "Gunicorn has been started"
sudo systemctl enable gunicorn
echo  "Gunicorn has been enabled"
sudo systemctl restart gunicorn
sudo systemctl status gunicorn
