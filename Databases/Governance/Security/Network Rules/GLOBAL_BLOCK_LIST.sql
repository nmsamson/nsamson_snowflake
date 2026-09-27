/*
# Setup

***Run this script in its entirety due to the variables.***

Use this template notebook to create a new network rule, which is essentially a list of network addresses to be used with a network policy.

Unlike the other templates, the list of values will need to be entered in the code itself.

This notebook contains multiple variables that will need to be set before running.

- database_name: database where the network rule should be stored
  - ex: '' -> 'GOVERNANCE'
- schema_name: schema where the network rule should be stored
  - ex: '' -> 'COMMON'
- rule_name: enter the name of the new network rule
  - be descriptive, since it will be used in a network policy
  - ex: '' -> 'WHITELIST_RULE'
- rule_type: type of network rule being created
  - options:
    - IPV4 (most common)
    - IPV6
    - AWSPCEID
    - AZURELINKID
    - GCPPSCID
    - HOST_PORT
    - PRIVATE_HOST_PORT
    - COMPUTE_POOL
  - ex: '' -> 'IPV4'
- value_list: comma-separated list of IP addresses (or ranges) in single quotes
  - ***this is the public IP address, not the internal IP address
    - it's not something that starts with 10. or 192.
  - ex: "" -> "'123.45.67.89', '123.45.67.90'"

        -- formatting
        all IP addresses: 0.0.0.0/0
        all IP addresses between 123.0.0.0 and 123.255.255.255: 123.0.0.0/8
        all IP addresses between 123.45.0.0 and 123.45.255.255: 123.45.0.0/16
        all IP addresses between 123.45.67.0 and 123.45.67.255: 123.45.67.0/24
        all IP addresses between 123.45.67.0 and 123.45.67.127: 123.45.67.0/25
        all IP addresses between 123.45.67.128 and 123.45.67.255: 123.45.67.128/25
        basically:
           /0  : all IPv4 addresses
           /8  : 16,777,216 addresses (first block supplied)
           /16 : 65,536 addresses (first two blocks supplied)
           /24 : 256 addresses (first three blocks supplied)

           -- beyond this granularity is likely unnecessary
           /25 : 128 addresses (all four blocks supplied)
           /26 : 64 addresses (all four blocks supplied)
           /27 : 32 addresses (all four blocks supplied)
           /28 : 16 addresses (all four blocks supplied)
           /29 : 8 addresses (all four blocks supplied)
           /30 : 4 addresses (all four blocks supplied)
           /31 : 2 addresses (all four blocks supplied)

           -- same as supplying the single full IP address
           /32 : 1 address (the /32 is optional; just use the single IP address)
 - mode: mode / direction of network rule
   - options:
     - INGRESS (most common)
     - EGRESS
     - INTERNAL_STAGE
     - SNOWFLAKE_MANAGED_STORAGE_VOLUME
  - ex: '' -> 'INGRESS'
- comment: description / purpose of the network rule
  - ex: '' -> 'Allowed IP addresses'
 
Prerequisites:

- Securityadmin role
*/

/*
database_name = 'GOVERNANCE'
schema_name = 'SECURITY'
rule_name = 'GLOBAL_BLOCK_LIST'
rule_type = 'IPV4'
value_list = ""
mode = 'INGRESS'
rule_comment = 'List of IP addresses blocked from connecting to the account. This is the global (broad) list applied to the entire account.'
*/

-- securityadmin should own the network rules
USE ROLE SECURITYADMIN;

-- use the database and schema
USE DATABASE GOVERNANCE;
USE SCHEMA SECURITY;

-- create the network rule
CREATE NETWORK RULE IF NOT EXISTS GLOBAL_BLOCK_LIST
    TYPE = IPV4
    VALUE_LIST = ()
    MODE = INGRESS
    COMMENT = 'List of IP addresses blocked from connecting to the account. This is the global (broad) list applied to the entire account.'
;

SHOW NETWORK RULES LIKE 'GLOBAL_BLOCK_LIST';
