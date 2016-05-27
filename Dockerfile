FROM debian:stable

RUN apt-get update \
	&& apt-get install -y apache2 php5 php5-curl php5-mcrypt php5-mysql \
	&& apt-get clean

EXPOSE 80 443

CMD [ "/usr/sbin/apachectl", "-D", "FOREGROUND" ]
