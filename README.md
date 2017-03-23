# rdapp

Example Javascript and Ruby on Rails applications for track and store user navigation flow.

## Synopsis

This is a exemple project to show how to store user web navigation actions. It was made in the simplyest way possible. An API that receives data from a webpage using a Javascript file that in fact stores the user information. Each different or private browser instance is treated as a single user. For the sake of simplicity it was not implemented any authentication nor velidation controls.

This project contais 2 main apps.

- App (1) Is an Ruby on Rails API. This API is responsible for store the contact's email and all the pages that was accessed by him.
- App (2) Is an couple of static web pages that uses an Javascript library that keeps track of users navigation.

## Installation

Requirements:
- Ruby version 2.3
- Rails version 5
- html5 compatible browser
- postgresql database

## Setup API

After repository is cloned you should enter in the *rdappAPI* folder:
```shell
$ cd rdappAPI
```
Then configure the database file in:
```shell
$ ./rdappAPI/config/database.yml
```
You should create 2 databases in postgres (one for development data and another for test). After that, you have to provide **username**, **password** and **database name** for development and test enviroments in _database.yml_ file.

## Running

Go to the root API folder _'rdappAPI'_:

execute the database migration:
```shell
$ rake db:migrate
```
and start the rails server:
```shell
$ rails s
```
Your API is ready to receive data, and will be accessible at: http://localhost:3000/

## Starting website

To start a exemple of website that uses track lib you should go to the _clientSite_ folder:
```shell
$ cd ./rdapp/clientSite
```
Now you can start a simple ruby server mimicing clients webserver:
```shell
$ ruby -run -ehttpd . -p8000
```
Client pages will be accessible at 

http://localhost:8000/home.html, 

http://localhost:8000/sobre.html, 

http://localhost:8000/preco.html,

http://localhost:8000/contato.html 

## Testing API

For test the API in the *rdappAPI* folder run:
```shell
$ rails test
```

# Getting contacts data:

To get an list of all contacts, access the API at:
```shell
http://localhost:3000/contatos
```
To get an specific contact and the list of pages associated to him, access API at:
```shell
http://localhost:3000/contatos/{contato_id}
```

# Heroku deployed apps:
API:

https://morning-sands-43096.herokuapp.com/contatos #lists all contacts

https://morning-sands-43096.herokuapp.com/contatos/{contato_id} #lists specific contact and his pages

Client: https://floating-lake-70378.herokuapp.com/
