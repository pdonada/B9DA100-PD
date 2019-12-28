How to use bill_management app:

Execute the file bill_management.py. It is going to return the main menu. 
You can go back to the menu anytime typing 0.

Hello, Welcome to the Bill Management Company
1: View Bills
2: Insert a Bill
3: Reports
4: T&Cs
5: Exit

* Option 1: Calling the option 1 will show all the bills already in the file bills.csv.

* Option 2: This will start the input mode in the follwing order:
	a. Company name. It will accept any character;
	b. Customer name. It will accept any character;
	c. Date of the bill. Is going to validate the format: yyyy-mm-dd (2019-12-30);
	d. Total value of the bill. It is going to validate numbers only;
	e. Type of the bill. Will accept just C or D (not case sensitive);
After enter all the data it is going to return to the main menu options. Type 0 to call the options.

* Option 3: It will show all the reports options. You can type in 0 anytime to call the options.
If type in 9 it is going back to the main menu.

	Hello, Welcome to the Reports Menu
	1: Total per Year
	2: Most Popular Company
	3: Bills Order by Date
	4: Highest Bill-Credit/Debit
	5: Highest Bill-Debit
	6: Number of Bills per Year
	7: Average Spent by Period
	8: Average Time Between Bills
	9: Exit
	
	* Report 1: Sum of all the bills by year in two categories(type), Credit/Debit;
	* Report 2: Count the total bills in the file by company, independent of the type or period and shows the company name;
	* Report 3: Show all the bills in order of date (ascendent), independent of the type;
	* Report 4: Show the highest bill for each type(Credit/Debit), independent of period, customer or company;
	* Report 5: This option is just for fun and will show a message to use the option 4;
	* Report 6: Show the company with the higher number of bills and the number of bills, independent of period of time or type; 
	* Report 7: Show the average spent by period of time, independent of company or customer. ***Only consider debit type;
	* Report 8: Shows the average of time in days between the bills, independent of company, customer, year or type;
	* Report 9: Exit the Report menu and call the main menu.


* Option 4: Terms and conditions.
* Option 5: Exit the app.
