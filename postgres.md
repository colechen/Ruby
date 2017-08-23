### Install Postgres
```shell
brew install postgresql
```
### Start Postgress
```shell
pg_ctl -D /usr/local/var/postgres start \\no background process
brew services start postgresql \\start as startup service
postgres -V
```
### Command Line
```shell
psql postgres
```
### List all roles
```shell
postgres=# \du
```

### Create User
1. Create with psql
```shell
postgres=# CREATE ROLE patrick WITH LOGIN PASSWORD 'Getting started';
postgres=# \du
postgres=# ALTER ROLE patrick CREATEDB;
postgres=# \du
postgres=# \q # quits
```
2. Create using utility (https://www.postgresql.org/docs/9.5/static/reference-client.html), no alter, need to use psql
```shell
createuser patrick //or createuser patrick --createdb
```

### Create a Database
1. Create database with psql
```shell
psql postgres -U patrick
postgres=> CREATE DATABASE super_awesome_application;
postgres=> GRANT ALL PRIVILEGES ON DATABASE super_awesome_application TO patrick;
postgres=> \list      //lists all the databases in Postgres
postgres=> \connect super_awesome_application     //connect to a specific database
postgres=> \dt   //list the tables in the currently connected database
postgres=> \q
```
2. Create database with utility, no alter, need to use psql
```shell
createdb super_awesome_application -U patrick
```

### Reference:
Popular GUI
1. Postico (https://eggerapps.at/postico/download/)
2. pgAdmin (https://www.pgadmin.org/download/macos4.php) - Oldest, pgAdmin is capable of handling advanced cases that Postico cannot.
3. Navicat (https://www.navicat.com/download/navicat-for-postgresql) Enterprise-level management GUIs, $100-$250 after 14-day free trail, features a Data Modeler that allows you to graphically design and ebug your database schemas.


