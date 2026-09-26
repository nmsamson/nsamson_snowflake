/*
# Setup

***Run this script in its entirety due to the variables***

Use this template notebook to create a new schema in an existing database. It will also create the required database roles for the new schema.

This notebook contains multiple variables that will need to be set before running.

- database_name: enter the name of the existing database in this variable
  - ex: '' -> 'GOVERNANCE'
- schema_name: enter the name of the new schema in this variable
  - ex: '' -> 'COMMON'
- schema_comment: description of the schema and its purpose
  - ex: '' -> 'Schema used for storing various governance objects, including network policies, masking policies, etc.'
 
Prerequisites:

- Configured Snowflake account
- Sysadmin role
- Securityadmin role
- Existing Snowflake database
*/

/*
database_name = 'GAMING'
schema_name = '{{schema_name}}'
schema_comment = '{{schema_comment}}'
*/

/*
# RBAC - Role-Based Access Control

The rest of this template is for establishing RBAC in the schema.

Currently, there are four basic roles defined here for the schema. These are not set in stone and can be modified as-needed.

- Read: read-only access
- Modify: change level access (can insert / update / delete data)
- Build: presentation object creation + read-only access
- Engineer: architect access to the schema that doesn't require granting sysadmin

To set a different suffix for the roles, change the variables in "Set Role Names" below. No action is required if these default values are acceptable.
*/

/*
# this is a calculated variable used later; only change if a different read-only role suffix is needed
read_role_name = '{{read_role_name}}' <- '{{schema_name}}_READ'
modify_role_name = '{{modify_role_name}}' <- '{{schema_name}}_MODIFY'
build_role_name = '{{build_role_name}}' <- '{{schema_name}}_BUILD'
engineer_role_name = '{{engineer_role_name}}' <- '{{schema_name}}_ENGINEER'
*/

-- use sysadmin (owner) to create the schema
USE ROLE SYSADMIN;

-- create the schema
-- managed access means the owner of the schema owns all objects within the schema
CREATE SCHEMA IF NOT EXISTS GAMING.{{schema_name}}
    WITH MANAGED ACCESS
    COMMENT = '{{schema_comment}}'
;

-- confirm the new schema was created
SHOW SCHEMAS LIKE '{{schema_name}}' IN DATABASE GAMING;

/*
## Read-only Database Role Creation

Build the read database role for the schema.

This role allows read-only access to the schema.
*/

-- use securityadmin to create the database role
USE ROLE SECURITYADMIN;

-- use database to create the database role
USE DATABASE GAMING;

-- create database role for read access
CREATE DATABASE ROLE IF NOT EXISTS GAMING.{{read_role_name}}
    COMMENT = 'Role for read-only access to GAMING {{schema_name}} schema'
;

-- confirm the database role was created
SHOW DATABASE ROLES LIKE '{{read_role_name}}' IN DATABASE GAMING;

-- allows the role to use the database
GRANT USAGE ON DATABASE GAMING TO DATABASE ROLE GAMING.{{read_role_name}};

-- allows the role to use the schema
GRANT USAGE ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};

-- select grants
-- tables
GRANT SELECT ON ALL TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
GRANT SELECT ON FUTURE TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
-- dynamic tables
GRANT SELECT ON ALL DYNAMIC TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
GRANT SELECT ON FUTURE DYNAMIC TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
-- external tables
GRANT SELECT ON ALL EXTERNAL TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
GRANT SELECT ON FUTURE EXTERNAL TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
-- iceberg tables
GRANT SELECT ON ALL ICEBERG TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
GRANT SELECT ON FUTURE ICEBERG TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
-- interactive tables
GRANT SELECT ON ALL INTERACTIVE TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
GRANT SELECT ON FUTURE INTERACTIVE TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
-- views
GRANT SELECT ON ALL VIEWS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
GRANT SELECT ON FUTURE VIEWS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
-- materliazlied views
GRANT SELECT ON ALL MATERIALIZED VIEWS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
GRANT SELECT ON FUTURE MATERIALIZED VIEWS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};

