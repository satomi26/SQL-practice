

 No.1.11
SELECT Name, Price, Manufacturer
FROM Products;

no.1.12
Select avg(Price) ,Manufacturer
From Products
GROUP By Manufacturer;

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT avg(Price), m.Name
FROM Products p
JOIN Manufacturer m
ON m.Code = p.Manufacturer
GROUP By Manufacturer;

240.0	Sony
150.0	Creative Labs
168.0	Hewlett-Packard
150.0	Iomega
240.0	Fujitsu
62.5	Winchester

-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
SELECT AVG(Price),m.Name
FROM Products p
JOIN Manufacturer m
ON m.Code = p.Manufacturer
GROUP BY p.Manufacturer;

-- 1.15 Select the name and price of the cheapest product.
SELECT Name, MIN(Price) as "chepeast price"
FROM Products;

-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
SELECT m.Name as "Manufacturer Name", p.Name, MAX(Price) as "maximum price of Manufacturer"
FROM Products p
JOIN Manufacturer m
ON m.Code = p.Manufacturer
GROUP BY p.Manufacturer
;

-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
INSERT INTO Products
VALUES ("11","Loudspeaker", "70", "2");

-- 1.18 Update the name of product 8 to "Laser Printer".
UPDATE Products
SET Name = "Laser Printer"
WHERE Code = 8;

-- 1.19 Apply a 10% discount to all products.

I made mistake; UPDATE Products SET Price = Price*0.9; It gave me, updated values in price column in original table.
So I fixed it; UPDATE Products SET Price = Price / 0.9 
 
 ALTER TABLE Products 
ADD COLUMN "10%_Discount"[FLOAT]

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.

INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('123234877','Michael','Rogers',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('152934485','Anand','Manikutty',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('222364883','Carol','Smith',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('326587417','Joe','Stevens',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332154719','Mary-Anne','Foster',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332569843','George','ODonnell',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('546523478','John','Doe',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('631231482','David','Smith',77);

INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('654873219','Zacary','Efron',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('745685214','Eric','Goldsmith',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657245','Elizabeth','Doe',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657246','Kumar','Swamy',14);


-- 2.1 Select the last name of all employees.
SELECT LastName
FROM Employees;

-- 2.2 Select the last name of all employees, without duplicates.
SELECT DISTINCT LastName
FROM Employees;

-- 2.3 Select all the data of employees whose last name is "Smith".
SELECT *
FROM Employees
WHERE LastName = "Smith";

-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
SELECT *
FROM Employees
WHERE LastName = "Smith" OR LastName = "Doe";


-- 2.5 Select all the data of employees that work in department 14.

SELECT *
FROM Employees
WHERE Department = 14;

-- 2.6 Select all the data of employees that work in department 37 or department 77.

SELECT *
FROM Employees
WHERE Department = 37 OR Department = 77;

-- 2.7 Select all the data of employees whose last name begins with an "S".

SELECT *
FROM Employees
WHERE LastName LIKE "S%";

-- 2.8 Select the sum of all the departments' budgets.

SELECT SUM(Budget)
FROM Departments;

-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).

SELECT Department,COUNT(Name) as "Number of employees"
FROM Employees
GROUP BY Department;

-- 2.10 Select all the data of employees, including each employee's department's data.

SELECT SSN, e.Name, LastName, Department, d.Name, Budget
FROM Employees e
JOIN Departments d
ON e.Department = d.Code;

-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.

SELECT e.Name, LastName, d.Name AS "Department_Name", Budget
FROM Employees e
LEFT JOIN Departments d
ON e.Department = d.Code;


-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.

SELECT e.Name, LastName, d.Name AS "Department_Name", Budget
FROM Employees e
LEFT JOIN Departments d
ON e.Department = d.Code
WHERE Budget > 60000;

-- 2.13 Select the departments with a budget larger than the average budget of all the departments.

SELECT Name, Budget 
FROM Departments
WHERE  Budget > (
select avg(budget) from departments
);

SELECT AVG(Budget)
FROM Departments
;
-- 2.14 Select the names of departments with more than two employees.

SELECT d.Name
FROM Departments d
JOIN Employees e
ON e.Department = d.Code

GROUP BY d.Department
WHERE Count(DISTINCT Department)>2;
--WHERE count(Department) > 2;


-- 2.15 Select the name and last name of employees working for the two departments with lowest budget.

SELECT e.Name, e.LastName, d.Budget
FROM Employees e
JOIN Departments d
ON e.Department = d.Code
WHERE Budget = MIN(Budget);
--didn't work

-- subquery which I want to put in main query
SELECT d.Code, Budget FROM Departments d ORDER BY Budget ASC LIMIT 2;

SELECT e.Name, LastName, Department
FROM Employees e
WHERE Department IN (SELECT d.Code FROM Departments d ORDER BY Budget ASC LIMIT 2);

-- subquery in select statement mit budget, so that i have also one column additionally with budget.
SELECT e.Name, LastName, Department,(
SELECT Budget  From Departments WHERE Departments.Code= Employees.Department AS Budget)
FROM Employees e
WHERE Department IN (SELECT d.Code FROM Departments d ORDER BY Budget ASC LIMIT 2);

SELECT d.Code FROM Departments d ORDER BY Budget ASC LIMIT 2

-- with CTE 
WITH lowest_two_Budget AS (
SELECT d.Code, Budget FROM Departments d ORDER BY Budget ASC LIMIT 2)

SELECT e.Name, LastName, l.Budget
From Employees e
JOIN lowest_two_Budget as l
ON e.Department = l.Code;


-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
INSERT INTO Departments(Code,Name,Budget) VALUES(11, "Quality Assurance", 40000);

-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('847219811','Mary','Moore',11);

-- 2.17 Reduce the budget of all departments by 10%.
ALTER TABLE Departments 
ADD COLUMN new_Budget
GENERATED ALWAYS AS(Budget*0.9);

-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).
UPDATE Employees
SET Department = 14
WHERE Department = 77;

-- 2.19 Delete from the table all employees in the IT department (code 14).
DELETE FROM Employees
WHERE Department = 14

-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.

DELETE FROM Employees
WHERE new_Budget >= 60000;

-- 2.21 Delete from the table all employees.

DELET FROM EMPLOYEES

Day_3

 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(1,'Chicago',3);
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(2,'Chicago',4);
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(3,'New York',7);
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(4,'Los Angeles',2);
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(5,'San Francisco',8);
 
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('0MN7','Rocks',180,3);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4H8P','Rocks',250,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4RT3','Scissors',190,4);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('7G3H','Rocks',200,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8JN6','Papers',75,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8Y6U','Papers',50,3);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('9J6F','Papers',175,2);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('LL08','Rocks',140,4);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P0H6','Scissors',125,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P2T6','Scissors',150,2);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('TU55','Papers',90,5);
 
 Questions
--3.1 Select all warehouses.
SELECT *
FROM Warehouses;

--3.2 Select all boxes with a value larger than $150.
SELECT *
FROM Boxes
WHERE Value > 150;

--3.3 Select all distinct contents in all the boxes.
SELECT DISTINCT Contents
FROM Boxes;

--3.4 Select the average value of all the boxes.
SELECT round(AVG(Value),2) as AvgValue
FROM Boxes;

SELECT Avg(Value) as "average value"
From Boxes; 

--3.5 Select the warehouse code and the average value of the boxes in each warehouse.
-- average value of the boxes in each warehouse
Select Warehouse, avg(Value)
FROM Boxes
group by Warehouse;

--3.6 Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
Select Warehouse, avg(Value)
FROM Boxes
WHERE Value > 150
group by Warehouse
;

SELECT *
FROM Boxes
WHERE Value > (
SELECT AVG(Value)
FROM Boxes
GROUP BY Warehouse);

--3.7 Select the code of each box, along with the name of the city the box is located in.
SELECT b.Code, Location
FROM Boxes b
JOIN Warehouses w
ON b.Warehouse = w.Code
ORDER BY Location;


--3.8 Select the warehouse codes, along with the number of boxes in each warehouse. 
SELECT w.Code, b.Value
FROM Warehouses w
JOIN Boxes b
ON b.Warehouse = w.Code
Order By b.Value;

SELECT Warehouse, COUNT(*) AS number_of_boxes
FROM Boxes 
GROUP BY Warehouse;

--3.9 Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).
select count(*) from Boxes where Warehouse = 2;

select code FROM Warehouses w where Capacity <= (SELECT count(*) from Boxes b WHERE b.Warehouse = w.Code)

(SELECT Code
   	FROM Warehouses
   	WHERE Capacity <
   		(SELECT COUNT(*)
       	FROM Boxes
       	WHERE Warehouse = Warehouses.Code
)
;

SELECT B.Warehouse, W.Capacity, COUNT(B.Code) AS number_of_boxes
FROM Warehouses AS W
JOIN Boxes AS B
ON W.Code=B.Warehouse
GROUP BY W.Code
HAVING W.Capacity < number_of_boxes
;


--3.10 Select the codes of all the boxes located in Chicago.
SELECT b.Code, w.Location
FROM Boxes b
JOIN Warehouses w
ON b.Warehouse = w.Code
WHERE Location = "Chicago";

--solution
SELECT B.Code, W.Location 
FROM Warehouses AS W
JOIN Boxes AS B
ON W.Code=B.Warehouse
WHERE W.Location = 'Chicago';


--3.11 Create a new warehouse in New York with a capacity for 3 boxes.
INSERT INTO Warehouses(Code, Location, Capacity) VALUES(6, "New York", 3);

--3.12 Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
INSERT INTO Boxes(Code, Contents, Value, Warehouse) VALUES("H5RT", "Papers", 200,2);

--3.13 Reduce the value of all boxes by 15%.
ALTER TABLE Boxes
ADD COLUMN reduced_value
GENERATED ALWAYS AS(Value*0.85);

--3.14 Remove all boxes with a value lower than $100.
DELETE FROM Boxes
WHERE Value < 100;

-- 3.15 Remove all boxes from saturated warehouses.
DELETE FROM Boxes
WHERE (
);

FROM Warehouses AS W
JOIN Boxes AS B
ON W.Code=B.Warehouse
GROUP BY W.Code
HAVING W.Capacity < number_of_boxes

INSERT INTO Movies(Code,Title,Rating) VALUES(1,'Citizen Kane','PG');
INSERT INTO Movies(Code,Title,Rating) VALUES(2,'Singin'' in the Rain','G');
INSERT INTO Movies(Code,Title,Rating) VALUES(3,'The Wizard of Oz','G');
INSERT INTO Movies(Code,Title,Rating) VALUES(4,'The Quiet Man',NULL);
INSERT INTO Movies(Code,Title,Rating) VALUES(5,'North by Northwest',NULL);
INSERT INTO Movies(Code,Title,Rating) VALUES(6,'The Last Tango in Paris','NC-17');
INSERT INTO Movies(Code,Title,Rating) VALUES(7,'Some Like it Hot','PG-13');
INSERT INTO Movies(Code,Title,Rating) VALUES(8,'A Night at the Opera',NULL);
 
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(1,'Odeon',5);
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(2,'Imperial',1);
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(3,'Majestic',NULL);
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(4,'Royale',6);
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(5,'Paraiso',3);
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(6,'Nickelodeon',NULL);

--Questions
-- 4.1 Select the title of all movies.

SELECT Title
FROM Movies;

-- 4.2 Show all the distinct ratings in the database.

SELECT DISTINCT Rating
FROM Movies;

-- 4.3 Show all unrated movies.

SELECT Title,  Rating
FROM Movies
WHERE Rating IS NULL;

-- 4.4 Select all movie theaters that are not currently showing a movie.

SELECT Name
FROM MovieTheaters
WHERE Movie IS NULL;

-- 4.5 Select all data from all movie theaters and, additionally, the data from the movie that is being shown in the theater (if one is being shown).

SELECT mt.Code, mt.Name, mt.Movie, mo.Title
FROM MovieTheaters mt

lEFT JOIN Movies mo
ON mt.Movie = mo.Code;
--WHERE Movie IS NOT NULL; 

-- 4.6 Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.


SELECT mo.Code, mo.Title, mo.Rating, Name
FROM Movies mo
LEFT JOIN MovieTheaters mt
ON mt.Movie = mo.Code;

-- 4.7 Show the titles of movies not currently being shown in any theaters.

SELECT Movies.Code, Title
FROM Movies
WHERE not EXISTS( SELECT Movie FROM MovieTheaters WHERE MovieTheaters.Movie = Movies.Code);

-- 4.8 Add the unrated movie "One, Two, Three".
INSERT INTO Movies(Code,Title,Rating) VALUES(9,'One, Two, Three',NULL);

-- 4.9 Set the rating of all unrated movies to "G".

UPDATE Movies SET Rating = "G" Where Rating IS NULL;

-- 4.10 Remove movie theaters projecting movies rated "NC-17".

DELETE FROM MovieTheaters
WHERE EXISTS(SELECT * FROM Movies WHERE Rating = "NC-17"); 

DELETE FROM MovieTheaters
WHERE EXISTS(SELECT * FROM Movies WHERE MovieTheaters.Movie = Movies.Code)



INSERT INTO Providers(Code, Name) VALUES('HAL','Clarke Enterprises');
INSERT INTO Providers(Code, Name) VALUES('RBT','Susan Calvin Corp.');
INSERT INTO Providers(Code, Name) VALUES('TNBC','Skellington Supplies');

DROP TABLE Providers;

CREATE TABLE Providers (
 Code VARCHAR(40) NOT NULL,  
 Name TEXT NOT NULL,
PRIMARY KEY (Code) 
 );


INSERT INTO Pieces(Code, Name) VALUES(1,'Sprocket');
INSERT INTO Pieces(Code, Name) VALUES(2,'Screw');
INSERT INTO Pieces(Code, Name) VALUES(3,'Nut');
INSERT INTO Pieces(Code, Name) VALUES(4,'Bolt');

INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'HAL',10);
INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'RBT',15);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'HAL',20);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'RBT',15);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'TNBC',14);
INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'RBT',50);
INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'TNBC',45);
INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'HAL',5);
INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'RBT',7);

-- 5.1 Select the name of all the pieces. 

SELECT Name
FROM Pieces;

-- 5.2  Select all the providers' data. 

SELECT *
FROM Providers;

-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).

SELECT Piece, AVG(Price) as "Average price of each piece"
FROM Provides
GROUP BY Piece;

-- 5.4  Obtain the names of all providers who supply piece 1.

SELECT *
FROM Providers;
WHERE Providers.Code EXISTS (SELECT Provider FROM Provides WHERE Providers.Code = Provides.Provider AND Piece = 1);


