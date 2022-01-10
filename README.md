# se2121-finals-covidvaccine

1. create covid_db
   - i used CREATE DATABASE covid_db to create a database named 'covid_db'
   - used CREATE TABLE to create required tables inside my covid_db
   - each table has its own column parameters which specifies the names of columns on that particular table, column datatype is also specified
2. import datasets
   - in importing datasets, i first downloaded the given csv files
   - i used COPY my_table_name ( my_table_column1, ...) FROM the csv file path to import the datasets from the csv file. and i made sure that the datatype are compatible.
3. procedures
   - insert records from vbl to locations table
     - made use of PROCEDURE procedure_name() and the format when creating a procedure
       -in the execution part, i just inserted distinct location and iso code from the vbl table to locations table. the locations table has parameters which has the same order as the columns i want to have its data from
   - insert needed records from vbm to vaccines table
     - this one's challenging because of the stringed group of vaccines, i tried so many functions and failed
     - in the execution part, i used egexp_split_to_array() function from postgresql to split the stringed vaccine group having ',' separator. the for each of those vaccines, i made a nested loop that inserts into vaccines table the vaccine names i got from the split function and trimmed the array types leaving the stringed type vaccines to be inserted on the vaccines table.
   - update vaccination number
     - here i get INPUTS that determines the data to be changed and the new data to replace.
     - in the execution part, i used UPDATE statement specifiying the vbm table for it holds the vaccination number, using the SET statement, it sets the inputted new_total_vaccination value in the vbm_total_vaccination in the condition where the specified loc, vaccine and date in the INPUT parameters are met.
4. populate the tables using the procedures created
   - i first run the sql file and after the procedures was created, i call the procedures and it populated the tables
5. functions
   - return a table containing the vaccines used per month for each iso_code.
     -what i did is that i created a function that RETURNS TABLE with my needed columns as parameters, in this case iso_code, month_name, and vaccines.
     - in the execution, returning a query creates a table and i made sure that i am returning compatible data types to the parameters of the table.
     - first, i made the inner query that gets the distinct loc_iso_code if the vbm_location is equal to the iso_code's location name, used TO_CHAR() to convert the date data to month names and gave it month_col as alias, and distinct vaccine name.
     - for the outer query, i get the loc_iso_code, month_col data, and used STRING_AGG() function to join the vaccine names that have the same loc_iso_code and month_col with ',' separator.
   - return no. of vaccinations each month per vaccines with location and date yyyy-mm as INPUT parameters
     - i created a function with Input parameters
     - in the execution, i RAISE a string that has a Date with 'Mon. YYYY' format, to do this i converted the INPUT date string into a timestamp using TO_TIMESTAMP() then converted it into a string with 'Mon. YYYY' format.
     - then i have made a nested query that gives me a table of vaccination per vaccine using the INPUTted location and month, and the total vaccination in a certain month per vaccine. to do this, i get the vaccines names from vbm vaccine where it has the same location as the inputted one, and again using the TO_TIMESTAMP() and TO_CHAR() functions to compare if the months of the dates in the datasets are the same with the inputted one. and get the sum of total_vaccinations that are grouped by each name of the vaccines.
     - i looped through the nested query i made and then for each record, i raised notice using the record's vaccine name and number of vaccination per vaccine.
     - i made an if statement that if location or date inputted is invalid, it will just show the invalid statement
   - return top 10 vaccinations count per location
     - i looped through the records given by the query that gets the location, convert date to yyyy-mm-dd string format using TO_CHAR(), added all total vaccinations that are grouped by tha same location and vaccination date, ordered total_vaccinations into a descending manner to get the highest at number 1, and only get 10 records. each record of the query, i RAISE NOTICE with a string in a format that uses a counter to get the rank of each record.
6. daily average vaccinations per iso_code per vaccines VIEW
   - created the view using the CREATE VIEW AS <<query>> format
   - i selected iso code from the vbl, vaccines from vbm_vaccine and get the average of the total vaccination that are grouped by the same iso_code and vaccine name