-- read grants
-- stages
GRANT READ ON ALL STAGES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
GRANT READ ON FUTURE STAGES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};

-- usage grants (excluding database & schema grants)
-- file formats
GRANT USAGE ON ALL FILE FORMATS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
GRANT USAGE ON FUTURE FILE FORMATS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
-- functions
GRANT USAGE ON ALL FUNCTIONS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
GRANT USAGE ON FUTURE FUNCTIONS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
-- stages
GRANT USAGE ON ALL STAGES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
GRANT USAGE ON FUTURE STAGES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};

-- confirm grants
SHOW GRANTS TO DATABASE ROLE GAMING.{{read_role_name}};

/*
### Optional Grants for Read-only Role

Uncomment the below to run the optional grants, *if needed*.
*/

/*
GRANT USAGE ON ALL STREAMLITS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
GRANT USAGE ON FUTURE STREAMLITS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};

-- workspaces
GRANT USAGE ON ALL WORKSPACES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
GRANT USAGE ON FUTURE WORKSPACES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};

-- notebooks
GRANT USAGE ON ALL NOTEBOOKS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
GRANT USAGE ON FUTURE NOTEBOOKS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};

-- procedures
GRANT USAGE ON ALL PROCEDURES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
GRANT USAGE ON FUTURE PROCEDURES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{read_role_name}};
*/

/*
## Modify Database Role Creation

Build the modify database role for the schema.

This role builds on the Read role and allows for altering data in the schema.

This would be used for users who need to insert, update, or delete data.
*/

-- use securityadmin to create the database role
USE ROLE SECURITYADMIN;

-- use database to create the database role
USE DATABASE GAMING;

-- create database role for modify access
CREATE DATABASE ROLE IF NOT EXISTS GAMING.{{modify_role_name}}
    COMMENT = 'Role for modify / insert / update / delete access to GAMING {{schema_name}} schema'
;

-- confirm the database role was created
SHOW DATABASE ROLES LIKE '{{modify_role_name}}' IN DATABASE GAMING;

-- grant read role to modify role
GRANT DATABASE ROLE GAMING.{{read_role_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};

-- usage grants
-- procedures
GRANT USAGE ON ALL PROCEDURES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};
GRANT USAGE ON FUTURE PROCEDURES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};
-- sequences
GRANT USAGE ON ALL SEQUENCES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};
GRANT USAGE ON FUTURE SEQUENCES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};

-- insert grants
-- tables
GRANT INSERT ON ALL TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};
GRANT INSERT ON FUTURE TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};
-- iceberg tables
GRANT INSERT ON ALL ICEBERG TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};
GRANT INSERT ON FUTURE ICEBERG TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};

-- delete grants
-- tables
GRANT DELETE ON ALL TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};
GRANT DELETE ON FUTURE TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};
-- iceberg tables
GRANT DELETE ON ALL ICEBERG TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};
GRANT DELETE ON FUTURE ICEBERG TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};

-- truncate grants
-- tables
GRANT TRUNCATE ON ALL TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};
GRANT TRUNCATE ON FUTURE TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};
-- iceberg tables
GRANT TRUNCATE ON ALL ICEBERG TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};
GRANT TRUNCATE ON FUTURE ICEBERG TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};

-- read grants
-- stages
--   this is included in the _READ role, but the direct grant is needed for the write grant
GRANT READ ON ALL STAGES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};
GRANT READ ON FUTURE STAGES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};

-- write grants
-- stages
GRANT WRITE ON ALL STAGES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};
GRANT WRITE ON FUTURE STAGES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{modify_role_name}};

-- confirm grants
SHOW GRANTS TO DATABASE ROLE GAMING.{{modify_role_name}};

/*
## Build Database Role Creation

Build the build database role for the schema.

This role builds on the Read role and allows for creating overlay objects.

This would be used for users who need to create presentation layer objects:
- notebooks
- workspaces
- views
- materialized views
*/