-- with CTE
WITH piece_one AS (
SELECT Piece, Provider FROM Provides Where Piece = 1) 
Select Name
From Providers
JOIN piece_one
ON Piece_one.Provider = Providers.Code;


-- 5.5 Select the name of pieces provided by provider with code "HAL".
SELECT Name
FROM Pieces
JOIN Provides
ON Pieces.Code = Provides.Piece
WHERE Provider = "HAL";

-- 5.6 For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price (note that there could be two providers who supply the same piece at the most expensive price).

SELECT MAX(Price), Provider, Price
FROM Provides
GROUP BY Piece;

-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.



-- 5.8 Increase all prices by one cent.



ALTER TABLE Provides 
ADD COLUMN "increased_price";


CREATE TABLE Scientists (
  SSN int,
  Name Char(30) not null,
  Primary Key (SSN)
);

CREATE TABLE Projects (
  Code Char(4),
  Name Char(50) not null,
  Hours int,
  Primary Key (Code)
);
	
CREATE TABLE AssignedTo (
  Scientist int not null,
  Project char(4) not null,
  Primary Key (Scientist, Project)
);

INSERT INTO Scientists(SSN,Name) 
VALUES(123234877,'Michael Rogers'),
(152934485,'Anand Manikutty'),
(222364883, 'Carol Smith'),
(326587417,'Joe Stevens'),
(332154719,'Mary-Anne Foster'),	
(332569843,'George ODonnell'),
(546523478,'John Doe'),
(631231482,'David Smith'),
(654873219,'Zacary Efron'),
(745685214,'Eric Goldsmith'),
(845657245,'Elizabeth Doe'),
(845657246,'Kumar Swamy');

INSERT INTO Projects ( Code,Name,Hours)
VALUES ('AeH1','Winds: Studying Bernoullis Principle', 156),
('AeH2','Aerodynamics and Bridge Design',189),
('AeH3','Aerodynamics and Gas Mileage', 256),
('AeH4','Aerodynamics and Ice Hockey', 789),
('AeH5','Aerodynamics of a Football', 98),
('AeH6','Aerodynamics of Air Hockey',89),
('Ast1','A Matter of Time',112),
('Ast2','A Puzzling Parallax', 299),
('Ast3','Build Your Own Telescope', 6546),
('Bte1','Juicy: Extracting Apple Juice with Pectinase', 321),
('Bte2','A Magnetic Primer Designer', 9684),
('Bte3','Bacterial Transformation Efficiency', 321),
('Che1','A Silver-Cleaning Battery', 545),
('Che2','A Soluble Separation Solution', 778);

INSERT INTO AssignedTo ( Scientist, Project)
VALUES (123234877,'AeH1'),
(152934485,'AeH3'),
(222364883,'Ast3'),	   
(326587417,'Ast3'),
(332154719,'Bte1'),
(546523478,'Che1'),
(631231482,'Ast3'),
(654873219,'Che1'),
(745685214,'AeH3'),
(845657245,'Ast1'),
(845657246,'Ast2'),
(332569843,'AeH4');

-- 6.1 List all the scientists' names, their projects' names, 

SELECT s.Name, p.Name
FROM Scientists s
JOIN AssignedTo a
ON s.SSN = a.Scientist
JOIN Projects p
ON  a.Project = p.Code;


    -- and the hours worked by that scientist on each project, 
SELECT s.Name, p.Name, p.Hours
FROM Scientists s
JOIN AssignedTo a
ON s.SSN = a.Scientist
JOIN Projects p
ON  a.Project = p.Code;

    -- in alphabetical order of project name, then scientist name.
SELECT  p.Name as "Project name", s.Name as "scientist's Name", p.Hours
FROM Projects p
JOIN AssignedTo a
ON  p.Code = a.Project
JOIN Scientists s
ON  s.SSN = a.Scientist

ORDER BY p.Name ;

-- 6.2 Select the project names which are not assigned yet
SELECT p.Name as "not yet assigned Project"
FROM Projects p
right JOIN AssignedTo a
ON P.Code = a.Project
WHERE a.Project 

SELECT name from Projects
Where Not EXISTS(select * from AssignedTo where AssignedTo.project = Projects.Code);

--Tast 7

CREATE TABLE Planet (
  PlanetID INTEGER,
  Name VARCHAR(255) NOT NULL,
  Coordinates REAL NOT NULL,
  PRIMARY KEY (PlanetID)
); 

CREATE TABLE Shipment (
  ShipmentID INTEGER,
  Date DATE,
  Manager INTEGER NOT NULL,
  Planet INTEGER NOT NULL,
  PRIMARY KEY (ShipmentID)
);

CREATE TABLE Has_Clearance (
  Employee INTEGER NOT NULL,
  Planet INTEGER NOT NULL,
  Level INTEGER NOT NULL,
  PRIMARY KEY(Employee, Planet)
); 

CREATE TABLE Client (
  AccountNumber INTEGER,
  Name VARCHAR(255) NOT NULL,
  PRIMARY KEY (AccountNumber)
);
  
CREATE TABLE Package (
  Shipment INTEGER NOT NULL,
  PackageNumber INTEGER NOT NULL,
  Contents VARCHAR(255) NOT NULL,
  Weight REAL NOT NULL,
  Sender INTEGER NOT NULL,
  Recipient INTEGER NOT NULL,
  PRIMARY KEY(Shipment, PackageNumber)
  );
  
  INSERT INTO Client VALUES(1, 'Zapp Brannigan');
