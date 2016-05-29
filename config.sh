#!/bin/bash

# apache dir
apdir="/etc/apache2"

#
# apache
#
function apache {

    local start=$(cat ${apdir}/apache2.conf | egrep -in "directory.+www" | cut -f1 -d':')

    for i in $(cat ${apdir}/apache2.conf | egrep -in "<.directory" | cut -f1 -d':')
    do
        if [ "$i" -gt "$start" ]
        then
            local end=$i
            break # end for
        fi
    done

    if [ -z ${end:+x} ]
    then
        echo 'failed to replace "AllowOverride" in '$apdir'/apache2'
    else
        let "start+=1"
        for (( i=$start; i<$end; i++ ))
        do
            sed -n ${i}p ${apdir}/apache2.conf | grep -q "AllowOverride None"
            if [ "$?" -eq 0 ]
            then
                sed -i ${i}'s/AllowOverride None/AllowOverride All/' ${apdir}/apache2.conf
                break # end for
            fi
        done
    fi

}

a2dissite 000-default.conf

rm -f ${apdir}/sites-available/000-default.conf \
      ${apdir}/sites-available/default-ssl.conf

a2ensite localhost.conf

a2enmod rewrite
apache

exit 0
