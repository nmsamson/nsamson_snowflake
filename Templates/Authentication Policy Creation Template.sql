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
database_name = {{database_name}}
schema_name = {{schema_name}}
policy_name = {{policy_name}}
mfa_enrollment = {{mfa_enrollment}}
authentication_methods = {{authentication_methods}}
mfa_methods = {{mfa_methods}}
mfa_enforce_external = {{mfa_enforce_external}}
client_types = {{client_types}}
pat_default_expiry = {{pat_default_expiry}}
pat_max_expiry = {{pat_max_expiry}}
pat_network_policy = {{pat_network_policy}}
policy_comment = {{policy_comment}}
*/

-- securityadmin should be the owner of all authentication policies
USE ROLE SECURITYADMIN;

-- set the context
USE DATABASE {{database_name}};
USE SCHEMA {{schema_name}};

-- create the authentication policy
CREATE OR ALTER AUTHENTICATION POLICY {{database_name}}.{{schema_name}}.{{policy_name}}
    AUTHENTICATION_METHODS = ({{authentication_methods}})
    CLIENT_TYPES = ({{client_types}})
    COMMENT = '{{policy_comment}}'

-- this section is for person policies specifically
    MFA_ENROLLMENT = {{mfa_enrollment}}
    MFA_POLICY = 
    (
        ALLOWED_METHODS = ({{mfa_methods}})
        ENFORCE_MFA_ON_EXTERNAL_AUTHENTICATION = {{mfa_enforce_external}}
    )
    PAT_POLICY = 
    (
        DEFAULT_EXPIRY_IN_DAYS = {{pat_default_expiry}}
        MAX_EXPIRY_IN_DAYS = {{pat_max_expiry}}
        NETWORK_POLICY_EVALUATION = {{pat_network_policy}}
    )
;

-- confirm policy was created
SHOW AUTHENTICATION POLICIES LIKE '{{policy_name}}';
