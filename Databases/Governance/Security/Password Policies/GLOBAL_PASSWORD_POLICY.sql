/*
# Setup

***Run this script in its entirety due to the variables***

Use this template notebook to create a new password policy.

This notebook contains multiple variables that will need to be set before running.

- database_name: database where the policy will be stored
  - ex: '' -> 'GOVERNANCE'
- schema_name: schema where the policy will be stored
  - ex: '' -> 'SECURITY'
- policy_name: name of the new password policy
  - ex: '' -> 'GLOBAL_PASSWORD_POLICY'
- password_min_length: minimum length for passwords
  - ex: '' -> '24'
- password_max_length: maximum length for passwords
  - ex: '' -> '128'
- password_min_upper: minimum number of uppercase letters
  - ex: '' -> '3'
- password_min_lower: minimum number of lowercase letters
  - ex: '' -> '3'
- password_min_numeric: minimum number of numerics
  - ex: '' -> '3'
- password_min_special: minimum number of special characters
  - ex: '' -> '3'
- password_min_age: minimum lifetime of a password, in days
  - controls how soon after a password is created that it can be reset
  - ex: '' -> '1'
- password_max_age: maximum lifetime of a password in days
  - controls how often passwords need to be reset
  - ex: '' -> '30'
- password_max_retries: maximum number of times a password can be entered unsuccessfully before the user is locked out
  - ex: '' -> '5'
- password_lockout_time: amount of time (in minutes) the user is locked out after too many unsuccessful login attempts
  - ex: '' -> '60'
- password_history: how many past passwords are checked for reuse
  - ex: '' -> '10'
- policy_comment: description / purpose for the password policy
  - ex: '' -> 'Global minimum password policy for the account, to control strength and cycling'

Prerequisites:

- Securityadmin role
*/

/*
database_name = GOVERNANCE
schema_name = SECURITY
policy_name = GLOBAL_PASSWORD_POLICY
password_min_length = 24
password_max_length = 128
password_min_upper = 1
password_min_lower = 1
password_min_numeric = 1
password_min_special = 1
password_min_age = 0
password_max_age = 90
password_max_retries = 5
password_lockout_time = 60
password_history = 12
policy_comment = Global password policy for the account. Controls minimum requirements for all passwords created. Additional password policies can be created and applied to individual users for stricter requirements if needed.
*/

-- use securityadmin role to creat the password policy
USE ROLE SECURITYADMIN;

-- set context
USE DATABASE GOVERNANCE;
USE SCHEMA SECURITY;

-- create the password policy
CREATE PASSWORD POLICY IF NOT EXISTS GLOBAL_PASSWORD_POLICY
    PASSWORD_MIN_LENGTH = 24
    PASSWORD_MAX_LENGTH = 128
    PASSWORD_MIN_UPPER_CASE_CHARS = 1
    PASSWORD_MIN_LOWER_CASE_CHARS = 1
    PASSWORD_MIN_NUMERIC_CHARS = 1
    PASSWORD_MIN_SPECIAL_CHARS = 1
    PASSWORD_MIN_AGE_DAYS = 0
    PASSWORD_MAX_AGE_DAYS = 90
    PASSWORD_MAX_RETRIES = 5
    PASSWORD_LOCKOUT_TIME_MINS = 60
    PASSWORD_HISTORY = 12
    COMMENT = 'Global password policy for the account. Controls minimum requirements for all passwords created. Additional password policies can be created and applied to individual users for stricter requirements if needed.'
;

-- confirm policy creation
SHOW PASSWORD POLICIES LIKE 'GLOBAL_PASSWORD_POLICY';

-- apply policy to account
ALTER ACCOUNT SET PASSWORD POLICY GOVERNANCE.SECURITY.GLOBAL_PASSWORD_POLICY;
