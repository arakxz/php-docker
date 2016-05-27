FROM debian:stable

RUN apt-get update \
	&& apt-get install -y apache2 \
	&& apt-get clean

EXPOSE 80 443

CMD [ "/usr/sbin/apachectl", "-D", "FOREGROUND" ]
