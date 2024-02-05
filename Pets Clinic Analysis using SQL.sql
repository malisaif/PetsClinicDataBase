#Q1. List the names of all pet owners along with the names of their pets.
#The query aims to retrieve information about pet owners and the names
#of their associated pets. It will retrieve data that is only in both tables
select po.ownerid, po.name as pet_owner_name, po.Surname as pet_owner_surname, pt.name as pet_name
from petowners po
inner join pets pt on pt.OwnerID = po.OwnerID; 


#Q2. List all pets and their owner names, including pets that don't have recorded owners.
#Ans.
#the Left Join is used because the primary objective is to list all pets
#including those that may not have a corresponding owner in the petowners table
#Here is why left join is relevant
select pt.name as pet_name, po.OwnerID, po.name, po.surname
from pets pt
left join petowners po on pt.ownerid = po.ownerid;


select * from pets;
select * from petowners;
select * from proceduresdetails;
select * from procedureshistory;


#Q3. Combine the information of pets and their owners, including those pets
#without owners and owners without pets.
#Ans. For this we will join it all
select pt.*,po.*
from pets pt
left join petowners po on po.OwnerID = pt.OwnerID;


#Q4. Find the names of pets along with their owners' names and the details of the
#procedures they have undergone.
select pt.petid, po.ownerid, pt.name as pet_name, po.name as owner_name, 
pcd.proceduretype, pcd.description, pch.date, pch.proceduretype
from petowners po
inner join pets pt on pt.ownerid = po.ownerid
inner join procedureshistory pch on pt.petid = pch.petid
inner join proceduresdetails pcd on pch.proceduresubcode = pcd.proceduresubcode;


#Q5. List all pet owners and the number of dogs they own.
select po.ownerid, po.name as owner_name, count(pt.petid) as count_of_dogs
from petowners po
left join pets pt on po.OwnerID = pt.OwnerID
where pt.kind = "Dog"
group by po.ownerid, po.name;


#Q6. Identify pets that have not had any procedures.
select pt.petid, pt.name as pet_name
from pets pt
left join procedureshistory pch on pt.petid = pch.petid
where pch.petid is null;


#Q7. Find the name of the oldest pet.
select pt.name, pt.petid, pt.kind, max(pt.age)
from pets pt;
#Method 1
 select petid, name, age 
 from pets
 order by age desc
 limit 3;
 
 #Method 2:
 select name as oldest_pet_name
 from pets
 where Age = (
	Select max(Age)
    From pets
);

#Method 3:
select petid, name, age
from pets
where age = (select MAX(age) from pets);


#Q8. List all pets who had procedures that cost more than the average cost of all
#procedures.
#Ans.
Select pt.petid, pt.name as pet_name, pcd.price,
(Select round(AVG(price), 0) From proceduresdetails) as avg_cost
from pets pt
left join procedureshistory pch on pt.PetID = pch.PetID
left join proceduresdetails pcd on pch.ProcedureSubCode = pcd.ProcedureSubCode
where pcd.Price > (Select round(AVG(price),0) as avg_cost from proceduresdetails);

#Q9. Find the details of procedures performed on 'Cuddles'.
select pt.petid, pt.name, pch.date, pch.proceduretype, pcd.description, pcd.price
from proceduresdetails pcd
join procedureshistory pch on pcd.ProcedureSubCode = pch.ProcedureSubCode
join pets pt on pch.PetID = pt.PetID
where name = "cuddles";

#Q10.Create a list of pet owners along with the total cost they have spent on
#procedures and display only those who have spent above the average spending.
select ownerid, name as owner_name, total_spent, round(avg_spending, 0) as avg_spent
from
	(select po.ownerid, po.name, sum(pcd.price) as total_Spent, avg(sum(pcd.price)) over () as avg_spending
    from petowners po
    left join pets pt on po.OwnerID = pt.OwnerID
    left join procedureshistory pch on pt.PetID = pch.PetID
    left join proceduresdetails pcd on pch.ProcedureSubCode = pcd.ProcedureSubCode
    group by po.OwnerID, po.Name) as spending
where total_spent>avg_spending;

#Q11.List the pets who have undergone a procedure called 'VACCINATIONS'.
select pt.petid, pt.name, pch.proceduretype
from pets pt
join procedureshistory pch on pch.PetID = pt.PetID
where ProcedureType = "Vaccinations";

