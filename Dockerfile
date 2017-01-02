FROM ubuntu:14.04
MAINTAINER pratheesh
run apt-get update
run apt-get upgrade -y
run apt-get install -y apache2 libapache2-mod-php5 php5 php5-cli php5-common php5-curl php5-gd php5-json php5-ldap php5-mcrypt php5-mysqlnd php5-pgsql  mysql-client-5.6 php5-memcache memcached unzip
add i-doit.ini /etc/php5/mods-available/
run  php5enmod i-doit
run  php5enmod memcache
run  php5enmod mcrypt
run apt-get update
workdir /etc/php5/conf.d/
run ln -s /etc/php5/mods-available/i-doit.ini /etc/php5/conf.d/
run apt-get install -y  php5-memcache memcached
run php5enmod memcache
run  apt-get update
run apt-get install -y  php5-apcu
run php5enmod apcu
run  apt-get update
run apt-get install -y  php5-xcache
run rm -f  /etc/php5/mods-available/xcache.ini
add xcache.ini /etc/php5/mods-available/
run a2dissite 000-default
add i-doit.conf /etc/apache2/sites-available/
run a2ensite i-doit
run a2enmod rewrite
add i-doit.cnf  /etc/mysql/conf.d/
workdir /var/www/html/i-doit
add idoit-open-1.8.zip /var/www/html/i-doit/
run unzip idoit-open-1.8.zip
run rm idoit-open-1.8.zip
run chown www-data:www-data -R .
run find . -type d -name \* -exec chmod 775 {} \;
run find . -type f -exec chmod 664 {} \;
run  chmod 774 controller tenants import updatecheck *.sh
expose 80
entrypoint service apache2 start && bash 
