-- Account configuration
!source "Accounts/Production Account Configuration.sql"

-- Database deployment: GOVERNANCE
!source "Databases/Governance/GOVERNANCE.sql"
-- Schema deployment: GOVERNANCE.SECURITY
!source "Databases/Governance/Security/SECURITY.sql"
-- Schema deployment: GOVERNANCE.CODE
!source "Databases/Governance/Code/CODE.sql"

-- Database deployment: INGESTION
!source "Databases/Ingestion/INGESTION.sql"
-- Schema deployment: INGESTION.SIMS_4
!source "Databases/Ingestion/Sims 4/SIMS_4.sql"
-- Schema deployment: INGESTION.STARDEW_VALLEY
!source "Databases/Ingestion/Stardew Valley/STARDEW_VALLEY.sql"
-- Schema deployment: INGESTION.WORLD_OF_WARCRAFT
!source "Databases/Ingestion/World of Warcraft/WORLD_OF_WARCRAFT.sql"

-- Database deployment: GAMING
!source "Databases/Gaming/GAMING.sql"
-- Schema deployment: GAMING.SIMS_4
!source "Databases/Gaming/Sims 4/SIMS_4.sql"
-- Schema deployment: GAMING.STARDEW_VALLEY
!source "Databases/Gaming/Stardew Valley/STARDEW_VALLEY.sql"
-- Schema deployment: GAMING.WORLD_OF_WARCRAFT
!source "Databases/Gaming/World of Warcraft/WORLD_OF_WARCRAFT.sql"

-- Database deployment: MAINTENANCE
!source "Databases/Maintenance/MAINTENANCE.sql"
-- Schema deployment: MAINTENANCE.SIMS_4
!source "Databases/Maintenance/Sims 4/SIMS_4.sql"
-- Schema deployment: MAINTENANCE.STARDEW_VALLEY
!source "Databases/Maintenance/Stardew Valley/STARDEW_VALLEY.sql"
-- Schema deployment: MAINTENANCE.WORLD_OF_WARCRAFT
!source "Databases/Maintenance/World of Warcraft/WORLD_OF_WARCRAFT.sql"

-- Database deployment: PRESENTATION
!source "Databases/Presentation/PRESENTATION.sql"
-- Schema deployment: PRESENTATION.SIMS_4
!source "Databases/Presentation/Sims 4/SIMS_4.sql"
-- Schema deployment: PRESENTATION.STARDEW_VALLEY
!source "Databases/Presentation/Stardew Valley/STARDEW_VALLEY.sql"
-- Schema deployment: PRESENTATION.WORLD_OF_WARCRAFT
!source "Databases/Presentation/World of Warcraft/WORLD_OF_WARCRAFT.sql"

-- Network rule deployment: GLOBAL_ALLOW_LIST
!source "Databases/Governance/Security/Network Rules/GLOBAL_ALLOW_LIST.sql"
-- Network rule deployment: GLOBAL_BLOCK_LIST
!source "Databases/Governance/Security/Network Rules/GLOBAL_BLOCK_LIST.sql"
-- Network policy deployment: GLOBAL_NETWORK_POLICY
!source "Databases/Governance/Security/Network Policies/GLOBAL_NETWORK_POLICY.sql"
-- Password policy deployment: GLOBAL_PASSWORD_POLICY
!source "Databases/Governance/Security/Password Policies/GLOBAL_PASSWORD_POLICY.sql"
-- Authentication policy deployment: SERVICE_AUTHENTICATION_POLICY
!source "Databases/Governance/Security/Authentication Policies/SERVICE_AUTHENTICATION_POLICY.sql"
-- Authentication policy deployment: PERSON_AUTHENTICATION_POLICY
!source "Databases/Governance/Security/Authentication Policies/PERSON_AUTHENTICATION_POLICY.sql"
