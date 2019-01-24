#!/bin/bash

#put here the cert url separated by commas
URLS=( $1 )

FILE=/tmp/cert.pem;

for i in "${URLS[@]}"
do 
	openssl s_client -connect $i:443 -verify 0 > $FILE.tmp;
	##change this sleep time until 1 minute, it doesn't take longer than this to bring the cert. 
	sleep 30 ; 

	## kill the process if the command above won't exit normally.
	#ps -ef| grep "openssl s_client" | grep -v grep | awk '{print $2}' | xargs kill -9;

	## generates a .pem cert in /tmp/cert.pem
	cat $FILE.tmp |sed -n '/-----BEGIN CERTIFICATE-----/,$p' certificado.txt | sed '/-----END CERTIFICATE-----/q' > $FILE;

	CERT_EXP_DATE='date +%s -d "$(echo | cat $FILE | openssl x509 -noout -dates | tail -1 | cut -f2 -d= )"';
	DATE="date +%s";

	if [ $(eval $DATE) -le $(eval $CERT_EXP_DATE) ]; then
	        echo "VALID";
		## importing command... adjust where is java and keystore commands path
	        #keytool -import -alias $URL -file /tmp/cert.pem -noprompt -trustcacerts -storepass changeit -keystore truststore.jks
       		#return 0;
	else
	        echo "INVALID";
       		#return 1;
        fi        
done


	

