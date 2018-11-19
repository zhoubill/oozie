#!/bin/sh

## 环境变量生效
source /etc/profile

## HIVE HOME
HIVE_HOME=/usr/hdp/current/hive-client/

## 日志目录
LOG_DIR=/data/tracklogs

# 目录名称, 依据日期date获取
sqooptoday=`date -d -1days '+%Y-%m-%d %H:%M:%S'`
today=`date -d -1days '+%Y-%m-%d'`
todayall=${today}" 00:00:00"

###
echo "sleep 5 min, wait incremen data coming hive"
sleep 5m
###

### 
echo "loading inrcment data ............"
###  echo $daily + $hour
###  ${HIVE_HOME}/bin/hive -e "LOAD DATA LOCAL INPATH '${LOAD_FILE}' OVERWRITE INTO TABLE db_track.track_log PARTITION(date = '${daily}', hour = '${hour}') ;"
###${HIVE_HOME}/bin/hive -e  "add jar hdfs://test-hdp01.yling.com:8020/hiveudf/GenericUDFUuid.jar;create temporary function uuid as 'com.yling.hive.udf.GenericUDFUuid';use yling_test;insert overwrite table mall_agriculture_product_summary  select  concat(uuid(),'-',unix_timestamp()) as key, to_date(updateat) as time, count(*) as totalnum, 1 as status  from  mall_agriculture_product where appid='app008' and product_type='2' and updateat >='${todayall}' group by to_date(updateat);insert overwrite table mall_agriculture_product_summary select   concat(uuid(),'-',unix_timestamp())  as key, to_date(updateat) as time, count(*)as totalnum, 0 as status from  mall_agriculture_product where appid='app008' and product_type='2' and status='0' and updateat >='${todayall}' group by to_date(updateat);"

${HIVE_HOME}/bin/hive --hiveconf daily_param=${todayall} -f insertIntoHive.sql
