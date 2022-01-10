CREATE FUNCTION get_vaccinations_per_vaccine (
  loc VARCHAR(90),
  yyyy_mm_str VARCHAR(10)
)
RETURNS VOID
LANGUAGE plpgsql
AS
$$
DECLARE
  var_r record;
BEGIN
  RAISE NOTICE 'For the month of %:', TO_CHAR(TO_TIMESTAMP(yyyy_mm_str, 'YYYY-MM'), 'Mon. YYYY');
  FOR var_r IN 
    SELECT vbm_vaccine, SUM(vbm_total_vaccinations) AS vaccination_per_vac
    FROM (SELECT vbm_vaccine, vbm_total_vaccinations, vbm_location, vbm_date 
          FROM vaccinations_by_manufacturer
          WHERE vbm_location = loc AND TO_CHAR(TO_TIMESTAMP(yyyy_mm_str, 'YYYY-MM'), 'Mon. YYYY') = TO_CHAR(vbm_date, 'Mon. YYYY')
          GROUP BY vbm_vaccine, vbm_total_vaccinations, vbm_location, vbm_date ) as query
    GROUP BY vbm_vaccine 

      LOOP
      RAISE NOTICE ' % has % vaccinations,', var_r.vbm_vaccine, var_r.vaccination_per_vac;
      END LOOP;

    IF NOT FOUND THEN 
      RAISE NOTICE 'the country is non-existing or the date is invalid.';
    END IF;

END;
$$