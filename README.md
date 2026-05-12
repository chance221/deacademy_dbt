
NOTES:
DBT models just transform existing tables into views, or tables based on the configuration values you pass into them.

The initial connection set up on the partner account in snowflake will dictate what DBT has access to so if it needs access to a different database, table or schema you need to update the partner connections in snowflake. (There is an API that is accessible but cost are associated with accessing)

Each model sql file will be linked to a .yml file that will house the instructions on what needs to be run and in what order.

The SQL file will hold the transformation instructions on what to do to the table to be transformed. The .yml file will tell the dbt model what table to transform and from where as well as what to create after the transformation is done.

Here we are creating a materialized table meaning after the transformation it will store the data in a table in the associated snowflake database as employee

Notice that employee is the table to be created based on the name of the model and is referenced in the .yml file and the SQL file.
If you do not provide a materialization config value it will default to store it to the associated database as a view.
You can provide multiple materialization values on the type of table to use and details on what type of materialization can be found here: https://docs.getdbt.com/docs/build/materializations
There are different types of materializations and you need to pick the right one for your needs. READ the DOCS for which one works best and why!
The .yml file will hold the source (snowflake warehouse location and the test to be run and on what columns.

The first set of test are built in checks that can be used against a column. You can set these up to wither fail a dbt run or just provide a warning.

The second set of test are custom that use a specific standardized syntax that will run for every column. The test file salary_check is created to hold the custom test and will be run just like the built in test, as long as your provide the correct format then tell the .yml file to run that test on a specific column.
