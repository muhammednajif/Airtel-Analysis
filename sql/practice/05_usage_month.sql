
-- ==================================================
-- 05_usage_month.sql
-- What this file fixes : a monthly view, from usage
-- Defect numbers       : 4 from the Quality Log
-- THE JUNE RULE        : recharges stops on 2025-06-27
--   and June payments are incomplete. No monthly
--   revenue series may include June 2025. usage_daily
--   is complete to 2025-06-30 and is not affected.
-- Written by           : <your name>
-- ==================================================

DROP VIEW IF EXISTS v_usage_month;

CREATE VIEW v_usage_month AS
SELECT customer_id,
       strftime('%Y-%m', usage_date) AS month,
       COUNT(*)           AS usage_days,
       SUM(data_mb)       AS total_mb,
       SUM(voice_minutes) AS total_voice,
       SUM(is_roaming)    AS roaming_days
FROM   usage_daily
GROUP BY customer_id,
         strftime('%Y-%m', usage_date);

