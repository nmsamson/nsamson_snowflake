/*
# Setup

***Run this script in its entirety due to the variables***

Use this template notebook to create a new database. It will also grant SECURITYADMIN rights to create new database roles in the database.

This notebook contains multiple variables that will need to be set before running.

- database_name: enter the name of the new database in this variable
  - ex: '' -> 'GOVERNANCE'
- database_comment: description of the database and its purpose
  - ex: '' -> 'Database used for storing various governance objects, including network policies, masking policies, etc.'
 
Prerequisites:

- Configured Snowflake account
- Sysadmin role
*/

/*
database_name = 'GOVERNANCE'
database_comment = 'Database used for storing various governance objects, including network policies, masking policies, etc.'
*/

-- sysadmin should be the owner of the database, and the role creating the database becomes the owner
USE ROLE SYSADMIN;

-- create the database if it doesn't exist; this protects and accidental re-run that drops the database and its data
CREATE DATABASE IF NOT EXISTS GOVERNANCE
    COMMENT = 'Database used for storing various governance objects, including network policies, masking policies, etc.'
;

-- confirm database creation
SHOW DATABASES LIKE 'GOVERNANCE';

-- drop the default public schema
DROP SCHEMA IF EXISTS GOVERNANCE.PUBLIC;

-- confirm public schema was dropped
SHOW SCHEMAS;

-- allow securityadmin to create database roles
GRANT CREATE DATABASE ROLE ON DATABASE GOVERNANCE TO ROLE SECURITYADMIN;
GRANT USAGE ON DATABASE GOVERNANCE TO ROLE SECURITYADMIN;
