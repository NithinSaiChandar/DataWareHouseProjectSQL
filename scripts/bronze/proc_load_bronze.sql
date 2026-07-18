create or alter procedure bronze.load_bronze as
begin
declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
begin try
print '===============================';
print 'loading bronze layer';
print '===============================';

print '-------------------------------';
print 'loading crm tables';
print '-------------------------------';

set @batch_start_time=getdate();
set @start_time=getdate();
truncate table bronze.crm_cust_info;
bulk insert bronze.crm_cust_info
from 'C:\Users\nithi\OneDrive\Desktop\BaraaSQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with (
firstrow=2,
fieldterminator=',',
tablock
);
set @end_time=getdate();
print 'seconds to load: '+cast(datediff(second, @start_time, @end_time) as nvarchar)

set @start_time=getdate();
truncate table bronze.crm_prd_info;
bulk insert bronze.crm_prd_info
from 'C:\Users\nithi\OneDrive\Desktop\BaraaSQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with (
firstrow=2,
fieldterminator=',',
tablock
);
set @end_time=getdate();
print 'seconds to load: '+cast(datediff(second, @start_time, @end_time) as nvarchar)

set @start_time=getdate();
truncate table bronze.crm_sales_details;
bulk insert bronze.crm_sales_details
from 'C:\Users\nithi\OneDrive\Desktop\BaraaSQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with (
firstrow=2,
fieldterminator=',',
tablock
);
set @end_time=getdate();
print 'seconds to load: '+cast(datediff(second, @start_time, @end_time) as nvarchar)

print '-------------------------------';
print 'loading erp tables';
print '-------------------------------';
set @start_time=getdate();
truncate table bronze.erp_cust_az12;
bulk insert bronze.erp_cust_az12
from 'C:\Users\nithi\OneDrive\Desktop\BaraaSQL\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
with (
firstrow=2,
fieldterminator=',',
tablock
);
set @end_time=getdate();
print 'seconds to load: '+cast(datediff(second, @start_time, @end_time) as nvarchar)

set @start_time=getdate();
truncate table bronze.erp_loc_a101;
bulk insert bronze.erp_loc_a101
from 'C:\Users\nithi\OneDrive\Desktop\BaraaSQL\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
with (
firstrow=2,
fieldterminator=',',
tablock
);
set @end_time=getdate();
print 'seconds to load: '+cast(datediff(second, @start_time, @end_time) as nvarchar)

set @start_time=getdate();
truncate table bronze.erp_px_cat_g1v2;
bulk insert bronze.erp_px_cat_g1v2
from 'C:\Users\nithi\OneDrive\Desktop\BaraaSQL\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
with (
firstrow=2,
fieldterminator=',',
tablock
);
set @end_time=getdate();
print 'seconds to load: '+cast(datediff(second, @start_time, @end_time) as nvarchar)
set @batch_end_time=getdate();
print 'batch load duration in seconds: '+cast(datediff(second, @batch_start_time, @batch_end_time) as nvarchar)
end try
begin catch
	print 'ERROR OCCURED'
	print 'error message' + error_message();
end catch 
end
