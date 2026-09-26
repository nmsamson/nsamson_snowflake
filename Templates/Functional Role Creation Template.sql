/*
# Setup

***Run this script in its entirety due to the variables***

Use this template notebook to create a new functional role.

Add the database role grants in the "Database Role Grants" section of this notebook.

This notebook contains multiple variables that will need to be set before running.

- role_name: enter the name of the new functional role
  - make it meaningful; functional roles should be created per function / team / department
  - ex: '' -> 'DEVELOPMENT_TEAM'
- comment: description or purpose for the functional role
  - ex: '' -> 'Functional / account role for the development team. This role can create objects in the account without being granted sysadmin. Be cautious when granting this role.'
- warehouse_name: name of the warehouse the role should be able to use
  - if the role needs access to multiple warehouses, add those grants to the code block
  - ex: '' -> 'DEVELOPMENT'

Prerequisites:

- Useradmin role
- Securityadmin role
*/

/*
role_name = '{{role_name}}'
comment = '{{role_comment}}'
warehouse_name = '{{warehouse_name}}'
*/

-- use useradmin role to create the functional role
USE ROLE USERADMIN;

-- create the role
CREATE ROLE IF NOT EXISTS {{role_name}}
    COMMENT = '{{role_comment}}'
;

-- grant the role to sysadmin
GRANT ROLE {{role_name}} TO ROLE SYSADMIN;

-- confirm role creation
SHOW ROLES LIKE '{{role_name}}';

/*
# Database Role Grants

Include the required database role grants in the below code block.

There should be one role grant for each schema the role needs to access.

For example, if the functional role should be able to read data in schema:

`GRANT DATABASE ROLE CORE.COMMON_READ TO ROLE TABLEAU_TEAM;`

Current access levels within schemas:
- _READ (read-only access)
- _MODIFY (can insert / update / delete data)
- _BUILD (can create presentation-type objects on top of the data)
- _ENGINEER (can create new tables and other objects; just short of sysadmin)
*/

-- switch to securityadmin for role grants
USE ROLE SECURITYADMIN;

-- schema access grants
/*
    Follow the principles of least privilege when granting database roles
        Grant only the minimum necessary and no more
        Database role grants are needed for every database / schema combination
            for which the functional role needs access.
    Model after:
        GRANT DATABASE ROLE [database_name].[schema_name]_[access_level] TO ROLE {{role_name}};
    where
        [database_name] = name of database
        [schema_name] = name of schema within database
        [access_level] = READ / MODIFY / BUILD / ARCHITECT
*/
GRANT DATABASE ROLE [database_role] TO ROLE {{role_name}};

/*
# Warehouse Grants

Include the required warehouse role grants in the below code block.

The role needs at least one warehouse grant, which is already included below if the variables were supplied.

For example, if the functional role needs to use a warehouse to run queries:

`GRANT USAGE ON WAREHOUSE TABLEAU TO ROLE TABLEAU_TEAM;`

A warehouse has two basic grants available:

- USAGE (allows the role to use the warehouse)
- OPERATE (allows the role to start & stop the warehouse)
- MODIFY (allows the role to change the size of the warehouse; use with caution)
- MONITOR (allows the role to see usage information for the warehouse)
*/

-- switch to securityadmin for role grants
USE ROLE SECURITYADMIN;

-- warehouse grants
/*
    Each functional role needs at least one warehouse grant
    Most functional roles need only one warehouse
*/
GRANT USAGE ON WAREHOUSE {{warehouse_name}} TO ROLE {{role_name}};

-- optionally, add operate for functional roles that would need
--   to start & stop a warehouse
--GRANT OPERATE ON WAREHOUSE {{warehouse_name}} TO ROLE {{role_name}};

-- optionally, add modify for functional roles that would neeed
--   to change the size of the warehouse
--GRANT MODIFY ON WAREHOUSE {{warehouse_name}} TO ROLE {{role_name}};

-- optionally, add monitor for functional roles that would need
--   to see usage information for the warehouse
--GRANT MONITOR ON WAREHOUSE {{warehouse_name}} TO ROLE {{role_name}};

/*
# Optional Grants

There are a few account-level functions that can be granted to the functional role. These should be used sparingly as-needed.

Un-comment any required optional grants in the below code block.
*/

-- switch to securityadmin for role grants
USE ROLE SECURITYADMIN;

-- allow execute tasks and managed tasks
/*
GRANT EXECUTE TASK ON ACCOUNT TO ROLE {{role_name}};
GRANT EXECUTE MANAGED TASK ON ACCOUNT TO ROLE {{role_name}};
*/

-- allow lineage functionality
/*
GRANT VIEW LINEAGE ON ACCOUNT TO ROLE {{role_name}};
*/

-- confirm functional role grants
SHOW GRANTS TO ROLE {{role_name}};
