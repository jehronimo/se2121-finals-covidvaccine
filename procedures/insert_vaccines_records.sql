CREATE PROCEDURE insert_vaccines_records()
LANGUAGE plpgsql
AS
$$
DECLARE
vaccines VARCHAR(500)[];
vaccine VARCHAR(500);
BEGIN

FOR vaccines IN SELECT DISTINCT regexp_split_to_array(vbl_vaccines, ',') 
                FROM vaccines_by_location
    LOOP
        FOREACH vaccine IN ARRAY vaccines
            LOOP
                INSERT INTO vaccines(vac_name) 
                VALUES (TRIM(vaccine)) 
                ON CONFLICT (vac_name) DO NOTHING;
            END LOOP;
    END LOOP;
COMMIT;
END;
$$