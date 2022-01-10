CREATE FUNCTION  return_monthly_vaccinations_per_vac(loc_name VARCHAR(90), yyyy_mm_str VARCHAR(10)) 
    RETURNS VOID
LANGUAGE plpgsql
AS
$$
DECLARE
var_r record;
output_str_arr TEXT[];
var_str VARCHAR(90);
var_date VARCHAR(10);
output_str TEXT := '';

BEGIN	
    FOR var_r IN (SELECT vbm_vaccine AS vaccine, vbm_total_vaccinations AS total_vaccinations, vbm_date AS date_var
                FROM vaccinations_by_manufacturer
                WHERE vbm_location = loc_name AND TO_CHAR(vbm_date, 'YYYY-MM') = yyyy_mm_str)
    
        LOOP
            -- var_date := TO_CHAR(var_r.date_var, 'Mon. YYYY');
            output_str = output_str + ('% has % vaccinations, ', var_r.vaccine, var_r.total_vaccinations);
        END LOOP

    -- FOREACH var_str IN ARRAY output_str_arr

    --     LOOP
    --         concat(output_str, var_str);
    --     END LOOP;

    RAISE_NOTICE output_str;
            
END; $$ 
