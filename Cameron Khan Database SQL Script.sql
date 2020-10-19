/* Creation of the database and a Line to ensure MyPhpAdmin knows to apply all of the below script to said database */
CREATE DATABASE LincolnGardenCenter;
USE LincolnGardenCenter;

/* creation of tables, some missing or having extra columns that are there to fix with alter later */
CREATE TABLE IF NOT EXISTS Customers
(
CustomerEmailAddress varchar(255) NOT NULL, 
FirstName varchar(255) NOT NULL,
LastName varchar(255) NOT NULL,
DeliveryAddress varchar(255) NOT NULL,
TelephoneNumber int NOT NULL,
/* this is how you create a primary key */
PRIMARY KEY (CustomerEmailAddress)
);

CREATE TABLE IF NOT EXISTS Staff 
(
StaffEmailAddress varchar(255) NOT NULL,
FirstName varchar(255) NOT NULL,
LastName varchar(255) NOT NULL,
StaffAddress varchar(255) NOT NULL,
NationalInsuranceNumber int NOT NULL  /* This will be changed to var char via Alter column */
/* will use alter add constraint to make this the primary key */
);

CREATE TABLE IF NOT EXISTS Plants 
(
PlantImage varchar(255) NOT NULL, /* to be deleted later using Alter table Drop function */
LatinName varchar(255) NOT NULL,
PopularName varchar(255) NOT NULL,
ColourOfFoliage varchar(255) NOT NULL,
ColourOfFlower varchar(255) NOT NULL,
FloweringPeriod varchar(255) NOT NULL,
SeasonOfInterest varchar(255) NOT NULL, 
 /*leaving out PlantsPrice to show alter add function later */
Height_In_Meters int NOT NULL,
Spread_In_Meters int NOT NULL,
PRIMARY KEY (LatinName)
);

CREATE TABLE IF NOT EXISTS Accessories 
(
AccessoryName varchar(255) NOT NULL,
/*leaving out AccessoryDescription to show alter add function later */
AccessoryImage varchar(255) NOT NULL, /* to be deleted later using Drop function */
AccesoryPrice decimal NOT NULL
/* will use alter add constraint to make this the primary key */
);

CREATE TABLE IF NOT EXISTS Services 
(
TypeOfService varchar(255) NOT NULL,
ServiceDescription varchar(255) NOT NULL, 
ServiceImage int NOT NULL, /* to be deleted later using Drop function */
ServicePrice varchar(255) NOT NULL, /* data-type to be altered using alter */
PRIMARY KEY (TypeOfService)
);

CREATE TABLE IF NOT EXISTS Supplier 
(
SupplierEmailAddress varchar(255) NOT NULL,
SupplierFirstName varchar(255) NOT NULL,
SupplierLastName varchar(255) NOT NULL,
SupplierAddress varchar(255) NOT NULL,
TelephoneNumber int NOT NULL,
PRIMARY KEY (SupplierEmailAddress)
);

