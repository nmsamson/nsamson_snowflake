USE ROLE SYSADMIN;

USE DATABASE INGESTION;
USE SCHEMA WORLD_OF_WARCRAFT;

CREATE OR REPLACE FUNCTION INGESTION.WORLD_OF_WARCRAFT.CALL_CLIENT_API(
    REGION VARCHAR
    ,BASE_URL VARCHAR
    ,ENDPOINT VARCHAR
    ,NAMESPACE VARCHAR
    ,LOCALE VARCHAR
)
    RETURNS VARIANT
    LANGUAGE PYTHON
    RUNTIME_VERSION = '3.12'
    HANDLER = 'get_json'
    EXTERNAL_ACCESS_INTEGRATIONS = (WORLD_OF_WARCRAFT_CLIENT_ACCESS)
    SECRETS = ('oauth_client' = INGESTION.WORLD_OF_WARCRAFT.OAUTH_CLIENT)
    PACKAGES = ('requests')
AS
$$
import _snowflake
import requests

def get_json(url, namespace, locale):
    token = _snowflake.get_oauth_access_token('oauth_client')
    response = requests.get(
        url,
        headers = {'Authorization':'Bearer ' + token},
        params = {'namespace':namespace, 'locale':locale},
        timeout = 20
    )

    response.raise_for_status()
    return response.json()
$$
;
