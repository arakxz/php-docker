#!/bin/bash
#

a2dissite 000-default.conf

rm /etc/apache2/sites-available/000-default.conf \
   /etc/apache2/sites-available/default-ssl.conf

a2ensite localhost.conf

exit 0
