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
database_name = 'INGESTION'
database_comment = 'Database used for ingesting data into snowflake. This is a landing zone where data gets processed and move to its final destination.'
*/

-- sysadmin should be the owner of the database, and the role creating the database becomes the owner
USE ROLE SYSADMIN;

-- create the database if it doesn't exist; this protects and accidental re-run that drops the database and its data
CREATE DATABASE IF NOT EXISTS INGESTION
    COMMENT = 'Database used for ingesting data into snowflake. This is a landing zone where data gets processed and move to its final destination.'
;

-- confirm database creation
SHOW DATABASES LIKE 'INGESTION';

-- drop the default public schema
DROP SCHEMA IF EXISTS INGESTION.PUBLIC;

-- confirm public schema was dropped
SHOW SCHEMAS;

-- allow securityadmin to create database roles
GRANT CREATE DATABASE ROLE ON DATABASE INGESTION TO ROLE SECURITYADMIN;
GRANT USAGE ON DATABASE INGESTION TO ROLE SECURITYADMIN;