INSERT INTO Client VALUES(2, "Al Gore's Head");
INSERT INTO Client VALUES(3, 'Barbados Slim');
INSERT INTO Client VALUES(4, 'Ogden Wernstrom');
INSERT INTO Client VALUES(5, 'Leo Wong');
INSERT INTO Client VALUES(6, 'Lrrr');
INSERT INTO Client VALUES(7, 'John Zoidberg');
INSERT INTO Client VALUES(8, 'John Zoidfarb');
INSERT INTO Client VALUES(9, 'Morbo');
INSERT INTO Client VALUES(10, 'Judge John Whitey');
INSERT INTO Client VALUES(11, 'Calculon');
INSERT INTO Employee VALUES(1, 'Phillip J. Fry', 'Delivery boy', 7500.0, 'Not to be confused with the Philip J. Fry from Hovering Squid World 97a');
INSERT INTO Employee VALUES(2, 'Turanga Leela', 'Captain', 10000.0, NULL);
INSERT INTO Employee VALUES(3, 'Bender Bending Rodriguez', 'Robot', 7500.0, NULL);
INSERT INTO Employee VALUES(4, 'Hubert J. Farnsworth', 'CEO', 20000.0, NULL);
INSERT INTO Employee VALUES(5, 'John A. Zoidberg', 'Physician', 25.0, NULL);
INSERT INTO Employee VALUES(6, 'Amy Wong', 'Intern', 5000.0, NULL);
INSERT INTO Employee VALUES(7, 'Hermes Conrad', 'Bureaucrat', 10000.0, NULL);
INSERT INTO Employee VALUES(8, 'Scruffy Scruffington', 'Janitor', 5000.0, NULL);
INSERT INTO Planet VALUES(1, 'Omicron Persei 8', 89475345.3545);
INSERT INTO Planet VALUES(2, 'Decapod X', 65498463216.3466);
INSERT INTO Planet VALUES(3, 'Mars', 32435021.65468);
INSERT INTO Planet VALUES(4, 'Omega III', 98432121.5464);
INSERT INTO Planet VALUES(5, 'Tarantulon VI', 849842198.354654);
INSERT INTO Planet VALUES(6, 'Cannibalon', 654321987.21654);
INSERT INTO Planet VALUES(7, 'DogDoo VII', 65498721354.688);
INSERT INTO Planet VALUES(8, 'Nintenduu 64', 6543219894.1654);
INSERT INTO Planet VALUES(9, 'Amazonia', 65432135979.6547);
INSERT INTO Has_Clearance VALUES(1, 1, 2);
INSERT INTO Has_Clearance VALUES(1, 2, 3);
INSERT INTO Has_Clearance VALUES(2, 3, 2);
INSERT INTO Has_Clearance VALUES(2, 4, 4);
INSERT INTO Has_Clearance VALUES(3, 5, 2);
INSERT INTO Has_Clearance VALUES(3, 6, 4);
INSERT INTO Has_Clearance VALUES(4, 7, 1);
INSERT INTO Shipment VALUES(1, '3004/05/11', 1, 1);
INSERT INTO Shipment VALUES(2, '3004/05/11', 1, 2);
INSERT INTO Shipment VALUES(3, NULL, 2, 3);
INSERT INTO Shipment VALUES(4, NULL, 2, 4);
INSERT INTO Shipment VALUES(5, NULL, 7, 5);
INSERT INTO Package VALUES(1, 1, 'Undeclared', 1.5, 1, 2);
INSERT INTO Package VALUES(2, 1, 'Undeclared', 10.0, 2, 3);
INSERT INTO Package VALUES(2, 2, 'A bucket of krill', 2.0, 8, 7);
INSERT INTO Package VALUES(3, 1, 'Undeclared', 15.0, 3, 4);
INSERT INTO Package VALUES(3, 2, 'Undeclared', 3.0, 5, 1);
INSERT INTO Package VALUES(3, 3, 'Undeclared', 7.0, 2, 3);
INSERT INTO Package VALUES(4, 1, 'Undeclared', 5.0, 4, 5);
INSERT INTO Package VALUES(4, 2, 'Undeclared', 27.0, 1, 2);
INSERT INTO Package VALUES(5, 1, 'Undeclared', 100.0, 5, 1);

-- 7.1 Who received a 1.5kg package?
SELECT Name 
FROM Client c
JOIN Package p
ON c.AccountNumber=P.Recipient
WHERE Recipient = 2 AND Weight = 1.5;

    -- The result is "Al Gore's Head".
	
-- 7.2 What is the total weight of all the packages that he sent?
SELECT SUM(Weight) as "total_weight"
FROM Package 
WHERE Sender = 2;







FOREIGN KEY (Patient ) REFERENCES Patient (SSN )

CREATE TABLE Physician (
EmployeeID INTEGER NOT NULL,
Name TEXT NOT NULL,
Position TEXT NOT NULL,
SSN INTEGER NOT NULL,
PRIMARY KEY (EmployeeID)
);

CREATE TABLE Department (
DepartmentID INTEGER NOT NULL,
Name TEXT NOT NULL,
Head INTEGER NOT NULL,
PRIMARY KEY (DepartmentID)
FOREIGN KEY (Head) REFERENCES Physician(EmployeeID)

);
CREATE TABLE Affiliated_With (
Physician INTEGER NOT NULL,
Department INTEGER NOT NULL,
PrimaryAffiliation BOOLEAN NOT NULL,
PRIMARY KEY(Physician, Department)
FOREIGN KEY (Physician) REFERENCES Physician(EmployeeID)
FOREIGN KEY (Department) REFERENCES Department(DepartmentID)
);
--DROP TABLE Affiliated_With;
PRAGMA FOREIGN_KEY_list("Affiliated_With");

CREATE TABLE Procedures (
Code INTEGER NOT NULL,
Name TEXT NOT NULL,
Cost REAL NOT NULL,
PRIMARY KEY (Code)
);

DROP TABLE Trained_In;
CREATE TABLE Trained_In (
Physician INTEGER NOT NULL,
Treatment INTEGER NOT NULL,
CertificationDate DATETIME NOT NULL,
CertificationExpires DATETIME NOT NULL,
PRIMARY KEY(Physician, Treatment)
FOREIGN KEY (Physician) REFERENCES Physician(EmployeeID)
FOREIGN KEY (Treatment) REFERENCES Procedures(Code)
);

DROP TABLE Patient;
CREATE TABLE Patient (
SSN INTEGER NOT NULL,
Name TEXT NOT NULL,
Address TEXT NOT NULL,
Phone TEXT NOT NULL,
InsuranceID INTEGER NOT NULL,
PCP INTEGER NOT NULL,
PRIMARY KEY (SSN)
FOREIGN KEY (PCP) REFERENCES Physician(EmployeeID)
);

CREATE TABLE Nurse (
EmployeeID INTEGER NOT NULL,
Name TEXT NOT NULL,
Position TEXT NOT NULL,
Registered BOOLEAN NOT NULL,
SSN INTEGER NOT NULL,
PRIMARY KEY (EmployeeID)
);

DROP TABLE Appointment;
CREATE TABLE Appointment (
AppointmentID INTEGER NOT NULL,
Patient INTEGER NOT NULL,
PrepNurse INTEGER,
Physician INTEGER NOT NULL,
Start DATETIME NOT NULL,
End DATETIME NOT NULL,
ExaminationRoom TEXT NOT NULL,
PRIMARY KEY (AppointmentID)
FOREIGN KEY (Patient) REFERENCES Patient(SSN)
FOREIGN KEY (PrepNurse) REFERENCES Nurse(EmployeeID)
FOREIGN KEY (Physician) REFERENCES Physician(EmployeeID)
);

CREATE TABLE Medication (
Code INTEGER NOT NULL,
Name TEXT NOT NULL,
Brand TEXT NOT NULL,
Description TEXT NOT NULL,
PRIMARY KEY(Code)
);

DROP TABLE Prescribes;
CREATE TABLE Prescribes (
Physician INTEGER NOT NULL,
patient INTEGER NOT NULL,
Medication INTEGER NOT NULL,
Date DATETIME NOT NULL,
Appointment INTEGER,
Dose TEXT NOT NULL,
PRIMARY KEY(Physician, Patient, Medication, Date)
FOREIGN KEY (Physician) REFERENCES Physician(EmployeeID)
FOREIGN KEY (Patient) REFERENCES Patient(SSN)
FOREIGN KEY (Medication) REFERENCES Medication(Code)
FOREIGN KEY (Appointment) REFERENCES Appointment(AppointmentID)
);

drop Table Block;
CREATE TABLE Block (
Floor INTEGER NOT NULL,
Code INTEGER NOT NULL,
PRIMARY KEY(Floor, Code)
); 
DROP Table Room;
CREATE TABLE Room (
Number INTEGER NOT NULL,
Type TEXT NOT NULL,
BlockFloor INTEGER NOT NULL,
BlockCode INTEGER NOT NULL,
Unavailable BOOLEAN NOT NULL,
PRIMARY KEY(Number)
CONSTRAINT fk_Room_Block_PK FOREIGN KEY(BlockFloor, BlockCode) REFERENCES Block(Floor, Code)
);



Drop Table On_Call;

