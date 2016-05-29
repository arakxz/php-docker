FROM debian:stable

RUN apt-get update \
	&& apt-get install -y apache2 php5 php5-curl php5-mcrypt php5-mysql \
	&& apt-get clean

EXPOSE 80 443

COPY ./config.sh /root/config.sh
COPY ./sites-available/localhost.conf /etc/apache2/sites-available/localhost.conf

RUN chmod +x /root/config.sh && /root/config.sh && rm /root/config.sh

CMD [ "/usr/sbin/apachectl", "-D", "FOREGROUND" ]
