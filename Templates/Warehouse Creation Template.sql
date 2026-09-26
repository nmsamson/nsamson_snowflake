/*
# Setup

***Run this script in its entirety due to the variables***

Use this template notebook to create a new warehouse.

This notebook contains multiple variables that will need to be set before running.

- warehouse_name: enter the name of the new warehouse
  - ex: '' -> 'DEVELOPMENT'
- warehouse_type: type of the warehouse
  - options:
    - STANDARD
    - SNOWPARK-OPTIMIZED
    - ADAPTIVE
  - ex: '' -> 'STANDARD'
- warehouse_size: size of the warehouse (compute resources)
  - options:
    - XSMALL
    - SMALL
    - MEDIUM
    - LARGE
    - XLARGE
    - XXLARGE
    - XXXLARGE
    - X4LARGE
    - X5LARGE
    - X6LARGE
  - ex: '' -> 'XSMALL'
- auto_suspend: number of seconds to keep the warehouse running after a query has finished executing
  - ex: '' -> '60'
- auto_resume: whether or not to allow the warehouse to resume automatically, based on activity
  - options: TRUE / FALSE
  - ex: '' -> 'TRUE'
- min_clusters: minimum number of clusters that should be used by the warehouse at any time
  - for multiple cluster warehouses only
  - ex: '' -> '1'
- max_clusters: maximum number of clusters that should be used by the warehouse at any time
  - for multiple cluster warehouses only
  - ex: '' -> '1'
- initially_suspended: whether or not the warehouse should be created in a suspended state
  - options: TRUE / FALSE
  - if false, the warehouses will be started in a resumed state
- query_acceleration: whether or not to use the query acceleration feature on the warehouse
  - options: TRUE / FALSE
  - ex: '' -> 'FALSE'
- warehouse_comment: description / purpose of the warehouse
  - ex: '' -> 'Warehouse used for development work in the account'
 
Prerequisites:

- Sysadmin role
*/

/*
warehouse_name = '{{warehouse_name}}'
warehouse_type = '{{warehouse_type}}'
warehouse_size = '{{warehouse_size}}'
auto_suspend = '{{auto_suspend}}'
auto_resume = '{{auto_resume}}'
min_clusters = '{{min_clusters}}'
max_clusters = '{{max_clusters}}'
initially_suspended = '{{initially_suspended}}'
query_acceleration = '{{query_acceleration}}'
warehouse_comment = '{{warehouse_comment}}'
*/

-- use sysadmin for warehouse ownership
USE ROLE SYSADMIN;

-- create the warehouse
CREATE WAREHOUSE IF NOT EXISTS {{warehouse_name}}
    WAREHOUSE_TYPE = '{{warehouse_type}}'
    WAREHOUSE_SIZE = {{warehouse_size}}
    AUTO_SUSPEND = {{auto_suspend}}
    AUTO_RESUME = {{auto_resume}}
    MIN_CLUSTER_COUNT = {{min_clusters}}
    MAX_CLUSTER_COUNT = {{max_clusters}}
    INITIALLY_SUSPENDED = {{initially_suspended}}
    ENABLE_QUERY_ACCELERATION = {{query_acceleration}}
    COMMENT = '{{warehouse_comment}}'
;

SHOW WAREHOUSES LIKE '{{warehouse_name}}';