-- use securityadmin to create the database role
USE ROLE SECURITYADMIN;

-- use database to create the database role
USE DATABASE GAMING;

-- create database role for build access
CREATE DATABASE ROLE IF NOT EXISTS GAMING.{{build_role_name}}
    COMMENT = 'Role for build access to GAMING {{schema_name}} schema'
;

-- confirm the database role was created
SHOW DATABASE ROLES LIKE '{{build_role_name}}' IN DATABASE GAMING;

-- grant read role to build role
GRANT DATABASE ROLE GAMING.{{read_role_name}} TO DATABASE ROLE GAMING.{{build_role_name}};

-- usage grants
-- workspaces
GRANT USAGE ON ALL WORKSPACES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{build_role_name}};
GRANT USAGE ON FUTURE WORKSPACES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{build_role_name}};

-- read grants
-- workspaces
GRANT READ ON ALL WORKSPACES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{build_role_name}};
GRANT READ ON FUTURE WORKSPACES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{build_role_name}};

-- create grants
-- views
GRANT CREATE VIEW ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{build_role_name}};
-- materialized views
GRANT CREATE MATERIALIZED VIEW ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{build_role_name}};
-- notebooks
GRANT CREATE NOTEBOOK ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{build_role_name}};
-- workspaces
GRANT CREATE WORKSPACE ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{build_role_name}};

-- confirm grants
SHOW GRANTS TO DATABASE ROLE GAMING.{{build_role_name}};

/*
## Engineer Database Role Creation

Build the engineer database role for the schema.

This role builds on the Read and Modify roles and allows for creating schema objects.

This would be used for users who need to create all objects, including:
- artifact repositories
- dynamic tables
- file formats
- functions
- hybrid tables
- iceberg tables
- image repositories
- models
- model monitors
- pipes
- procedures
- semantic views
- sequences
- snapshots
- classification profiles
- classifications
- forecasts
- stages
- streams
- tables
- tags
- tasks
- temporary tables
*/

-- use securityadmin to create the database role
USE ROLE SECURITYADMIN;

-- use database to create the database role
USE DATABASE GAMING;

-- create database role for engineer access
CREATE DATABASE ROLE IF NOT EXISTS GAMING.{{engineer_role_name}}
    COMMENT = 'Role for engineer / architect access to GAMING {{schema_name}} schema'
;

-- confirm the database role was created
SHOW DATABASE ROLES LIKE '{{engineer_role_name}}' IN DATABASE GAMING;