CREATE TABLE On_Call (
Nurse INTEGER NOT NULL,
BlockFloor INTEGER NOT NULL,
BlockCode INTEGER NOT NULL,
Start DATETIME NOT NULL,
End DATETIME NOT NULL,
PRIMARY KEY(Nurse, BlockFloor, BlockCode, Start, End)
FOREIGN KEY (Nurse) REFERENCES Nurse(EmployeeID)
CONSTRAINT fk_Room_Block_PK FOREIGN KEY(BlockFloor, BlockCode) REFERENCES Block(Floor, Code)

);

DROP Table Stay;
CREATE TABLE Stay (
StayID INTEGER NOT NULL,
Patient INTEGER NOT NULL,
Room INTEGER NOT NULL,
Start DATETIME NOT NULL,
End DATETIME NOT NULL,
PRIMARY KEY(StayID)
FOREIGN Key (Patient) REFERENCES Patient(SSN)
FOREIGN KEY (Room) REFERENCES Room(Number)

);

DROP TABLE Undergoes;
CREATE TABLE Undergoes (
Patient INTEGER NOT NULL,
Procedure INTEGER NOT NULL,
Stay INTEGER NOT NULL,
Date DATETIME NOT NULL,
Physician INTEGER NOT NULL,
AssistingNurse INTEGER,
PRIMARY KEY(Patient, Procedure, Stay, Date)
FOREIGN KEY (Patient) REFERENCES Patient(SSN)
FOREIGN KEY (Procedure) REFERENCES Procedures(Code)
FOREIGN KEY (Stay) REFERENCES Stay(StayID)
FOREIGN KEY (Physician) REFERENCES Physician(EmployeeID)
FOREIGN KEY (AssistingNurse) REFERENCES Nurse(EmployeeID)
);


INSERT INTO Physician VALUES(1,'John Dorian','Staff Internist',111111111);
INSERT INTO Physician VALUES(2,'Elliot Reid','Attending Physician',222222222);
INSERT INTO Physician VALUES(3,'Christopher Turk','Surgical Attending Physician',333333333);
INSERT INTO Physician VALUES(4,'Percival Cox','Senior Attending Physician',444444444);
INSERT INTO Physician VALUES(5,'Bob Kelso','Head Chief of Medicine',555555555);
INSERT INTO Physician VALUES(6,'Todd Quinlan','Surgical Attending Physician',666666666);
INSERT INTO Physician VALUES(7,'John Wen','Surgical Attending Physician',777777777);
INSERT INTO Physician VALUES(8,'Keith Dudemeister','MD Resident',888888888);
INSERT INTO Physician VALUES(9,'Molly Clock','Attending Psychiatrist',999999999);

INSERT INTO Department VALUES(1,'General Medicine',4);
INSERT INTO Department VALUES(2,'Surgery',7);
INSERT INTO Department VALUES(3,'Psychiatry',9);

INSERT INTO Affiliated_With VALUES(1,1,1);
INSERT INTO Affiliated_With VALUES(2,1,1);
INSERT INTO Affiliated_With VALUES(3,1,0);
INSERT INTO Affiliated_With VALUES(3,2,1);
INSERT INTO Affiliated_With VALUES(4,1,1);
INSERT INTO Affiliated_With VALUES(5,1,1);
INSERT INTO Affiliated_With VALUES(6,2,1);
INSERT INTO Affiliated_With VALUES(7,1,0);
INSERT INTO Affiliated_With VALUES(7,2,1);
INSERT INTO Affiliated_With VALUES(8,1,1);
INSERT INTO Affiliated_With VALUES(9,3,1);

INSERT INTO Procedures VALUES(1,'Reverse Rhinopodoplasty',1500.0);
INSERT INTO Procedures VALUES(2,'Obtuse Pyloric Recombobulation',3750.0);
INSERT INTO Procedures VALUES(3,'Folded Demiophtalmectomy',4500.0);
INSERT INTO Procedures VALUES(4,'Complete Walletectomy',10000.0);
INSERT INTO Procedures VALUES(5,'Obfuscated Dermogastrotomy',4899.0);
INSERT INTO Procedures VALUES(6,'Reversible Pancreomyoplasty',5600.0);
INSERT INTO Procedures VALUES(7,'Follicular Demiectomy',25.0);

INSERT INTO Patient VALUES(100000001,'John Smith','42 Foobar Lane','555-0256',68476213,1);
INSERT INTO Patient VALUES(100000002,'Grace Ritchie','37 Snafu Drive','555-0512',36546321,2);
INSERT INTO Patient VALUES(100000003,'Random J. Patient','101 Omgbbq Street','555-1204',65465421,2);
INSERT INTO Patient VALUES(100000004,'Dennis Doe','1100 Foobaz Avenue','555-2048',68421879,3);

INSERT INTO Nurse VALUES(101,'Carla Espinosa','Head Nurse',1,111111110);
INSERT INTO Nurse VALUES(102,'Laverne Roberts','Nurse',1,222222220);
INSERT INTO Nurse VALUES(103,'Paul Flowers','Nurse',0,333333330);

INSERT INTO Appointment VALUES(13216584,100000001,101,1,'2008-04-24 10:00','2008-04-24 11:00','A');
INSERT INTO Appointment VALUES(26548913,100000002,101,2,'2008-04-24 10:00','2008-04-24 11:00','B');
INSERT INTO Appointment VALUES(36549879,100000001,102,1,'2008-04-25 10:00','2008-04-25 11:00','A');
INSERT INTO Appointment VALUES(46846589,100000004,103,4,'2008-04-25 10:00','2008-04-25 11:00','B');
INSERT INTO Appointment VALUES(59871321,100000004,NULL,4,'2008-04-26 10:00','2008-04-26 11:00','C');
INSERT INTO Appointment VALUES(69879231,100000003,103,2,'2008-04-26 11:00','2008-04-26 12:00','C');
INSERT INTO Appointment VALUES(76983231,100000001,NULL,3,'2008-04-26 12:00','2008-04-26 13:00','C');
INSERT INTO Appointment VALUES(86213939,100000004,102,9,'2008-04-27 10:00','2008-04-21 11:00','A');
INSERT INTO Appointment VALUES(93216548,100000002,101,2,'2008-04-27 10:00','2008-04-27 11:00','B');

INSERT INTO Medication VALUES(1,'Procrastin-X','X','N/A');
INSERT INTO Medication VALUES(2,'Thesisin','Foo Labs','N/A');
INSERT INTO Medication VALUES(3,'Awakin','Bar Laboratories','N/A');
INSERT INTO Medication VALUES(4,'Crescavitin','Baz Industries','N/A');
INSERT INTO Medication VALUES(5,'Melioraurin','Snafu Pharmaceuticals','N/A');

INSERT INTO Prescribes VALUES(1,100000001,1,'2008-04-24 10:47',13216584,'5');
INSERT INTO Prescribes VALUES(9,100000004,2,'2008-04-27 10:53',86213939,'10');
INSERT INTO Prescribes VALUES(9,100000004,2,'2008-04-30 16:53',NULL,'5');

INSERT INTO Block VALUES(1,1);
INSERT INTO Block VALUES(1,2);
INSERT INTO Block VALUES(1,3);
INSERT INTO Block VALUES(2,1);
INSERT INTO Block VALUES(2,2);
INSERT INTO Block VALUES(2,3);
INSERT INTO Block VALUES(3,1);
INSERT INTO Block VALUES(3,2);
INSERT INTO Block VALUES(3,3);
INSERT INTO Block VALUES(4,1);
INSERT INTO Block VALUES(4,2);
INSERT INTO Block VALUES(4,3);

