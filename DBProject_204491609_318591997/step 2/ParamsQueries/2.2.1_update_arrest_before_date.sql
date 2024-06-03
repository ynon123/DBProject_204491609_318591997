update arrest
set released = 'Y'
where ARREST_DATE > &input_date -- I didn't run this on the database
