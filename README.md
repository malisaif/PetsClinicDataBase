# PetsClinicDataBase

## Overview
This repository focuses on analyzing data of a pet clinic using SQL. 

## About the Data
There are 4 data sets available which are interlinked with each other through key features.
### 1. Pet Owners
The pet owners table contains information about the pet owners, such as owner ID, name, contact details, and other relevant information.
### 2. Pets
The pets table includes details about individual pets, including pet ID, owner ID, pet name, breed, and age.
### 3. Procedure Details
The procedure_details table provides information about various medical procedures available for pets, including procedure ID, description, and cost.
### 4. Procedure History
The procedure_history table has the historic records of the procedures performed on pets, capturing details such as procedure ID, pet ID, procedure date, and any additional relevant information.

## How we Solve it 
Our solution involves leveraging SQL queries to extract meaningful information from the dataset. We address various questions related to pet health, ownership patterns, and medical expenses. By combining data from different tables, we aim to provide a holistic view of pet health and help pet owners make informed decisions.

## Key SQL Features Used
SELECT: Choose specific data from tables.
JOIN: Combine data from different tables.
GROUP BY: Group and summarize data.
Aggregates (AVG, SUM, COUNT): Calculate values based on grouped data.
Window Functions: Analyze data within specific ranges.
CTE with WITH Clause: Create temporary result sets for complex queries.
CASE Statement: Apply conditional logic to derive customized results.
LEAD and LAG: Access data from nearby rows for comparative analysis.
Subqueries: Utilize nested queries for advanced data retrieval.
ROUND: Adjust numerical values for precision.

## Technologies Used
MySQL

## Getting Started
Read and understand the Task. Clone the repository to your local machine. Set up your SQL environment. Run queries to extract insights from the provided dataset.

## Contributions
We welcome contributions to enhance the functionality and usability of Pet Clinic Analysis. Feel free to submit issues, propose new features, or make pull requests.
