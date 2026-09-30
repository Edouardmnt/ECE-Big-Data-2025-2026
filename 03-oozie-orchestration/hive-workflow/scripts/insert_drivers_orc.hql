-- Chargement transformé CSV -> ORC (rejouable grâce à INSERT OVERWRITE)
-- Attention : la colonne source s'appelle driver_id (et non driverId), cause du premier échec du workflow
INSERT OVERWRITE TABLE ${group}.${hiveUsername}_nyc_drivers
SELECT
  driver_id,
  split(name, ' ')[0]  AS first_name,
  split(name, ' ')[1]  AS last_name,
  ssn,
  location             AS address,
  certified = 'Y'      AS certified,
  wage_plan
FROM ${group}.${hiveUsername}_nyc_drivers_ext;
