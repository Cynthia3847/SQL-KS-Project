/*      Analyzing Kickstarter Projects


This project is to help the product team who is considering launching a 
campaign on Kickstarter to test the viability of some offerings,
understand what might influence the success of the campaign. 
Specifically, this will be done by using certai queries to ascertain;
1. What types of projects are most likely to be successful?
2. Which projects fail? 

-- The database consists of one table, ks-projects.
---Here are the definitions of the columns in this data:

ID: Kickstarter project ID
name: Name of project
category: Category of project
main_category: Main category of project
goal: Fundraising goal
pledged: Amount pledged
state: State of project (successful, canceled, etc.)
backers: Number of project backers*/


-- Retrieving Column Data Types
-- List the names and data types for each table in the database.

DESCRIBE ksprojects;



--  Selection of Rows and Columns needed for the analysis

SELECT main_category, goal, backers, pledged
FROM ksprojects
LIMIT 10;


/*Filtering by Category

Earlier, we selected the relevant columns. 
Now, we'll filter the data to include only those in certain categories.

1. Which of the projects weren't successful?*/

SELECT main_category, backers, pledged, goal
  FROM ksprojects
 WHERE state IN ('failed', 'canceled', 'suspended')
 ;


-- Filtering by Quantity of certain size to eliminate small irrelevant projects.


SELECT main_category, backers, pledged, goal
  FROM ksprojects
 WHERE state IN ('failed', 'canceled', 'suspended')
   AND backers >= 100 AND pledged >= 20000;
 
 
/*
A calculated field called pct_pledged, which divides pledged by goal. Sort this field in descending order. (Add pct_pledged to the SELECT clause, too.)
Now, modify your query so that only projects in a failed state are returned.*/


SELECT main_category, backers, pledged, goal, pledged / goal AS pct_pledged
  FROM ksprojects
 WHERE state IN ('failed')
   AND backers >= 100 AND pledged >= 20000
 ORDER BY main_category, pct_pledged DESC
 ;
   
   
/*Create a field funding_status that applies the following logic based on the percentage of amount pledged to campaign goal:

If the percentage pledged is greater than or equal to 1, then the project is "Fully funded."
If the percentage pledged is between 75% and 100%, then the project is "Nearly funded."
If the percentage pledged is less than 75%, then the project is "Not nearly funded."
Write either a line or block comment with your observations about the funding status of the sample output.
For example, are these failed projects failing because they don't have any backers or funding?*/

SELECT main_category, backers, pledged, goal, 
       pledged/goal AS pct_pledged,
  CASE
  WHEN pledged/goal  >= 1 THEN "Fully funded"
  WHEN pledged/goal BETWEEN .75 AND 1 THEN "Nearly funded"
  ELSE "Not nearly funded"
 END AS funding_status 
 FROM ksprojects
 WHERE state IN ('failed') AND backers >= 100 AND pledged >= 20000
 ORDER BY main_category, pct_pledged DESC
 ;
 
 