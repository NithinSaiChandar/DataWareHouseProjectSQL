/* This script creates a database named 'DataWarehouse' and in that database we are creating three schemas named 'Bronze', 'Silver', 'Gold'.*/
use master;
create Database DataWarehouse;
use Datawarehouse;
create schema bronze;
create schema silver;
create schema gold;
