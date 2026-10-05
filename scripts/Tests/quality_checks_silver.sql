/* 
------------------------------------------------
QUALITY CHECKS 
------------------------------------------------
Script Purpose:
  This script performs various quality checks fro data consistency,
accuracy and standardization across the 'silver layer'
*/

--check for nulls or duplicates in Primary Key
select prd_id, count(*) from silver.crm_prd_info
group by prd_id having count(*)>1 or prd_id is null;

--check for unwanted spaces

select prd_nm from silver.crm_prd_info where 
prd_nm != trim(prd_nm)

--chech for nulls or negative numbers

select prd_cost from silver.crm_prd_info
where prd_cost <0 or prd_cost is null

--Data standardization and consistency

select distinct prd_line from silver.crm_prd_info

--check for invalid dates

select * from silver.crm_prd_info where prd_end_dt<prd_start_dt

select * from silver.crm_prd_info

select * from(
select *, ROW_NUMBER() over(partition by cst_id order by cst_create_date
desc) as flag_last
from bronze.crm_cust_info
where cst_id is not null
)t where flag_last=1  

--Checks For Nulls or Duplicates in Primary Key

select cst_id, count(*) from silver.crm_cust_info
group by cst_id
having count(*)>1 or cst_id is null;

--Checks For Unwanted Spaces in String Values

select cst_firstname from silver.crm_cust_info
where cst_firstname	!= trim(cst_firstname)

select cst_lastname from silver.crm_cust_info
where cst_lastname	!= trim(cst_lastname)

--Data Standardization and consistency

select distinct cst_gender
from silver.crm_cust_info

select * from silver.crm_cust_info

--Identify out-of-range customers

select distinct bdate from silver.erp_cust_az12
where bdate<'1924-01-01' or bdate>getdate()

--Data standardization and consistency

select distinct gen from silver.erp_cust_az12

select * from silver.erp_cust_az12

select replace(cid, '-', '') as cid, 
case when trim(cntry) = 'DE' then 'Germany'
	when trim(cntry) in ('US', 'USA') then 'United States'
	when trim(cntry)='' or cntry is null then 'n/a'
	else trim(cntry) 
end as cntry
from bronze.erp_loc_a101

--Data standardization and consistency

select distinct cntry from silver.erp_loc_a101 order by cntry

select * from silver.erp_loc_a101;

select id, 
cat,
subcat,
maintenance 
from bronze.erp_px_cat_g1v2;

--check for unwanted spaces

select * from bronze.erp_px_cat_g1v2 where cat != trim(cat) or
subcat != trim(subcat) or maintenance != trim(maintenance)

--Data standardization and consistency

select distinct cat from bronze.erp_px_cat_g1v2
select distinct subcat from bronze.erp_px_cat_g1v2
select distinct maintenance from bronze.erp_px_cat_g1v2

select * from silver.erp_px_cat_g1v2
