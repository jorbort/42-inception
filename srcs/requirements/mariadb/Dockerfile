FROM debian:11.9

#Update apt-get and install needed packages
RUN apt-get -y update && apt-get install -y mariadb-server

#Copy mariadb conf, this settings will override default settings
COPY ./conf/init.cnf /etc/mysql/mariadb.conf.d

#Copy script from host machine to container
COPY ./tools/mariadb_start.sh /etc
RUN chmod a+x /etc/mariadb_start.sh

#Create /var/run/mysqld if it doesn't exist, needed by mysql to store socket files and PID's
RUN mkdir -p /var/run/mysqld && \
		chown -R mysql:mysql /var/run/mysqld && \
		chmod 775 /var/run/mysqld

#Expose port 3306, used by MYSQL to make connections 
EXPOSE 3306

#Execute script when container is ready
ENTRYPOINT ["/etc/mariadb_start.sh"]