INSERT INTO Room VALUES(101,'Single',1,1,0);
INSERT INTO Room VALUES(102,'Single',1,1,0);
INSERT INTO Room VALUES(103,'Single',1,1,0);
INSERT INTO Room VALUES(111,'Single',1,2,0);
INSERT INTO Room VALUES(112,'Single',1,2,1);
INSERT INTO Room VALUES(113,'Single',1,2,0);
INSERT INTO Room VALUES(121,'Single',1,3,0);
INSERT INTO Room VALUES(122,'Single',1,3,0);
INSERT INTO Room VALUES(123,'Single',1,3,0);
INSERT INTO Room VALUES(201,'Single',2,1,1);
INSERT INTO Room VALUES(202,'Single',2,1,0);
INSERT INTO Room VALUES(203,'Single',2,1,0);
INSERT INTO Room VALUES(211,'Single',2,2,0);
INSERT INTO Room VALUES(212,'Single',2,2,0);
INSERT INTO Room VALUES(213,'Single',2,2,1);
INSERT INTO Room VALUES(221,'Single',2,3,0);
INSERT INTO Room VALUES(222,'Single',2,3,0);
INSERT INTO Room VALUES(223,'Single',2,3,0);
INSERT INTO Room VALUES(301,'Single',3,1,0);
INSERT INTO Room VALUES(302,'Single',3,1,1);
INSERT INTO Room VALUES(303,'Single',3,1,0);
INSERT INTO Room VALUES(311,'Single',3,2,0);
INSERT INTO Room VALUES(312,'Single',3,2,0);
INSERT INTO Room VALUES(313,'Single',3,2,0);
INSERT INTO Room VALUES(321,'Single',3,3,1);
INSERT INTO Room VALUES(322,'Single',3,3,0);
INSERT INTO Room VALUES(323,'Single',3,3,0);
INSERT INTO Room VALUES(401,'Single',4,1,0);
INSERT INTO Room VALUES(402,'Single',4,1,1);
INSERT INTO Room VALUES(403,'Single',4,1,0);
INSERT INTO Room VALUES(411,'Single',4,2,0);
INSERT INTO Room VALUES(412,'Single',4,2,0);
INSERT INTO Room VALUES(413,'Single',4,2,0);
INSERT INTO Room VALUES(421,'Single',4,3,1);
INSERT INTO Room VALUES(422,'Single',4,3,0);
INSERT INTO Room VALUES(423,'Single',4,3,0);

