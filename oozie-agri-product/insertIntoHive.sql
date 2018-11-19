add jar hdfs://bigdata-hdp01.yling.com:8020/hiveudf/GenericUDFUuid.jar;
create temporary function uuid as 'com.yling.hive.udf.GenericUDFUuid';
use yling_prd;
insert overwrite table mall_agriculture_product_summary  select concat(uuid(),'-',unix_timestamp()) as key, to_date(updateat) as time, count(*) as totalnum, 1 as status  from  mall_agriculture_product where appid='app008' and product_type='2' and status='1' and updateat >='${hiveconf:daily_param}' group by to_date(updateat);
insert overwrite table mall_agriculture_product_summary select   concat(uuid(),'-',unix_timestamp())  as key, to_date(updateat) as time, count(*)as totalnum, 0 as status from  mall_agriculture_product where appid='app008' and product_type='2' and status='0' and updateat >='${hiveconf:daily_param}' group by to_date(updateat);

