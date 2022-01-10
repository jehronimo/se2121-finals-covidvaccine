CREATE FUNCTION monthly_vacs ()
    RETURNS TABLE (
        iso_code VARCHAR(10), 
        month VARCHAR(500), 
        vaccines TEXT
) 
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN QUERY
    
END; $$ 
