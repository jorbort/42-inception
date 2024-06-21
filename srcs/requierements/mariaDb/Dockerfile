FROM debian:11.9

ARG DB_NAME
ARG DB_USER
ARG DB_PASS

RUN apt-get -y update && apt-get install -y mariadb-server && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql

RUN mkdir -p /opt/mariadb /run/mysqld && \
	chown -R mysql:mysql /var/lib/mysql /opt/mariadb /run/mysqld

COPY conf/init.sql /opt/mariadb/init.sql

RUN sed -i "s/DB_NAME/${DB_NAME}/g" /opt/mariadb/init.sql\
	&& sed -i "s/DB_USER/${DB_USER}/g" /opt/mariadb/init.sql\
	&& sed -i "s/DB_PASS/${DB_PASS}/g" /opt/mariadb/init.sql

RUN if [ -f /etc/mysql/mariadb.conf.d/50-server.cnf ]; then \
		sed -i "s/skip-networking/#skip-networking/g" /etc/mysql/mariadb.conf.d/50-server.cnf; \
	fi

RUN chown -R mysql:mysql /var/lib/mysql

EXPOSE 3306

ENTRYPOINT [ "mysqld", "--user=mysql", "--init-file=/opt/mariadb/init.sql" ]