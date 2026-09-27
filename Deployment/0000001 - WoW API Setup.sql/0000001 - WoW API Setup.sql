-- Network rule deployment: WORLD_OF_WARCRAFT_OUTBOUND
!source "Databases/Governance/Security/Network Rules/WORLD_OF_WARCRAFT_OUTBOUND.sql"

-- Security integration deployment: WORLD_OF_WARCRAFT_CLIENT
!source "Security/Integrations/WORLD_OF_WARCRAFT_CLIENT.sql"
-- External access integration deployment: WORLD_OF_WARCRAFT_CLIENT_ACCESS
!source "Security/Integrations/WORLD_OF_WARCRAFT_CLIENT_ACCESS.sql"
-- Security integration deployment: WORLD_OF_WARCRAFT_PROFILE
--!source "Security/Integrations/WORLD_OF_WARCRAFT_PROFILE.sql"

-- Secret deployment: CLIENT
-- Secret deployment: PROFILE

-- Function deployment: CALL_CLIENT_API
!source "Databases/Ingestion/World of Warcraft/Functions/CALL_CLIENT_API.sql"
