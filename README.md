# Guidelines For Developers

## Table of Contents
- [1. Introduction](#1-Introduction)
- [2. Prerequisites](#2-Prerequisites)
- [3. Installation & Configuration](#3-Installation-Configuration)
- [4. Database Setup](#4-Database-Setup)
- [5. Running the Application](#5-Running-Application)
- [6. Docker Deployment](#6-Docker-Deployment)
- [7. Usage](#7-Usage)
- [8. Troubleshooting](#8-Troubleshooting)

## 1. Introduction
- This is simple project about getting movies on youtube and show it in your website.
- Using ruby on rails for backend and reactjs for frontend.
- Key features: Login, register, view video, create video and real time notification when having new video from users.

## 2. Prerequisites
- Ruby 2.6.8
- Rails 5.0.7.2
- Redis
- Sidekiq
- Postgresql
- Docker, docker-compose, docker hub, github, render.com server
- Github actions
- ReactJS

## 3. Installation-Configuration
- Set up front end
```code
git clone https://github.com/nguyenvanhuan243/remi_fe
cd remi_fe
mv .env_localhost .env
nvm use 14
npm uninstall node-sass
npm install node-sass@4.14.1
npm install
npm run build:dll
npm start
```
- Set up backend
```code
git clone https://github.com/nguyenvanhuan243/remi_api
cd remi_api
mv .env_localhost .env
docker-compose up
```


## 4. Database-Setup
- Dont need this step because we are using docker.

## 5. Running-Application
- Set up front end
```code
git clone https://github.com/nguyenvanhuan243/remi_fe
cd remi_fe
mv .env_localhost .env
nvm use 14
npm uninstall node-sass
npm install node-sass@4.14.1
npm install
npm run build:dll
npm start
```
- Access front end: http://localhost:3000
- Set up backend
```code
git clone https://github.com/nguyenvanhuan243/remi_api
cd remi_api
mv .env_localhost .env
docker-compose up
```
- Access backend: [http://localhost:3001](http://localhost:3001)
- Api: [http://localhost:3001/swagger](http://localhost:3001/swagger)
- Sidekiq: [http://localhost:3001/sidekiq](http://localhost:3001/sidekiq)

Run test
```code
cd remi_api
mv .env_localhost .env
RAILS_ENV=test rake db:create 
RAILS_ENV=test rake db:migrate
bundle exec rspec spec
```

## 6. Docker-Deployment
- When have new code to github, github action will deploy a image to dockerhub:
https://hub.docker.com/r/nguyenvanhuan243/remi_frontend
- After we will use this image to deploy on render server.
- Use docker deployment of render service: https://dashboard.render.com/select-image?type=web
- Docker build image, docker push in here: https://github.com/nguyenvanhuan243/remi_fe/blob/master/.github/workflows/deploy_server.js.yml

## 7. Usage
- Front end (Use docker Image): https://remi-frontend-5bis.onrender.com
- Backend API: https://remi-api.onrender.com/swagger
- Sidekiq: https://remi-api.onrender.com/sidekiq
(sidekiq info: admin|123456)
- Login/Register: Access to this page and register after login to share video: https://remi-fe-docker-deployment.onrender.com/

- Share video: After login you can access to this page to share video: https://remi-fe-docker-deployment.onrender.com/share
you will recieve alert message when having new video shared from other user.

## 8. Troubleshooting
- Full docker disk size: You can increase docker disk size.
- Missing docker and docker compose: Install if missing it.

## Conclusion
- Thanks for reading !!!
