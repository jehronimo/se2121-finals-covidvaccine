CREATE PROCEDURE update_vaccination_no(
    new_total_vaccination INT,
    vaccine VARCHAR(80),
    loc VARCHAR(90),
    date DATE
)

LANGUAGE plpgsql
AS
$$
BEGIN
    UPDATE vaccinations_by_manufacturer
    SET vbm_total_vaccinations = new_total_vaccination
    WHERE vbm_location = loc AND vbm_vaccine = vaccine AND vbm_date = date;
    COMMIT;
END;
$$