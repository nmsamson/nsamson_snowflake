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
database_name = {{database_name}}
schema_name = {{schema_name}}
policy_name = {{policy_name}}
password_min_length = {{password_min_length}}
password_max_length = {{password_max_length}}
password_min_upper = {{password_min_upper}}
password_min_lower = {{password_min_lower}}
password_min_numeric = {{password_min_numeric}}
password_min_special = {{password_min_special}}
password_min_age = {{password_min_age}}
password_max_age = {{password_max_age}}
password_max_retries = {{password_max_retries}}
password_lockout_time = {{password_lockout_time}}
password_history = {{password_history}}
policy_comment = {{policy_comment}}
*/

-- use securityadmin role to creat the password policy
USE ROLE SECURITYADMIN;

-- set context
USE DATABASE {{database_name}};
USE SCHEMA {{schema_name}};

-- create the password policy
CREATE PASSWORD POLICY IF NOT EXISTS {{policy_name}}
    PASSWORD_MIN_LENGTH = {{password_min_length}}
    PASSWORD_MAX_LENGTH = {{password_max_length}}
    PASSWORD_MIN_UPPER_CASE_CHARS = {{password_min_upper}}
    PASSWORD_MIN_LOWER_CASE_CHARS = {{password_min_lower}}
    PASSWORD_MIN_NUMERIC_CHARS = {{password_min_numeric}}
    PASSWORD_MIN_SPECIAL_CHARS = {{password_min_special}}
    PASSWORD_MIN_AGE_DAYS = {{password_min_age}}
    PASSWORD_MAX_AGE_DAYS = {{password_max_age}}
    PASSWORD_MAX_RETRIES = {{password_max_retries}}
    PASSWORD_LOCKOUT_TIME_MINS = {{password_lockout_time}}
    PASSWORD_HISTORY = {{password_history}}
    COMMENT = '{{policy_comment}}'
;

-- confirm policy creation
SHOW PASSWORD POLICIES LIKE '{{policy_name}}';

-- apply policy to account
ALTER ACCOUNT SET PASSWORD POLICY {{database_name}}.{{schema_name}}.{{policy_name}};
