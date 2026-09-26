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
database_name = 'PRESENTATION'
database_comment = 'Database for use by end users, specifically for reporting and querying. What lives here is mostly views, materialized views, and dynamic tables. This is not where data lives, just where data is formatted for users / reporting.'
*/

-- sysadmin should be the owner of the database, and the role creating the database becomes the owner
USE ROLE SYSADMIN;

-- create the database if it doesn't exist; this protects and accidental re-run that drops the database and its data
CREATE DATABASE IF NOT EXISTS PRESENTATION
    COMMENT = 'Database for use by end users, specifically for reporting and querying. What lives here is mostly views, materialized views, and dynamic tables. This is not where data lives, just where data is formatted for users / reporting.'
;

-- confirm database creation
SHOW DATABASES LIKE 'PRESENTATION';

-- drop the default public schema
DROP SCHEMA IF EXISTS PRESENTATION.PUBLIC;

-- confirm public schema was dropped
SHOW SCHEMAS;

-- allow securityadmin to create database roles
GRANT CREATE DATABASE ROLE ON DATABASE PRESENTATION TO ROLE SECURITYADMIN;
