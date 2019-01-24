echo ############################################################ > report.txt
echo # date/time >> report.txt
echo ############################################################ >> report.txt
date /t >> report.txt
time /t >> report.txt
echo ############################################################ >> report.txt
echo # ping ip >> report.txt
echo ############################################################ >> report.txt
ping %1 >> report.txt
echo ############################################################ >> report.txt
echo # ping google >> report.txt
echo ############################################################ >> report.txt
ping 8.8.8.8 >> report.txt
echo ############################################################ >> report.txt
echo # search www.google.com.br using local dns >> report.txt
echo ############################################################ >> report.txt
nslookup www.google.com >> report.txt
echo ############################################################ >> report.txt
echo # search www.google.com.br using google dns >> report.txt
echo ############################################################ >> report.txt
nslookup www.google.com 8.8.8.8 >> report.txt

