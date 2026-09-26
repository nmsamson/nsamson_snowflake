/*
# Setup

***Run this script in its entirety due to the variables***

Use this template notebook to create a new Snowflake account in the organization.

This notebook should be run in an account with orgadmin enabled.

This notebook contains multiple variables that will need to be set before running.

- account_name: enter the name for the account
  - should be uppercase with only letters and number
  - ex: '' -> 'PRODUCTION'
  - this will appear in the url behind the hyphen, so make it meaningful
    - ex: ATLASATOMICS-PRODUCTION.snowflakecomputing.com
- admin_name: username for the first admin user of the new account
  - should be uppercase
  - ex: '' -> 'ATLAS_ADMIN'
- admin_password: password to use for the admin user's login
  - will be prompted to change on first login
  - use a generic password, not one currently in use anywhere
  - ex: '' -> 'P@ssw0rd20260901'
- first_name: first name for the admin user
  - should be mixed / camel case
  - ex: '' -> 'Atlas'
- last_name: last name for the admin user
  - should be mixed / camel case
  - ex: '' -> 'Admin'
- admin_email: e-mail address for the admin user
  - this should be a valid e-mail address
  - can be lowercase, mixed case, or uppercase
  - ex: '' -> 'aadmin@atlasatomics.com'"
- edition: Snowflake edition for the new account
  - can be different from the other accounts in the org
  - options:
    - STANDARD
    - ENTERPRISE
    - BUSINESS_CRITICAL
- region: cloud provider and location
  - see [Sowflake Region IDs](https://docs.snowflake.com/en/user-guide/admin-account-identifier#label-snowflake-region-ids)
  - use the Snowflake Region ID:
    - AWS_US_WEST_2
    - GCP_US_CENTRAL1
    - AZURE_SOUTHCENTRALUS
- account_comment: purpose or description of the new account
  - ex: '' -> 'Primary production environment for Atlas Atomics'
 
Prerequisites:

- Snowflake organization
- Orgadmin role

*Run this notebook from an account with orgadmin enabled.*
*/

/*
account_name = '{{account_name}}'
admin_name = '{{admin_name}}'
admin_password = '{{admin_password}}'
first_name = '{{first_name}}'
last_name = '{{last_name}}'
admin_email = '{{admin_email}}'
edition = '{{edition}}'
region = '{{region}}'
comment = '{{comment}}'
*/

/*
display_name = '{{display_name}}' <- first_name + ' ' + last_name
*/

-- use orgadmin role for account creation
USE ROLE ORGADMIN;

-- create a new account in AWS US West (Oregon) region with Enterprise edition
CREATE ACCOUNT {{account_name}}
    ADMIN_NAME = '{{admin_name}}'
    ADMIN_PASSWORD = '{{admin_password}}'
    ADMIN_USER_TYPE = 'PERSON'
    FIRST_NAME = '{{first_name}}'
    LAST_NAME = '{{last_name}}'
    EMAIL = '{{admin_email}}'
    MUST_CHANGE_PASSWORD = TRUE
    EDITION = {{edition}}
    REGION = {{region}}
    COMMENT = '{{comment}}'
;

-- confirm account creation (this may take several minutes to populate)
SHOW ACCOUNTS LIKE '{{account_name}}';