#12.Find the owners of pets who have had a procedure called 'EMERGENCY'.
select po.OwnerID, po.name as owner_name, po.surname as owner_surname, pt.petid, pt.name as pet_name, pch.proceduretype
from pets pt
join petowners po on pt.OwnerID = po.OwnerID
join procedureshistory pch on pt.PetID = pch.PetID
where ProcedureType = "EMERGENCY";

#Q13.Calculate the total cost spent by each pet owner on procedures.
select distinct(po.ownerid) as owner_id, po.name, po.surname, sum(pcd.price) as total_spent
from petowners po
	left join pets pt on pt.OwnerID = po.OwnerID
    left join procedureshistory pch on pt.PetID = pch.PetID
    left join proceduresdetails pcd on pch.ProcedureSubCode = pcd.ProcedureSubCode
group by owner_id, po.name, po.surname;

#Q14. Count the number of pets of each kind
select kind, count(kind) as number_of_kind
from pets
group by kind;

#Q15.Group pets by their kind and gender and count the number of pets in each group.
select kind, gender, count(PetID)
from pets
group by Kind, Gender;

#Q16.Show the average age of pets for each kind, but only for kinds that have more
#than 5 pets.
select kind, round(avg(age), 1) as avg_age
from pets
group by kind
having count(kind)>5;

#Q17.Find the types of procedures that have an average cost greater than $50.
select ProcedureType, round(avg(Price), 1) as avg_price
from proceduresdetails
group by ProcedureType
having avg_price > 50;

#Q18.Classify pets as 'Young', 'Adult', or 'Senior' based on their age. Age less then
#3 Young, Age between 3and 8 Adult, else Senior.
select petid, kind, age,
case
	when age < 3 then "Young"
    when age > 3 and age < 8 then "Adult"
    else "Senior"
    end as Age_Group
from pets;

#Q19.Calculate the total spending of each pet owner on procedures, labeling them
#as 'Low Spender' for spending under $100, 'Moderate Spender' for spending
#between $100 and $500, and 'High Spender' for spending over $500.
select distinct(po.ownerid) as owner_id, po.name, po.surname, sum(pcd.price) as total_spent,
case
	when sum(pcd.price) < 100 then "Low Spender"
    when sum(pcd.price) > 100 and sum(pcd.price) < 500 then "Moderate Spender"
    when sum(pcd.price) > 500 then "High Spender"
    when sum(pcd.price) is null then "No Spending"
    end as Spent_group
from petowners po
	left join pets pt on pt.ownerid = po.ownerid
    left join procedureshistory pch on pt.petid = pch.petid
    left join proceduresdetails pcd on pch.proceduresubcode = pcd.proceduresubcode
group by owner_id, po.name, po.surname;

#Q20.Show the gender of pets with a custom label ('Boy' for male, 'Girl' for female).
select petid, name, gender,
case
	when gender = 'Male' then 'Boy'
    when gender = 'Female' then 'Girl' 
	end as Gender_group
from pets;
#Q21.For each pet, display the pet's name, the number of procedures they've had,
#and a status label: 'Regular' for pets with 1 to 3 procedures, 'Frequent' for 4 to
#7 procedures, and 'Super User' for more than 7 procedures.
select pt.petid, pt.name, count(pch.proceduretype) as number_of_procedures,
case
	when count(pch.proceduretype) <= 3 then "Regular"
    when count(pch.proceduretype) between 4 and 7 then "Frequent"
    when count(pch.proceduretype) > 7 then "Super User"
    when count(pch.proceduretype) is null then "Non User"
    end as User_Frequency
from pets pt
left join procedureshistory pch on pt.PetID = pch.PetID
group by pt.name, pt.PetID;

#Q22.Rank pets by age within each kind.
select petid, age, kind,
rank () over (partition by kind order by age desc) as rank_age
from pets pt;

#Q23.Assign a dense rank to pets based on their age, regardless of kind.
select petid, age,
dense_rank () over (order by age desc) as rank_age
from pets;

#Q24.For each pet, show the name of the next and previous pet in alphabetical order.
select petid, name,
lead (name, 1) over (order by name) as next_name,
lag (name,1) over (order by name) as previous_name
from pets;

#Q25.Show the average age of pets, partitioned by their kind.
select petid, kind, round(avg(age) over (partition by kind), 1) as avg_age
from pets;

#Q26.Create a CTE that lists all pets, then select pets older than 5 years from the CTE. 
with pets_cte as (
	select * from pets
    )
    
select * from pets_cte
where age>5;