-- grant read role to engineer role
GRANT DATABASE ROLE GAMING.{{read_role_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- grant modify role to engineer role
GRANT DATABASE ROLE GAMING.{{modify_role_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};

-- create grants
-- artifact repositories
GRANT CREATE ARTIFACT REPOSITORY ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- backup sets
GRANT CREATE BACKUP SET ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- dynamic tables
GRANT CREATE DYNAMIC TABLE ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- external tables
GRANT CREATE EXTERNAL TABLE ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- file formats
GRANT CREATE FILE FORMAT ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- functions
GRANT CREATE FUNCTION ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- hybrid tables
GRANT CREATE HYBRID TABLE ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- iceberg tables
GRANT CREATE ICEBERG TABLE ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- image repositories
GRANT CREATE IMAGE REPOSITORY ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- models
GRANT CREATE MODEL ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- model monitors
GRANT CREATE MODEL MONITOR ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- pipes
GRANT CREATE PIPE ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- procedures
GRANT CREATE PROCEDURE ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- semantic views
GRANT CREATE SEMANTIC VIEW ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- sequences
GRANT CREATE SEQUENCE ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- snapshots
GRANT CREATE SNAPSHOT ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- classification profiles
GRANT CREATE SNOWFLAKE.DATA_PRIVACY.CLASSIFICATION_PROFILE ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- classifications
GRANT CREATE SNOWFLAKE.ML.CLASSIFICATION ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- forecasts
GRANT CREATE SNOWFLAKE.ML.FORECAST ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- stages
GRANT CREATE STAGE ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- streams
GRANT CREATE STREAM ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- tables
GRANT CREATE TABLE ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- tags
GRANT CREATE TAG ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- tasks
GRANT CREATE TASK ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- temporary tables
GRANT CREATE TEMPORARY TABLE ON SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};

-- monitor grants
-- dynamic tables
GRANT MONITOR ON ALL DYNAMIC TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT MONITOR ON FUTURE DYNAMIC TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- functions
GRANT MONITOR ON ALL FUNCTIONS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT MONITOR ON FUTURE FUNCTIONS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- iceberg tables
GRANT MONITOR ON ALL ICEBERG TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT MONITOR ON FUTURE ICEBERG TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- pipes
--GRANT MONITOR ON ALL PIPES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT MONITOR ON FUTURE PIPES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- procedures
GRANT MONITOR ON ALL PROCEDURES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT MONITOR ON FUTURE PROCEDURES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- semantic views
GRANT MONITOR ON ALL SEMANTIC VIEWS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT MONITOR ON FUTURE SEMANTIC VIEWS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};

-- operate grants
-- dynamic tables
GRANT OPERATE ON ALL DYNAMIC TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT OPERATE ON FUTURE DYNAMIC TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- pipes
--GRANT OPERATE ON ALL PIPES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT OPERATE ON FUTURE PIPES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};

-- read grants
-- secrets
GRANT READ ON ALL SECRETS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT READ ON FUTURE SECRETS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- git repositories
GRANT READ ON ALL GIT REPOSITORIES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT READ ON FUTURE GIT REPOSITORIES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- image repositories
GRANT READ ON ALL IMAGE REPOSITORIES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT READ ON FUTURE IMAGE REPOSITORIES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};

-- rebuild grants
-- tables
GRANT REBUILD ON ALL TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT REBUILD ON FUTURE TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};

-- references grants
-- external tables
GRANT REFERENCES ON ALL EXTERNAL TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT REFERENCES ON FUTURE EXTERNAL TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- iceberg tables
GRANT REFERENCES ON ALL ICEBERG TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT REFERENCES ON FUTURE ICEBERG TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- materialized views
GRANT REFERENCES ON ALL MATERIALIZED VIEWS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT REFERENCES ON FUTURE MATERIALIZED VIEWS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- semantic views
GRANT REFERENCES ON ALL SEMANTIC VIEWS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT REFERENCES ON FUTURE SEMANTIC VIEWS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- tables
GRANT REFERENCES ON ALL TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT REFERENCES ON FUTURE TABLES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- views
GRANT REFERENCES ON ALL VIEWS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT REFERENCES ON FUTURE VIEWS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};

-- usage grants
-- dbt projects
GRANT USAGE ON ALL DBT PROJECTS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT USAGE ON FUTURE DBT PROJECTS IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};

-- write grants
-- image repositories
GRANT WRITE ON ALL IMAGE REPOSITORIES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT WRITE ON FUTURE IMAGE REPOSITORIES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- workspaces
GRANT WRITE ON ALL WORKSPACES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT WRITE ON FUTURE WORKSPACES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
-- git repositories
GRANT WRITE ON ALL GIT REPOSITORIES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};
GRANT WRITE ON FUTURE GIT REPOSITORIES IN SCHEMA GAMING.{{schema_name}} TO DATABASE ROLE GAMING.{{engineer_role_name}};

-- confirm grants
SHOW GRANTS TO DATABASE ROLE GAMING.{{engineer_role_name}};

/*
# Results

Confirm all schemas and database roles were created successfully.
*/

USE ROLE SYSADMIN;

SHOW SCHEMAS IN DATABASE GAMING;

SHOW DATABASE ROLES IN DATABASE GAMING;