INSERT INTO On_Call VALUES(101,1,1,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(101,1,2,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(102,1,3,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(103,1,1,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,1,2,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,1,3,'2008-11-04 19:00','2008-11-05 03:00');

INSERT INTO Stay VALUES(3215,100000001,111,'2008-05-01','2008-05-04');
INSERT INTO Stay VALUES(3216,100000003,123,'2008-05-03','2008-05-14');
INSERT INTO Stay VALUES(3217,100000004,112,'2008-05-02','2008-05-03');

INSERT INTO Undergoes VALUES(100000001,6,3215,'2008-05-02',3,101);
INSERT INTO Undergoes VALUES(100000001,2,3215,'2008-05-03',7,101);
INSERT INTO Undergoes VALUES(100000004,1,3217,'2008-05-07',3,102);
INSERT INTO Undergoes VALUES(100000004,5,3217,'2008-05-09',6,NULL);
INSERT INTO Undergoes VALUES(100000001,7,3217,'2008-05-10',7,101);
INSERT INTO Undergoes VALUES(100000004,4,3217,'2008-05-13',3,103);

INSERT INTO Trained_In VALUES(3,1,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,5,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,7,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(6,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(6,5,'2007-01-01','2007-12-31');
INSERT INTO Trained_In VALUES(6,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,1,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,3,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,4,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,5,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,7,'2008-01-01','2008-12-31');

--Questions
-- 8.1 Obtain the names of all physicians that have performed a medical procedure they have never been certified to perform.

-- Ich verbinde nur zwischen Tained_id und Undergoes. and then i create sub query in select to show the name of physician.
SELECT (SELECT Name from Physician WHERE EmployeeID = Undergoes.Physician) AS Name , Undergoes.Procedure
FROM Undergoes 
WHERE NOT EXISTS (SELECT * from Trained_In
WHERE Undergoes.Procedure = Trained_In.Treatment AND Trained_In.Physician = Undergoes.Physician);

SELECT Physician.Name, Undergoes.Procedure
FROM Physician
JOIN Undergoes 
ON Physician.EmployeeID = Undergoes.Physician
WHERE NOT EXISTS (SELECT * from Trained_In
WHERE Undergoes.Procedure = Trained_In.Treatment AND Trained_In.Physician = Undergoes.Physician);

SELECT * from Trained_In
WHERE 4 = Trained_In.Treatment AND Trained_In.Physician = 3;

-- nur die kombis, arzt und welche traings
SELECT Physician.Name, Trained_In.Treatment
FROM Physician
JOIN Trained_In 
ON Physician.EmployeeID = Trained_In.Physician;

-- nur die kombis, arzt und welche behandlungen
SELECT Physician.Name, Undergoes.Procedure
FROM Physician
JOIN Undergoes 
ON Physician.EmployeeID = Undergoes.Physician;

--CTE 
WITH Undergoes_table  AS(
SELECT Physician, Procedure
FROM Undergoes
)


WITH Procedure_train  AS(
SELECT Physician, Treatment FROM Trained_In Order By Physician)

WITH Physican_name AS(
SELECT EmployeeID FROM Physician)

SELECT Physician.Name
FROM Physician
JOIN Procedure_train 
ON Physician.EmployeeID = Procedure_train.Physician
JOIN Procedure_train
ON Procedure_train.Treatment = Procedure_table.Code
JOIN Undergoes
ON Procedure_table.Code = Undergoes_table.Procedure
; 


SELECT Physician.Name
FROM Physician
JOIN Trained_In
ON Physician.EmployeeID = Trained_In.Physician
JOIN Undergoes
ON Trained_In.Treatment = Undergoes.Procedure
; 

-- 8.2 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on.

SELECT (SELECT Name from Physician WHERE EmployeeID = Undergoes.Physician) AS Name , Undergoes.Procedure, Undergoes.date, Procedures.Name
FROM Undergoes
JOIN Procedures
ON Undergoes.Procedure = Procedures.Code 
WHERE NOT EXISTS (SELECT * from Trained_In
WHERE Undergoes.Procedure = Trained_In.Treatment AND Trained_In.Physician = Undergoes.Physician);


-- 8.3 Obtain the names of all physicians that have performed a medical procedure that they are certified to perform, but such that the procedure was done at a date (Undergoes.Date) after the physician's certification expired (Trained_In.CertificationExpires).

--subquery (undergoes.date > CertificationExpires
SELECT Physician.Name, EmployeeID, Undergoes.Procedure
FROM Physician
JOIN Undergoes
ON Physician.EmployeeID = Undergoes.Physician
WHERE Undergoes.Date> (Select CertificationExpires from Trained_In );


--CTE 
WITH filtered_table AS (
Select Undergoes.Physician, CertificationExpires, Procedure, Undergoes.Patient
From Trained_In
JOIN Undergoes
ON Trained_In.Physician = Undergoes.Physician
WHERE CertificationExpires < Undergoes.Date)


Select Physician.Name
FROM Physician
JOIN (Select Undergoes.Physician as "doctor"
From Trained_In
JOIN Undergoes
ON Trained_In.Physician = Undergoes.Physician
WHERE CertificationExpires < Undergoes.Date
ON Physician.EmployeeID = doctor;



--subquery
SELECT Physician.Name
From Physician
WHERE (


-- 8.2 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on.
-- 8.3 Obtain the names of all physicians that have performed a medical procedure that they are certified to perform, but such that the procedure was done at a date (Undergoes.Date) after the physician's certification expired (Trained_In.CertificationExpires).
-- 8.4 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on, and date when the certification expired.

WITH filtered_table AS (
Select Undergoes.Physician, CertificationExpires, Procedure, Undergoes.Patient, Date
From Trained_In
JOIN Undergoes
ON Trained_In.Physician = Undergoes.Physician
WHERE CertificationExpires < Undergoes.Date)

SELECT Physician.Name as "doctor name", Procedures.Name as "Procedure", Patient.Name as "Patient", Date as "Procedure date", CertificationExpires
FROM Physician
JOIN filtered_table
ON Physician.EmployeeID = Filtered_table.Physician
JOIN Procedures
ON Procedures.Code = Filtered_table.Procedure
JOIN Patient
On patient.SSN = filtered_table.Patient
;

-- 8.5 Obtain the information for appointments where a patient met with a physician other than his/her primary care physician. Show the following information: Patient name, physician name, nurse name (if any), start and end time of appointment, examination room, and the name of the patient's primary care physician.

-- first i will make a table with patient and Physician / Patient and PCP
SELECT AppointmentID,SSN, Name as "patient name", PCP, Physician
FROM Patient
JOIN Appointment
ON Appointment.Patient = Patient.SSN
WHERE PCP != Physician;

--CTE
WITH appo AS (
SELECT Name as "patient_name", PCP, Physician as "doctor", PrepNurse, Start, End, ExaminationRoom
FROM Patient
JOIN Appointment
ON Appointment.Patient = Patient.SSN
WHERE PCP != Physician)

SELECT  patient_name, Physician.Name As "doctor",  PrepNurse, Start, End, ExaminationRoom
FROM Physician
JOIN appo
ON Physician.EmployeeID = appo.doctor

;


-- 8.6 The Patient field in Undergoes is redundant, since we can obtain it from the Stay table. There are no constraints in force to prevent inconsistencies between these two tables. More specifically, the Undergoes table may include a row where the patient ID does not match the one we would obtain from the Stay table through the Undergoes.Stay foreign key. Select all rows from Undergoes that exhibit this inconsistency.
--Es gibt zwei tabelle, undergoes and stay. In beiden tabllen gibt es stayID and patient. Finde die eintrag mit gleichen stayID aber unterschiedlichen patient.
--stayID ist richtig, aber patient ist falsch, Undergoes patient 


Select *
FROM Undergoes
WHERE Patient <> (
SELECT Patient From Stay 
Where Undergoes.Stay = Stay.StayID
);
SELECT Code FROM Procedures;

-- 8.7 Obtain the names of all the nurses who have ever been on call for room 123.

--CTE at first roomnumber 123 with blockfloor and BlockCode
WITH Room123 AS (
SELECT r.Number, r.BlockFloor, r.BlockCode
FROM Room as r
WHERE Number = 123) 

SELECT Room123.Number, Nurse, (SELECT Name FROM Nurse WHERE Nurse.EmployeeID = o.Nurse) AS "Nurse Name" 
FROM On_Call as o
JOIN Room123
ON r.Blockfloor = o.BlockFloor AND r.BlockCode = o.BlockCode
WHERE o.BlockFloor = 1 AND o.BlockCode = 3;
--doesn't work, so another way in following

Select Number FROM Room WHERE Number= 123;

Select  Nurse, (SELECT Name FROM Nurse WHERE Nurse.EmployeeID = On_Call.Nurse) AS "Nurse Name" 
FROM On_Call
WHERE BlockFloor = 1 AND BlockCode = 3;

-- 8.8 The hospital has several examination rooms where appointments take place. Obtain the number of appointments that have taken place in each examination room.


SELECT ExaminationRoom FROM Appointment ;
SELECT ExaminationRoom, Count(*) From Appointment Group By ExaminationRoom;

-- 8.9 Obtain the names of all patients and their primary care physician, such that the following are true:

SELECT Name, PCP
FROM Patient;


    -- The patient has been prescribed some medication by his/her primary care physician.#

SELECT Name as "Patient", PCP, Medication
FROM Patient
JOIN Prescribes
ON Patient.SSN = Prescribes.Patient
WHERE Patient.PCP = Prescribes.Physician 
;

    -- The patient has undergone a procedure with a cost larger that $5,000

SELECT Patient.Name as "Patient", PCP, Procedures.Name as "Procedure", Procedures.Cost
FROM Patient
JOIN Undergoes
ON Patient.SSN = Undergoes.Patient
JOIN Procedures
ON Undergoes.Procedure = Procedures.Code
WHERE Cost > 5000;
	
    -- The patient has had at least two appointments where the nurse who prepared the appointment was a registered nurse.

    -- The patient has had at least two appointments 
SELECT (Select Name FROM Patient WHERE Patient.SSN = Appointment.Patient) as "Patient", Count(Patient) as "number_of_appointments", PrepNurse
FROM Appointment
GROUP BY Patient
HAVING number_of_appointments >=2 AND PrepNurse =(SELECT EmployeeID FROM Nurse WHERE Registered = 1);
;

SELECT EmployeeID FROM Nurse WHERE Registered = 1;
--

    -- The patient's primary care physician is not the head of any department.

SELECT Name, PCP
FROM Patient;

SELECT Patient.Name as "Patient_Name", PCP, Physician.Name as "Physician_name", Head as "Head_of_Department"
From Patient
JOIN Physician 
ON Physician.EmployeeID = Patient.PCP 
LEFT JOIN Department
ON Department.Head = Physician.EmployeeID;

----final answer
SELECT Patient.Name, Physician.Name
FROM Patient, Physician
Where Patient.PCP = Physician.EmployeeID --all patient and their primary care physicians
AND EXISTS(Select * from Prescribes Where Prescribes.Patient = Patient.SSN And Prescribes.Physician = Patient.PCP)
AND EXISTS(SELECT * from Procedures, Undergoes Where Undergoes.Procedure = Procedures.Code AND Undergoes.Patient = Patient.SSN AND Procedures.Cost > 5000)
AND 2<= (SELECT count(Appointment.AppointmentID) FROM Appointment, Nurse WHERE Appointment.PrepNurse = Nurse.EmployeeID AND Registered = 1)
AND not patient.PCP in (SELECT Head From Department)
;

Task 9:


Alter table cran_logs_2015_01_01
RENAME To CranLogs;

SELECT download_date, TRIM('"' ) FROM 

update CranLogs
set download_date=replace(download_date,'"',' ');

update CranLogs
set ip_id=replace(ip_id,'"',' ');



-- 9.1 Give the package name and how many times they're downloaded. Order by the 2nd column descently.

SELECT package, count(download_date) as "count_of_download" 
FROM CranLogs
GROUP By Package
order by "count_of_download" DESC
;
 
-- 9.2 Give the package ranking (based on how many times it was downloaded) during 9AM to 11AM

SELECT package, count(download_date) as "count_of_download", time,
	dense_RANK () OVER ( 
		ORDER BY count(download_date) DESC
	) downloadRank,
	row_number()  OVER ( 
		ORDER BY count(download_date) DESC
	) rowrank
FROM CranLogs
WHERE time BETWEEN '09:00:00' AND '11:00:00'
GROUP By Package
ORDER BY "count_of_download" DESC
;
 

-- 9.3 How many recordings are from China ("CN") or Japan("JP") or Singapore ("SG")?
CREATE INDEX CranLogsCountry 
ON CranLogs(country);

-- subquery
SELECT DISTINCT(country), (SELECT count(*) from CranLogs x where c.country = x.country) as "Number"
FROM CranLogs c
where c.country IN ("CN","JP","SG");

-- group having
SELECT
	country,
	COUNT(*)
FROM
	CranLogs
GROUP BY
	country
having country IN ("CN","JP","SG");

select distinct(country) from CranLogs

--union
SELECT country, count(*) as "Number"
FROM CranLogs
where country ="CN"
UNION
SELECT country, count(*) as "Number"
FROM CranLogs
where country ="JP"
UNION
SELECT country, count(*) as "Number"
FROM CranLogs
where country ="SG";

-- 9.4 Print the countries whose downloaded are more than the downloads from China ("CN")

SELECT country, count(*) as "Number"
FROM CranLogs
GROUP BY country
HAVING "Number" > (select count(*) from CranLogs where country = "CN");

-- 9.5 Print the average length of the package name of all the UNIQUE packages
SELECT DISTINCT round(AVG(length(DISTINCT package)))as "Average_length_of_package_name"
from CranLogs;

SELECT DISTINCT package, length(DISTINCT package) as "length_of_package_name"
from CranLogs;
-- 9.6 Get the package whose download count ranks 2nd (print package name and its download count).

CREATE VIEW package_download_rank AS
SELECT package, count(package) as "count_of_packages"
FROM CranLogs
GROUP BY package
ORDER BY count(package) DESC;
SELECT Package,count_of_packages,
DENSE_RANK()OVER(ORDER BY count_of_packages DESC ) AS "download_rank"
From package_download_rank
;


-- 9.7 Print the name of the package whose download count is bigger than 1000.
SELECT package, count_of_packages
FROM package_download_rank
WHERE count_of_packages > 1000;

-- 9.8 The field "r_os" is the operating system of the users.
    -- 	Here we would like to know what main system we have (ignore version number), the relevant counts, and the proportion (in percentage).
Select DISTINCT r_os
From CranLogs; 

WITH os AS (
SELECT Distinct r_os, count(*)
FROM CranLogs
Group by r_os)

SELECT r_os,count(r_os) as "count_of_os"
FROM CranLogs
Where r_os like "darwin%"
UNION
SELECT r_os,count(r_os)as "count_of_os"
FROM CranLogs
Where r_os like "linux%"
UNION
SELECT r_os, count(r_os)as "count_of_os"
FROM CranLogs
Where r_os like "ming%"
UNION 
SELECT r_os, count(r_os)as "count_of_os"
FROM CranLogs
WHERE r_os like "N%"
;

--it doesn't work, bacause count_of_sum is in another query.  
Alter table CranLogs
ADD COLUMN Percentage
GENERATED ALWAYS AS (count_of_os/sum(count_of_os))
;

--heiko variant1
SELECT "Darwin" AS r_os ,count(r_os) as "count_of_os", 100*count(r_os)/(SELECT count(*) FROM CranLogs) AS percentage
FROM CranLogs
Where r_os like "darwin%"
UNION
SELECT "Linux",count(r_os)as "count_of_os", 100*count(r_os)/(SELECT count(*) FROM CranLogs)
FROM CranLogs
Where r_os like "linux%"
UNION
SELECT "Ming", count(r_os)as "count_of_os", 100*count(r_os)/(SELECT count(*) FROM CranLogs)
FROM CranLogs
Where r_os like "ming%"
UNION 
SELECT "NA", count(r_os)as "count_of_os", 100*count(r_os)/(SELECT count(*) FROM CranLogs)
FROM CranLogs
WHERE r_os like "N%"
;

--rtrim
select rtrim(r_os, "0123456789.") as os, count(*) as "count_of_os", 
round(100.0*count(*)/(SELECT count(*) FROM CranLogs),2) as percentage
from CranLogs
GROUP by os;

--6regexpress 

CREATE TABLE PEOPLE (id INTEGER, name CHAR);

INSERT INTO PEOPLE VALUES(1, "A");
INSERT INTO PEOPLE VALUES(2, "B");
INSERT INTO PEOPLE VALUES(3, "C");
INSERT INTO PEOPLE VALUES(4, "D");

CREATE TABLE ADDRESS (id INTEGER, address CHAR, updatedate date);

INSERT INTO ADDRESS VALUES(1, "address-1-1", "2016-01-01");
INSERT INTO ADDRESS VALUES(1, "address-1-2", "2016-09-02");
INSERT INTO ADDRESS VALUES(2, "address-2-1", "2015-11-01");
INSERT INTO ADDRESS VALUES(3, "address-3-1", "2016-12-01");
INSERT INTO ADDRESS VALUES(3, "address-3-2", "2014-09-11");
INSERT INTO ADDRESS VALUES(3, "address-3-3", "2015-01-01");
INSERT INTO ADDRESS VALUES(4, "address-4-1", "2010-05-21");
INSERT INTO ADDRESS VALUES(4, "address-4-2", "2012-02-11");
INSERT INTO ADDRESS VALUES(4, "address-4-3", "2015-04-27");
INSERT INTO ADDRESS VALUES(4, "address-4-4", "2014-01-01");


SELECT * from People;
SELECT * from address;

SELECT * from PEOPLE  INNER JOIN address On PEOPLE.id = address.id;

-- 10.1 Join table PEOPLE and ADDRESS, but keep only one address information for each person (we don't mind which record we take for each person). 
    -- i.e., the joined table should have the same number of rows as table PEOPLE
SELECT *
from PEOPLE
Where id IN (SELECT distinct id from address)
;

SELECT *
FROM PEOPLE
left Join address
ON PEOPLE.id = address.id
Group By people.id;

-- 10.2 Join table PEOPLE and ADDRESS, but ONLY keep the LATEST address information for each person. 
    -- i.e., the joined table should have the same number of rows as table PEOPLE

SELECT people.id, address as latest_address, Max(updatedate)as latest_date
from PEOPLE  
INNER JOIN address 
On PEOPLE.id = address.id
Group by people.id 
;



			


--day 11 ecomm.db
CREATE INDEX AssessmentASIN ON assessment(ASIN);
CREATE Index ProductsType ON products(product_type);
CREATE INDEX productsASIN on products(ASIN);

SELECT product_type, round(AVG(rating),2)
FROM products
JOIN assessment
ON products.index_col = assessment.index_col
GROUP BY product_type;

--Question 1: What are the average ratings for each product type?

SELECT product_type, round(AVG(rating),2)
FROM products
JOIN assessment
ON products.index_col = assessment.index_col
GROUP BY product_type;

--Question 2 & 3: What are the top 3 products in each product segment by customer rating?
--Are they the most reviewed products as well?
--Are they the most reviewed products as well?



--Question 4: What are the top 3 selling products in each product segment?

--Question 5: What are the top 5 items generating the maximum sales revenue?

--Question 6: What are the top 5 countries generating the max sales revenue, excluding the host country (Germany)?

--Question 7: What are the first and second worst-selling products in every category?

--Question 8: Unique customers per month for the year 2019