#!/bin/ksh
dir1=/opt/jboss512/server
dir2=/opt/jboss43/server
dir3=/opt/jboss/v6.1/servers
dir4=/opt/jboss/servers
dir5=/opt/jboss/server
ver1=$(cat /etc/redhat-release)
ver2=$(echo $ver1 | cut -d' ' -f7 )
host_name=$(hostname)
set -A JVM_List
array_index=0
if  [[ -d $dir1 ]]; then
   #echo "================JVM in /opt/jboss512/server=================================================="
   for i in $( ls -d $dir1/* |grep -v lost+found);
   do
       if [[ -d $i ]];then
          if [[ -L $i/log ]]
          then
             jvm_name=$(echo $i | cut -d / -f5)
             jvm_date=$(ls -l --time-style='+%Y' $i/log | awk '{print $6}')
             JVM_List[$array_index]=$jvm_name","$jvm_date,"V5.1.2"
             array_index=$((array_index + 1 ))
          fi
       fi
   done
fi

if  [[ -d $dir2 ]]; then
   #echo "================JVM in /opt/jboss43/server=================================================="
   for i in $( ls -d $dir2/* |grep -v lost+found);
   do
       if [[ -d $i ]];then
          if [[ -L $i/log ]]
          then
             jvm_name=$(echo $i | cut -d / -f5)
             jvm_date=$(ls -l --time-style='+%Y' $i/log | awk '{print $6}')
             JVM_List[$array_index]=$jvm_name","$jvm_date,"V4.3"
             array_index=$((array_index + 1 ))
          fi
       fi
   done
fi

if  [[ -d $dir3 ]]; then
   #echo "================JVM in /opt/jboss/v6.1/servers=================================================="
   for i in $( ls -d $dir3/* |grep -v lost+found);
   do
       if [[ -d $i ]];then
          if [[ -L $i/log ]]
          then
             jvm_name=$(echo $i | cut -d / -f5)
             jvm_date=$(ls -l --time-style='+%Y' $i/log | awk '{print $6}')
             JVM_List[$array_index]=$jvm_name","$jvm_date,"V6.1"
             array_index=$((array_index + 1 ))
          fi
       fi
   done
fi

if  [[ -d $dir4 ]]; then
   #echo "================JVM in /opt/jboss/servers=================================================="
   for i in $( ls -d $dir4/* |grep -v lost+found);
   do
       if [[ -d $i ]];then
          if [[ -L $i/log ]]
          then
             jvm_name=$(echo $i | cut -d / -f5)
             jvm_date=$(ls -l --time-style='+%Y' $i/log | awk '{print $6}')
             JVM_List[$array_index]=$jvm_name","$jvm_date,"V6.1"
             array_index=$((array_index + 1 ))
          fi
       fi
   done
fi

if  [[ -d $dir5 ]]; then
   #echo "================JVM in /opt/jboss/server=================================================="
   for i in $( ls -d $dir5/* |grep -v lost+found);
   do
       if [[ -d $i ]];then
          if [[ -L $i/log ]]
          then
             jvm_name=$(echo $i | cut -d / -f5)
             jvm_date=$(ls -l --time-style='+%Y' $i/log | awk '{print $6}')
             JVM_List[$array_index]=$jvm_name","$jvm_date,"V6.4"
             array_index=$((array_index + 1 ))
          fi
       fi
   done
fi

if [[ $array_index == 0 ]]
then
   printf "    <tr>\n"
   printf "      <td rowspan="\"1"\">$host_name</td>\n"
   printf "      <td rowspan="\"1"\">RHEL $ver2</td>\n"
   printf "      <td></td>\n"
   printf "      <td></td>\n"
   printf "      <td></td>\n"
   printf "    <\tr>\n"

else
   printf "    <tr>\n"
   printf "      <td rowspan="\"$array_index"\">$host_name</td>\n"
   printf "      <td rowspan="\"$array_index"\">RHEL $ver2</td>\n"
   i=0
   while [[ $i -ne $array_index ]]
   do
       if [[ $i -gt 0  ]]
       then
          printf "    <tr>\n"
       fi
       printf "      <td>$(echo ${JVM_List[$i]} | cut -d , -f1)</td>\n"
       printf "      <td>$(echo ${JVM_List[$i]} | cut -d , -f3)</td>\n"
       printf "      <td>$(echo ${JVM_List[$i]} | cut -d , -f2)</td>\n"
       printf "    </tr>\n"
       ((i++))
   done
fi
printf "\n\n"
