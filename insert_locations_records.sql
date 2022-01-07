CREATE PROCEDURE insert_locations_records()
LANGUAGE plpgsql
AS
$$
BEGIN
    INSERT INTO locations ( loc_name, loc_iso_code )
    SELECT DISTINCT vbl_location, vbl_iso_code
    FROM vaccines_by_location

    COMMIT;
END;
$$