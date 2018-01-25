﻿#!/bin/bash

#auto  monitor disk

#by name zhouhb
echo  -e  "\033[31m  \033[1m"

rm -rf   list.txt

LIST=`df -h | grep "^/dev/"  >>list.txt`

cat  <<  EOF

+++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++welcome to yangwen's system++++++++++++

EOF

echo -e  "\033[32m============================================\033[0m"

echo

sleep 2

while  read line


do
  
IP_ADDR=`ifconfig  eth0 | grep "Bcast"|awk '{print $2}'| cut -d:  -f 2`
  D_Name=`echo $line|awk  '{print $1,$NF"分区"}'`
 
D_Total=`echo $line|awk '{print $2}'`

D_Avail=`echo  $line|awk '{print $5}'`

D_Percent=`echo $line|awk '{print $5}'|sed 's/%//g'`

if [ "$D_Percent" -ge 8 ];then

cat >email.txt  <<EOF

***********************email******************
************


通知类型：告警


服务：disk

主机：$IP_ADDR

状态：报错


日期/时间：周五 2016年10月7号 21：12 CST



额外提示：



CRTIACL - DISK  monitor:$D_Name  used  more then  ${D_Percent}%

EOF


	echo  $D_Name  has shengddd  for more   then   ${D_Percent}% ,please 	cgeck
      mail -s "$D_Name  waring"  1455328192@qq.com < email.txt

fi

done <list.txt

echo  "dddddddddddddddddddddddddddddddddddddddddddd"

echo  "Done."
