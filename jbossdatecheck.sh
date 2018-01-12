#!/bin/ksh

rhelServers=$1
if [[ "$rhelServers" == "" ]]; then
  echo "Please provide server file"
  exit
fi

printf "<html>\n" | tee -a server.html
printf "<head>\n" | tee -a server.html
printf "<style>\n" | tee -a server.html
printf "table {\n" | tee -a server.html
printf "    border-collapse: collapse;\n" | tee -a server.html
printf "    font-family: \"Trebuchet MS\", Arial, Helvetica, sans-serif;\n" | tee -a server.html
printf "    width: 100%;\n" | tee -a server.html
printf "}\n" | tee -a server.html
printf "th, td {\n" | tee -a server.html
printf "    text-align: left;\n" | tee -a server.html
printf "    border: 1px solid brown;\n" | tee -a server.html
printf "    padding: 8px;\n" | tee -a server.html
printf "}\n" | tee -a server.html
printf "tr:nth-child(even){background-color: #f2f2f2}\n" | tee -a server.html
printf "th {\n" | tee -a server.html
printf "    background-color: #4CAF50;\n" | tee -a server.html
printf "    color: white;\n" | tee -a server.html
printf "}\n" | tee -a server.html
printf "</style>\n" | tee -a server.html
printf "</head>\n" | tee -a server.html
printf "<body>\n" | tee -a server.html
printf "<table style=\"width:60\%\">\n"| tee -a server.html
printf "    <tr>\n" | tee -a server.html
printf "      <th>Server Name</th>\n" | tee -a server.html
printf "      <th>OS Version</th>\n" | tee -a server.html
printf "      <th>JVM</th>\n" | tee -a server.html
printf "      <th>JBoss Version</th>\n" | tee -a server.html
printf "      <th>Year</th>\n" | tee -a server.html
printf "    </tr>\n" | tee -a server.html

while read server
do
  #echo "Logging into $server"
  #ssh $server "lsb_release -i -r;grep -c ^processor /proc/cpuinfo; cat /proc/scsi/scsi | grep -i "vmware" | tail -1" < /dev/null
  #ssh $server "df -k ; ps -ef | grep tomcat | tail -1" < /dev/null
  #ssh $server "cd /opt/tcserver/servers;  ls -ltr" <  /dev/null
  ssh  jboss@$server "ksh -s" < /home/websph/checkjbossyear.sh  >> server.html
  printf "\n"
done < "$rhelServers"


printf "</table>\n" | tee -a server.html

printf "</body>\n" | tee -a server.html
printf "</html>\n" | tee -a server.html
