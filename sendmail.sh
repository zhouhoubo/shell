#!/bin/bash
# Description: zabbix�ʼ��澯�ű�
# Notes:       ʹ��sendEmail
#
 
# �ű�����־�ļ�
LOGFILE="/tmp/Email.log"
:>"$LOGFILE"
exec 1>"$LOGFILE"
exec 2>&1
 
SMTP_server='smtp.163.com'    # SMTP������������ֵ��Ҫ�����޸�
username='zabbix@163.com'     # �û���������ֵ��Ҫ�����޸�
password='zabbix'             # ���룬����ֵ��Ҫ�����޸�
from_email_address='zabbix@163.com' # ������Email��ַ������ֵ��Ҫ�����޸�
to_email_address="$1"               # �ռ���Email��ַ��zabbix����ĵ�һ������
message_subject_utf8="$2"           # �ʼ����⣬zabbix����ĵڶ�������
message_body_utf8="$3"              # �ʼ����ݣ�zabbix����ĵ���������
 
# ת���ʼ�����ΪGB2312������ʼ����⺬�����ģ��յ��ʼ���ʾ��������⡣
message_subject_gb2312=`iconv -t GB2312 -f UTF-8 << EOF
$message_subject_utf8
EOF`
[ $? -eq 0 ] && message_subject="$message_subject_gb2312" || message_subject="$message_subject_utf8"
 
# ת���ʼ�����ΪGB2312������յ��ʼ���������
message_body_gb2312=`iconv -t GB2312 -f UTF-8 << EOF
$message_body_utf8
EOF`
[ $? -eq 0 ] && message_body="$message_body_gb2312" || message_body="$message_body_utf8"
 
# �����ʼ�
sendEmail='/usr/local/bin/sendEmail'
set -x
$sendEmail -s "$SMTP_server" -xu "$username" -xp "$password" -f "$from_email_address" -t "$to_email_address" -u "$message_subject" -m "$message_body" -o message-content-type=text -o message-charset=gb2312