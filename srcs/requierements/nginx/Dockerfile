FROM debian:11.9 

RUN apt-get update && apt-get install -y nginx openssl

EXPOSE 443

RUN mkdir -p -m 777 /etc/nginx/ssl/private && mkdir -p -m 777 /etc/ssl/certs

RUN openssl req -newkey rsa:2048 -nodes -days 365 -x509 -keyout /etc/nginx/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -subj "/C=ES/ST=Spain/L=Barcelona/O=42/OU=Software/CN=jbortolo.42.fr"

COPY conf/mandatory.conf /etc/nginx/sites-available/mandatory.conf

CMD ["nginx", "-g", "daemon off;"]