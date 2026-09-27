/*
# Setup

***Run this script in its entirety due to the variables.***

Use this template notebook to create a new network policy.

This notebook contains multiple variables that will need to be set before running.

- database_name: database where the network policy will be stored
  - ex: '' -> 'GOVERNANCE'
- schema_name: schema where the network policy will be stored
  - ex: '' -> 'SECURITY'
- policy_name: name of the new network policy
  - ex: '' -> 'GLOBAL_NETWORK_POLICY'
- allowed_rule_list: list of defined network rules to allow
  - comma-separated list of rules in single quotes
  - ex: "" -> "'WHITELIST','ANOTHER_RULE'"
- blocked_rule_list: list of defined network rules to block
  - comma-separated list of rules in single quotes
  - ex: "" -> "'BLACKLIST','OTHER_RULE'"
- allowed_ip_list: list of public IP addresses to allow
  - comma-separated list of IP addresses (or CIDR ranges) in single quotes
  - non-preferred; use network rules
  - ex: "" -> "'123.45.67.89','123.45.67.90'"
- blocked_ip_list: list of public IP addresses to block
  - comma-separated list of IP addresses (or CIDR ranges) in single quotes
  - non-preferred; use network rules
  - ex: "" -> "'100.1.2.3','100.1.2.4'"
- policy_comment: description / purpose for the new network policy
  - ex: '' -> 'Account-wide / global network policy for allowed and blocked public IP addresses.'
 
Prerequisites:

- Securityadmin role
*/

/*
database_name = 'GOVERNANCE'
schema_name = 'SECURITY'
policy_name = 'GLOBAL_NETWORK_POLICY'
allowed_rule_list = "'GLOBAL_ALLOW_LIST'"
blocked_rule_list = "'GLOBAL_BLOCK_LIST'"
allowed_ip_list = "{{allowed_ip_list}}"
blocked_ip_list = "{{blocked_ip_list}}"
policy_comment = 'Global network policy to control networks that can and cannot connect to this account.'
*/

-- securityadmin should own all network policies
USE ROLE SECURITYADMIN;

-- we need to use the database and schema because of the list of network rules
USE DATABASE GOVERNANCE;
USE SCHEMA SECURITY;

-- create the network policy
CREATE OR ALTER NETWORK POLICY GLOBAL_NETWORK_POLICY
    ALLOWED_NETWORK_RULE_LIST = ('GLOBAL_ALLOW_LIST')
    BLOCKED_NETWORK_RULE_LIST = ('GLOBAL_BLOCK_LIST')
    COMMENT = 'Global network policy to control networks that can and cannot connect to this account.'
;

-- confirm the network policy was created
SHOW NETWORK POLICIES LIKE 'GLOBAL_NETWORK_POLICY';

/*
# Optional Apply to Account

To apply the new network policy to the account, uncomment ALTER ACCOUNT below.
*/

-- apply the network policy to the account (optional)
ALTER ACCOUNT SET NETWORK_POLICY = GLOBAL_NETWORK_POLICY;
