USE ROLE SYSADMIN;

USE DATABASE INGESTION;
USE SCHEMA WORLD_OF_WARCRAFT;

CREATE OR REPLACE FUNCTION INGESTION.WORLD_OF_WARCRAFT.CALL_CLIENT_API(
    URL VARCHAR
    ,NAMESPACE VARCHAR
    ,LOCALE VARCHAR
)
    RETURNS VARIANT
    LANGUAGE PYTHON
    RUNTIME_VERSION = '3.12'
    HANDLER = 'get_json'
    EXTERNAL_ACCESS_INTEGRATIONS = (WORLD_OF_WARCRAFT_CLIENT_ACCESS)
    SECRETS = ('oauth_client' = INGESTION.WORLD_OF_WARCRAFT.CLIENT)
    PACKAGES = ('requests')
AS
$$
import _snowflake
import requests
from urllib.parse import urlparse, parse_qs

def get_json(url, namespace, locale):
    token = _snowflake.get_oauth_access_token('oauth_client')
    existing_params = parse_qs(urlparse(url).query)

    params = {}
    if 'namespace' not in existing_params:
        params['namespace'] = namespace
    if 'locale' not in existing_params:
        params['locale'] = locale
        
    response = requests.get(
        url,
        headers = {'Authorization':'Bearer ' + token},
        params = params,
        timeout = 20
    )

    response.raise_for_status()
    return response.json()
$$
;

CREATE OR REPLACE FUNCTION INGESTION.WORLD_OF_WARCRAFT.CALL_CLIENT_API(
    URL VARCHAR
)
    RETURNS VARIANT
    LANGUAGE SQL
AS
$$
    INGESTION.WORLD_OF_WARCRAFT.CALL_CLIENT_API(
        URL,
        INGESTION.WORLD_OF_WARCRAFT.GET_API_PART('DEFAULT_NAMESPACE'),
        INGESTION.WORLD_OF_WARCRAFT.GET_API_PART('DEFAULT_LOCALE')
    )
$$
;