CREATE TABLE IF NOT EXISTS CustomerOrder
(
CustomerEmailAddress varchar(255) NOT NULL,
BillingAddress varchar(255) NOT NULL,
ItemsOrdered varchar(255) NOT NULL,
OrderStatus varchar(255) NOT NULL,
TotalPrice decimal NOT NULL, 
Quantity int NOT NULL, 
OrderDate date NOT NULL,
DispatchDate int, /* altering to correct data type using alter */
InvoiceDate date NOT NULL,
PaymentDate date NOT NULL,
PRIMARY KEY (OrderDate),
CONSTRAINT FK_CustomerOrder FOREIGN KEY (CustomerEmailAddress) REFERENCES Customers(CustomerEmailAddress) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS PurchaseOrder 
(
AccName varchar(255) NOT NULL,
SupplierEmailAddress varchar(255) NOT NULL,
PurchaseOrderQuantity int NOT NULL, 
PurchaseOrderPrice decimal NOT NULL, 
PurchaseOrderDate date NOT NULL /* In the design stage we set a constraint stating the garden company will/ can only make 1 order a day there for this will be out primary key)
/*will add keys via alter command*/
);

CREATE TABLE IF NOT EXISTS Feedback 
(
FeedbackDescription varchar(255) NOT NULL, 
CustomerEmailAddress varchar(255) NOT NULL,
CustomerOrderDate date NOT NULL, 
/* method for applying constraint's. Here the constraint are foreign keys */
CONSTRAINT FK_Feedback_One FOREIGN KEY (CustomerEmailAddress) REFERENCES Customers (CustomerEmailAddress) ON UPDATE CASCADE,
CONSTRAINT FK_Feedback_Two FOREIGN KEY (CustomerOrderDate) REFERENCES CustomerOrder (OrderDate) ON UPDATE CASCADE,
CONSTRAINT PK_Feedback PRIMARY KEY (CustomerEmailAddress,CustomerOrderDate)
);

/* Here I show use of Alter Table Functions and Commands */

/* Adding keys and constraints via Alter */
ALTER TABLE Staff
ADD PRIMARY KEY (NationalInsuranceNumber);

ALTER TABLE Accessories
ADD PRIMARY KEY (AccessoryName);

ALTER TABLE PurchaseOrder
ADD PRIMARY KEY (PurchaseOrderDate);

ALTER TABLE PurchaseOrder
ADD CONSTRAINT FK_PurchaseOrder_One FOREIGN KEY (SupplierEmailAddress) REFERENCES Supplier (SupplierEmailAddress) ON UPDATE CASCADE;

ALTER TABLE PurchaseOrder
ADD CONSTRAINT FK_PurchaseOrder_Two FOREIGN KEY (AccName) REFERENCES Accessories (AccessoryName) ON UPDATE CASCADE;

/* Dropping Columns via Alter */
ALTER TABLE Plants
DROP COLUMN PlantImage;

ALTER TABLE Accessories
DROP COLUMN AccessoryImage;

ALTER TABLE Services
DROP COLUMN ServiceImage;

/* Adding Columns via Alter*/
ALTER TABLE Accessories
ADD AccessoryDescription varchar(255) NOT NULL;

ALTER TABLE Plants
ADD PlantsPrice decimal NOT NULL;

/* Modifying Column Data-types via Alter*/
ALTER TABLE Staff
MODIFY COLUMN NationalInsuranceNumber char(9) NOT NULL; 

ALTER TABLE CustomerOrder
MODIFY COLUMN DispatchDate date; 

ALTER TABLE Services
MODIFY COLUMN ServicePrice decimal; 

/* Applying Constraint's to ensure data for fields are Unique and not Copied via the Unique Function and Alter function*/

ALTER TABLE Accessories
ADD UNIQUE (AccessoryDescription);

ALTER TABLE Services
ADD UNIQUE (ServiceDescription);

ALTER TABLE Feedback
ADD UNIQUE (FeedbackDescription);

/* End of DDL */

/* Start of DML */

/* Inesertion of data into each table and coloumn */

INSERT INTO Customers(TelephoneNumber, CustomerEmailAddress, FirstName, LastName, DeliveryAddress)  
VALUES (012345678, 'PlantloverFox@gmail.co.uk','Freddrick','Ainsley','12 Up Down Avernue'),
(876543210, 'AppleSnapple@hotmail.com','Jessica','Bond','21 Down Left Street'),
(10101010, 'Sail101@aol.com','July','Stooley','4 Pickle Road'),
(20101010, 'void@aol.com','Void','Boi','22 Snippet Street'),
(20101010, 'Empty@aol.com','Empty','Jones','22 Snippet Street');

INSERT INTO Staff(StaffEmailAddress, FirstName, LastName, StaffAddress, NationalInsuranceNumber)  
VALUES ('Bane@LGS.com','Bane','Hope','49 Imp Road','ABB9M9M8A'),
('Ingrid@LGC.com','Ingrid','Marley','51 GardenLand Road','B7M9P1ABA'),
('Tobias@LGC.com','Tobias','Hall','10 Wickle Road','A9B9D1ASP'),
('Srappy@LGC.com','Scrappy','Doo','51 GardenLand Road','B9J9P1A9W');

INSERT INTO Plants(LatinName, PopularName, ColourOfFoliage, ColourOfFlower, FloweringPeriod, SeasonOfInterest, Height_In_Meters, Spread_In_Meters, PlantsPrice)  
VALUES ('Acer palmatum-Bloodgood','Japanese Maple','Red','N/A','Early to Mid Spring','Autumn',1.2, 8.00, 16.00),
('Hyacinthoides italica','Italian Bluebell','Green','Blue','Mid to Late Winter','Summer', 0.3, 0.1, 20.00),
('Hokus Pokas','Fake Plant','Pink','Blue','Mid to Late Winter','Summer', 0.3, 0.1, 6000.00),
('Sambucus nigra f. porphyrophylla','Elder Gerda','Green','Pink','Late Spring','Autumn', 3.5, 4, 50.00);

INSERT INTO Accessories(AccessoryName, AccessoryDescription, AccesoryPrice)  
VALUES ('Clay Plant Pot','A terracotta Red clay plant pot', 11.00),
('Triangular Half Glass Geometric Terrarium','Modern style Artistic glass cube, Ideal size for fern, moss, succulent, airplants, cacti or other plants with easy maintainence', 24.99),
('Steel Handle Trowel','Sturdy Hand Trowel perfect for digging in plant pots and small shallow holes', 09.00);

INSERT INTO Services(TypeOfService, ServiceDescription, ServicePrice)  
VALUES ('Hill Landscaping','Any hill of land that needs scaping to accomodate for certain plants or to create flat areas of ground which gives extra garden space. ', 112.00),
('Patio Paving','Will pave and create a patio in your garden ', 202.00),
('Hedge and Bush Trimming','Will trim edges', 55.00);

INSERT INTO Supplier(SupplierEmailAddress, SupplierFirstName, SupplierLastName, SupplierAddress, TelephoneNumber)  
VALUES ('JohnsGardenWarehouse@Email.com','John','Bob','11 Marval Industrial Cresent', 10029981),
('LisaGardenz@email.co.uk','Lisa','Misha','36 Cricket Road', 31212567),
('GardenAccesories5U@hotmail.com','Pete','Steve','44 Pickle avenue', 10261090);


INSERT INTO CustomerOrder(BillingAddress, ItemsOrdered, OrderStatus, CustomerEmailAddress, OrderDate, DispatchDate, InvoiceDate, PaymentDate, Quantity, TotalPrice)  
VALUES ('12 Up Down Avernue','FlowerPots','On Route','PlantloverFox@gmail.co.uk', '1999-01-13', '1999-01-14', '1999-01-20', '1999-01-13', 5, 30.00),
('21 Down Left Street','PurpleFlower','Stocking','AppleSnapple@hotmail.com', '2020-06-01', '2020-06-15', '2020-06-03', '2020-06-01', 3, 55.12),
('4 Pickle Road','Patio service','Will visit in 1 day after payment to complete work','Sail101@aol.com', '2017-07-31', '2017-08-01', '2017-07-31', '2017-07-31', 1, 200.99);

INSERT INTO PurchaseOrder( AccName, SupplierEmailAddress, PurchaseOrderDate, PurchaseOrderPrice, PurchaseOrderQuantity )  
VALUES ('Clay Plant Pot','JohnsGardenWarehouse@Email.com', '2001-04-24', 515.22 , 100),
('Triangular Half Glass Geometric Terrarium','LisaGardenz@email.co.uk', '2010-12-07', 1010.00, 200),
('Steel Handle Trowel','GardenAccesories5U@hotmail.com', '2009-10-18', 199.99, 30);

INSERT INTO Feedback(FeedbackDescription, CustomerEmailAddress, CustomerOrderDate)  
VALUES ('It good','PlantloverFox@gmail.co.uk', '1999-01-13'),
('woweee would buy from here agan','AppleSnapple@hotmail.com', '2020-06-01'),
('service staff was rude tutut','Sail101@aol.com', '2017-07-31');

/* Deletion of unwanted values via the Delete and Where function */

DELETE FROM Customers
WHERE DeliveryAddress='22 Snippet Street';

DELETE FROM Staff
WHERE FirstName='Scrappy';

DELETE FROM Plants
WHERE PlantsPrice>2000.00;

/* Use of Update and SET Function */

UPDATE Customers
SET DeliveryAddress = '39 East West Road'
WHERE TelephoneNumber = '876543210' ;

UPDATE Staff
SET StaffEmailAddress = 'IngridTheSecond@LGC.com'
WHERE FirstName = 'Ingrid' ;

/* Inner, Left and Right Join */

SELECT * FROM Customers INNER JOIN CustomerOrder ON
Customers.CustomerEmailAddress = CustomerOrder.CustomerEmailAddress;

SELECT Customers.FirstName, CustomerOrder.OrderDate
FROM Customers
LEFT JOIN CustomerOrder 
ON Customers.CustomerEmailAddress = CustomerOrder.CustomerEmailAddress
ORDER BY Customers.FirstName;

SELECT PurchaseOrder.PurchaseOrderDate, Supplier.SupplierFirstName, Supplier.SupplierLastName
FROM PurchaseOrder
RIGHT JOIN Supplier
ON PurchaseOrder.SupplierEmailAddress = Supplier.SupplierEmailAddress
ORDER BY Supplier.SupplierFirstName;

/* Shows use and Understand of Union */

SELECT TelephoneNumber FROM Customers
UNION ALL
SELECT TelephoneNumber FROM Supplier
ORDER BY TelephoneNumber;

SELECT CustomerEmailAddress FROM Customers
UNION ALL
SELECT StaffEmailAddress FROM Staff
ORDER BY CustomerEmailAddress;

/* Creating copies of Tables above and Insert all values above to the copied tables via Insert Into and Select */
CREATE TABLE Copy_Of_Customers LIKE Customers;

CREATE TABLE Copy_Of_Staff LIKE Staff;

CREATE TABLE Copy_Of_Plants LIKE Plants;

CREATE TABLE Copy_Of_Accessories LIKE Accessories;

CREATE TABLE Copy_Of_Services LIKE Services;

CREATE TABLE Copy_Of_Supplier LIKE Supplier;

CREATE TABLE Copy_Of_CustomerOrder LIKE CustomerOrder;

CREATE TABLE Copy_Of_PurchaseOrder LIKE PurchaseOrder;

CREATE TABLE Copy_Of_Feedback LIKE Feedback;

INSERT INTO Copy_Of_Customers (TelephoneNumber, CustomerEmailAddress, FirstName, LastName, DeliveryAddress)  
SELECT TelephoneNumber, CustomerEmailAddress, FirstName, LastName, DeliveryAddress   
FROM Customers;

INSERT INTO Copy_Of_Staff (StaffEmailAddress, FirstName, LastName, StaffAddress, NationalInsuranceNumber) 
SELECT StaffEmailAddress, FirstName, LastName, StaffAddress, NationalInsuranceNumber   
FROM Staff;

INSERT INTO Copy_Of_Plants (LatinName, PopularName, ColourOfFoliage, ColourOfFlower, FloweringPeriod, SeasonOfInterest, Height_In_Meters, Spread_In_Meters, PlantsPrice)
SELECT LatinName, PopularName, ColourOfFoliage, ColourOfFlower, FloweringPeriod, SeasonOfInterest, Height_In_Meters, Spread_In_Meters, PlantsPrice 
FROM Plants;

INSERT INTO Copy_Of_Accessories (AccessoryName, AccessoryDescription, AccesoryPrice) 
SELECT AccessoryName, AccessoryDescription, AccesoryPrice
FROM Accessories;

INSERT INTO Copy_Of_Services (TypeOfService, ServiceDescription, ServicePrice)
SELECT TypeOfService, ServiceDescription, ServicePrice
FROM Services;

INSERT INTO Copy_Of_Supplier (SupplierEmailAddress, SupplierFirstName, SupplierLastName, SupplierAddress, TelephoneNumber)
SELECT SupplierEmailAddress, SupplierFirstName, SupplierLastName, SupplierAddress, TelephoneNumber
FROM Supplier;

INSERT INTO Copy_Of_CustomerOrder (BillingAddress, ItemsOrdered, OrderStatus, CustomerEmailAddress, OrderDate, DispatchDate, InvoiceDate, PaymentDate, Quantity, TotalPrice)
SELECT BillingAddress, ItemsOrdered, OrderStatus, CustomerEmailAddress, OrderDate, DispatchDate, InvoiceDate, PaymentDate, Quantity, TotalPrice
FROM CustomerOrder;

INSERT INTO Copy_Of_PurchaseOrder (AccName, SupplierEmailAddress, PurchaseOrderDate, PurchaseOrderPrice, PurchaseOrderQuantity) 
SELECT AccName, SupplierEmailAddress, PurchaseOrderDate, PurchaseOrderPrice, PurchaseOrderQuantity
FROM PurchaseOrder;

INSERT INTO Copy_Of_Feedback (FeedbackDescription, CustomerEmailAddress, CustomerOrderDate) 
SELECT FeedbackDescription, CustomerEmailAddress, CustomerOrderDate
FROM Feedback;

/* Here is the creation of a user called "cameron" with the password of "Password", the second line ensures the user "cameron" 
can only use the command select and stops them from using commands such as delete*/

CREATE USER 'cameron'@'localhost' IDENTIFIED BY 'Password';
GRANT SELECT ON LincolnGardenCenter.* TO 'cameron'@'localhost';

/* General Procedure. Here I create a general procedure that returns all Customers in Customer Table that own no NULL columns, I feel like this is useful and 
justified as there could be more than 100 new customers a day and if someone wants to find out the information of said customers 
without having to hassle with people who don't leave there entire details they can just call this procedure */

DELIMITER //
CREATE PROCEDURE NullCustomerCheck()
BEGIN
SELECT * FROM Customers
WHERE CustomerEmailAddress IS NOT NULL AND FirstName IS NOT NULL AND LastName IS NOT NULL AND DeliveryAddress IS NOT NULL AND TelephoneNumber IS NOT NULL;
END //
DELIMITER ;

/* Here is the function to Call the above Procedure. I would like to state that this does work. however only when running said call code below separately
 from the procedure creation */

/* CALL NullCustomerCheck(); */