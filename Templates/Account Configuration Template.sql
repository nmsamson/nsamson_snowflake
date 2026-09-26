/*
# Setup

***Run this script in its entirety due to the variables***

Use this template notebook to configure a newly created Snowflake account.

This notebook must be run in the new account.

This notebook contains multiple variables that will need to be set before running.

- timezone: timezone for the account
  - see [IANA Time-Zones](https://data.iana.org/time-zones/tzdb-2025b/backward)
  - ex: '' -> 'US/Central'
 
Prerequisites:

- Snowflake organization
- Orgadmin role

*Run this notebook from the new account.*
*/

/*
timezone = '{{timezone}}'
*/

/*
# Set Timezone

To help with viewing and storing timestamps, change the time zone of the account, which is stored in an account parameter.
*/

-- use accountadmin so we can alter the account settings
USE ROLE ACCOUNTADMIN;

-- update the timezone on the account
ALTER ACCOUNT SET TIMEZONE = '{{timezone}}';

-- confirm the timezone change
SHOW PARAMETERS LIKE 'TIMEZONE' IN ACCOUNT;
