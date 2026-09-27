/*
# Setup

***Run this script in its entirety due to the variables***

Use this template notebook to create a new authentication policy.

This notebook contains multiple variables that will need to be set before running.

- database_name: database where the new authentication policy will be stored
  - ex: '' -> 'GOVERNANCE'
- schema_name: schema where the new authentication policy will be stored
  - ex: '' -> 'SECURITY'
- policy_name: name of the new authentication policy
  - ex: '' -> 'PERSON_AUTHENTICATION_POLICY'
- mfa_enrollment: whether or not multi-factor authentication is required
  - for person type users
  - options:
    - REQUIRED
  - ex: '' -> 'REQUIRED'
- authentication_methods: ways the users can log into snowflake
  - comma-separated list with values in single quotes
  - options:
    - ALL
    - SAML
    - OAUTH
    - PROGRAMMATIC_ACCESS_TOKEN
    - KEYPAIR
  - ex: "" -> "'SAML','OAUTH','PROGRAMMATIC_ACCESS_TOKEN'"
- mfa_methods: allowed list of multi-factor authentication methods
  - comma-separated list with values in single quotes
  - options:
    - ALL (default)
    - PASSKEY
    - TOTP (authenticator apps)
    - OTP (one-time passcode)
    - DUO
  - ex: "" -> "'PASSKEY','TOTP'"
- mfa_enforce_external: whether or not to force multi-factor authentication when using SSO providers
  - options:
    - ALL
    - NONE
  - ex: '' -> 'ALL'
- client_types: type of client that can connect to snowflake
  - comma-separated list with values in single quotes
  - options:
    - ALL (default)
    - SNOWFLAKE_UI (website)
    - DRIVERS (required for Tableau)
    - SNOWFLAKE_CLI (command-line app)
    - SNOWSQL (deprecated command-line app)
  - ex: "" -> "'SNOWFLAKE_UI','DRIVERS'"
- pat_default_expiry: default lifetime of a programmatic access token, in days
  - ex: '' -> '30'
- pat_max_expiry: maximum lifetime of a programmatic access token, in days
  - ex: '' -> '30'
- pat_network_policy: whether or not a network policy is required for programattic access tokens
  - options:
    - ENFORCED_REQUIRED (user must have a policy applied, and it's enforced)
    - ENFORCED_NOT_REQUIRED (if policy is applied, it's enforced, but a policy is not required)
    - NOT_ENFORCED (policy is not required; if there is a policy applied, it's not enforced)
  - ex: '' -> 'ENFORCED_REQUIRED'
- policy_commet: description / purpose of the authentication policy

Prerequisites:

- Securityadmin role
*/

/*
database_name = GOVERNANCE
schema_name = SECURITY
policy_name = SERVICE_AUTHENTICATION_POLICY
authentication_methods = 'KEYPAIR'
client_types = 'DRIVERS','SNOWFLAKE_CLI'
policy_comment = Default authentication policy for service users. Policy must be applied to the user, not the account. It controls how a service user can connect to snowflake.
*/

-- securityadmin should be the owner of all authentication policies
USE ROLE SECURITYADMIN;

-- set the context
USE DATABASE GOVERNANCE;
USE SCHEMA SECURITY;

-- create the authentication policy
CREATE OR ALTER AUTHENTICATION POLICY GOVERNANCE.SECURITY.SERVICE_AUTHENTICATION_POLICY
    AUTHENTICATION_METHODS = ('KEYPAIR')
    CLIENT_TYPES = ('DRIVERS','SNOWFLAKE_CLI')
    COMMENT = 'Default authentication policy for service users. Policy must be applied to the user, not the account. It controls how a service user can connect to snowflake.'

-- this section is for person policies specifically
    MFA_ENROLLMENT = OPTIONAL
;

-- confirm policy was created
SHOW AUTHENTICATION POLICIES LIKE 'SERVICE_AUTHENTICATION_POLICY';
