CREATE FUNCTION monthly_vacs ()
    RETURNS TABLE (
        iso_code VARCHAR(10), 
        month_name TEXT, 
        vaccines TEXT
) 
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
        SELECT loc_iso_code, month_col, STRING_AGG(vaccine, ',') AS vaccines
        FROM (
		    SELECT DISTINCT loc_iso_code, TO_CHAR(vbm_date, 'Month YYYY') AS month_col, vbm_vaccine AS vaccine
		    FROM locations, vaccinations_by_manufacturer
		    WHERE vaccinations_by_manufacturer.vbm_location = locations.loc_name
	    ) AS inner_query   
        GROUP BY loc_iso_code, month_col;
END; $$ 
