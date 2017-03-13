# Ruby

### Install Ruby
```shell
brew install rbenv ruby-build
cat 'eval "$(rbenv init -)"' >> ~/.bash_profile
source  ~/.bash_profile
rbenv install 2.4.0
rbenv rehash
rbenv global 2.4.0
rbenv versions
```
### Update GEM
```shell
gem list
gem update --system
gem -v
```
### Install Bundler
```shell
gem install bundler
rbenv rehash
bundle -v
```
### Install Rails
```shell
gem install rails
rbenv rehash
rails -v
```
### Install MySQL
```shell
brew install mysql
mysql --version
```
MySQL is installed without a password.  To secure it, run:
```shell
mysql_secure_installation
```
To start MySQL at login, run:
```shell
brew services start mysql
```
To start MySQL manually each time, run:
```shell
mysql.server start
```
To connect to MySQL, run:
```shell
mysql -uroot
```
For GUI, install [MySQL Workbench]. 
