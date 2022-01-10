CREATE VIEW ave_vaccination_per_iso_vac_view AS
    SELECT vbl_iso_code AS iso_code, vbm_vaccine AS vaccine, TRUNC(AVG(vbm_total_vaccinations)) AS daily_average_vaccination
    FROM vaccines_by_location, vaccinations_by_manufacturer
    WHERE vaccines_by_location.vbl_location = vaccinations_by_manufacturer.vbm_location
    GROUP BY vbl_iso_code, vbm_vaccine
    ORDER BY vbl_iso_code;