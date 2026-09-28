USE ROLE SYSADMIN;

USE DATABASE INGESTION;
USE SCHEMA WORLD_OF_WARCRAFT;

SELECT
    profession.value:id::NUMBER AS PROFESSION_ID
    ,profession.value:name::VARCHAR AS PROFESSION_NAME
    ,profession.value:key:href::VARCHAR AS PROFESSION_URL
    ,profession.value::VARIANT AS PROFESSION_JSON
FROM TABLE(
    FLATTEN(
        INPUT => INGESTION.WORLD_OF_WARCRAFT.CALL_CLIENT_API(BUILD_API_URL('CLIENT', 'profession/index')):professions
    )
) profession
ORDER BY PROFESSION_NAME
;

SELECT CALL_CLIENT_API(URL => 'https://us.api.blizzard.com/data/wow/profession/2787?namespace=static-12.1.0_68914-us');
