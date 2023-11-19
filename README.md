# sql_powerbi_email_mkt
This project was developed in SQL and Power BI, using an anonymized private database. 

The development had those steps:
- Understanding the data available in the CSV file.
- Create the script for the MySql database using a CSV file.
- Create the PowerBI connection with the MySql database.
- Create the Power BI Viz with analysis about email marketing.

**Script MySql:**

This SQL script in MySQL performs the following operations:

1. Creating a table for monthly goals and loading data from a CSV file.
2. Creation of a table to represent the days of the month.
3. Creating a table for daily goals, and populating it with data from the monthly goals table.
4. Creating a complex table called 'FUNIL' and loading data from a CSV file.
5. Creation and filling of auxiliary tables ('ACCOUNT', 'MONTHS', 'ICP_SCORE', 'ETAPAS') with different data from the 'FUNIL' table.

In short, the script organizes goal and sales funnel data into several tables in a MySQL database.

**Power BI Data Model:**

The tables created in the database were added to PowerBI and the relationships already prepared in the database were represented here to enable complete data analysis.
![image](https://github.com/marciaback/sql_powerbi_email_mkt/assets/45545675/be2ee951-6273-4e21-b0bc-3632a3095a46)

**Power BI Dashboard:**

Several analyses were developed to understand the progress of the email marketing, funnel and conversion process.
- This project was prepared in Portuguese.
![image](https://github.com/marciaback/sql_powerbi_email_mkt/assets/45545675/8fa61d7b-2038-4e35-b411-6aaff7165e55)
![image](https://github.com/marciaback/sql_powerbi_email_mkt/assets/45545675/baafaf87-58f6-4571-b740-d4422dea5474)
![image](https://github.com/marciaback/sql_powerbi_email_mkt/assets/45545675/1fb43111-e1cd-45dc-87f3-ab8f20cca7cf)
![image](https://github.com/marciaback/sql_powerbi_email_mkt/assets/45545675/999c005d-eea9-4214-94c6-93cf3df8fa32)
