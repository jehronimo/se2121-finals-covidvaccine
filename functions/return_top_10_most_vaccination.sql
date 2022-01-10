CREATE FUNCTION top_10_vaccinations () 
    RETURNS VOID
LANGUAGE plpgsql
AS
$$
DECLARE
var_r record;
var_counter INT := 1;
BEGIN
    FOR var_r IN (SELECT vbm_location AS loc,
                TO_CHAR(vbm_date, 'YYYY-MM-DD') AS vaccination_date,
                SUM(vbm_total_vaccinations) AS total_vaccinations
                FROM vaccinations_by_manufacturer
                GROUP BY loc, vaccination_date
                ORDER BY total_vaccinations DESC
                LIMIT 10)
        LOOP 
            RAISE NOTICE 'Top % - % with % vaccinations on %' , var_counter, var_r.loc, var_r.total_vaccinations, var_r.vaccination_date;
                var_counter := var_counter + 1;
        END LOOP;

END; $$ 
