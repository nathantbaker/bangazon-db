    -- DELETE STUFF IN THE TABLES

    -- Tables Tied To Employees
    DELETE FROM TrainingPrograms;
    DELETE FROM TrainingPrograms_has_Employees;
    DELETE FROM Computers;
    DELETE FROM Departments;
    DELETE FROM Employees;
    -- Tables Tied to Customers
    DELETE FROM PaymentTypes;
    DELETE FROM Customers_has_PaymentTypes;
    DELETE FROM Customers;
    DELETE FROM Orders;
    DELETE FROM Products;
    DELETE FROM ProductTypes;

    -- DELETE THE TABLES

    -- Tables Tied To Employees
    DROP TABLE IF EXISTS TrainingPrograms;
    DROP TABLE IF EXISTS TrainingPrograms_has_Employees;
    DROP TABLE IF EXISTS Computers;
    DROP TABLE IF EXISTS Departments;
    DROP TABLE IF EXISTS Employees;
    -- Tables Tied to Customers
    DROP TABLE IF EXISTS PaymentTypes;
    DROP TABLE IF EXISTS Customers_has_PaymentTypes;
    DROP TABLE IF EXISTS Customers;
    DROP TABLE IF EXISTS Orders;
    DROP TABLE IF EXISTS Products;
    DROP TABLE IF EXISTS ProductTypes;

    -- CREATE THE TABLES

    -- Tables Tied to Employees

    CREATE TABLE `TrainingPrograms` (
        `TrainingProgramsId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        `Name`   VARCHAR NOT NULL,
        `StartDate`   DATE NOT NULL,
        `EndDate`   DATE NOT NULL,
        `MaximumAttendees`   INT NOT NULL
    );

    -- add some training programs
    INSERT INTO TrainingPrograms VALUES (null, 'Refigerator Protocols', '10-JAN-2017', '15-JAN-2017', 50);
    INSERT INTO TrainingPrograms VALUES (null, 'Career Training', '02-FEB-2017', '03-FEB-2017', 20);

    CREATE TABLE `TrainingPrograms_has_Employees` (
        `TrainingPrograms_has_EmployeesId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        `TrainingProgramsId`    INT NOT NULL,
        `EmployeesId`    INT NOT NULL,
        FOREIGN KEY(`TrainingProgramsId`) REFERENCES `TrainingPrograms`(`TrainingProgramsId`),
        FOREIGN KEY(`EmployeesId`) REFERENCES `Employees`(`EmployeesId`)
    );

    -- first three employees tied to first training program
    INSERT INTO TrainingPrograms_has_Employees VALUES (null, 1, 1);
    INSERT INTO TrainingPrograms_has_Employees VALUES (null, 1, 2);
    INSERT INTO TrainingPrograms_has_Employees VALUES (null, 1, 3);
    -- all employees tied 2nd training program
    INSERT INTO TrainingPrograms_has_Employees VALUES (null, 2, 1);
    INSERT INTO TrainingPrograms_has_Employees VALUES (null, 2, 2);
    INSERT INTO TrainingPrograms_has_Employees VALUES (null, 2, 3);
    INSERT INTO TrainingPrograms_has_Employees VALUES (null, 2, 4);
    INSERT INTO TrainingPrograms_has_Employees VALUES (null, 2, 5);

    CREATE TABLE `Computers` (
        `ComputersId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        `PurchaseDate`    DATE NOT NULL,
        `DecommissionedDate`    DATE,
        `Employees_EmployeesId`    INT NOT NULL,
        FOREIGN KEY(`Employees_EmployeesId`) REFERENCES `Employees`(`EmployeesId`)
    );

    INSERT INTO Computers VALUES (null, '07-FEB-2008', null, 2);
    INSERT INTO Computers VALUES (null, '02-FEB-2008', '19-FEB-2016', 3);

    CREATE TABLE `Departments` (
        `DepartmentsId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        `Name`    VARCHAR    NOT NULL,
        `ExpenseBudget`    INT    NOT NULL
    );

    INSERT INTO Departments VALUES (null, 'Development', '100000000');
    INSERT INTO Departments VALUES (null, 'Marketing', '100');

    CREATE TABLE `Employees` (
        `EmployeesId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        `Name`    VARCHAR NOT NULL,
        `Supervisor`    BOOLEAN NOT NULL,
        `Departments_DepartmentsId`    INT NOT NULL,
        `Supervisor_SupervisorId`    INT,
        FOREIGN KEY(`Departments_DepartmentsId`) REFERENCES `Departments`(`DepartmentsId`),
        FOREIGN KEY(`Supervisor_SupervisorId`) REFERENCES `Supervisor`(`SupervisorId`)
    );

    -- Add some employees
    -- Development employees
    INSERT INTO Employees VALUES (null, 'Ben', 'True', '1', '1');
    INSERT INTO Employees VALUES (null, 'Nathan', 'False', '1', '1');
    INSERT INTO Employees VALUES (null, 'Matt', 'False', '1', '1');
    -- Marketing employees
    INSERT INTO Employees VALUES (null, 'Bruce', 'True', '2', '2');
    INSERT INTO Employees VALUES (null, 'Shawn', 'False', '2', '2');


    -- Tables Tied to Customers
    CREATE TABLE `PaymentTypes` (
        `PaymentTypesId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        `AccountNumber`    INTEGER NOT NULL
    );

    INSERT INTO PaymentTypes VALUES (null, 398398324234234);
    INSERT INTO PaymentTypes VALUES (null, 182398238923983);


    CREATE TABLE `Customers_has_PaymentTypes` (
        `Customers_has_PaymentTypesId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        `Customers_CustomersId`    INTEGER NOT NULL,
        `PaymentTypes_PaymentTypesId`    INTEGER NOT NULL,
        FOREIGN KEY(`Customers_CustomersId`) REFERENCES `Customers`(`CustomersId`),
        FOREIGN KEY(`PaymentTypes_PaymentTypesId`) REFERENCES `PaymentTypes`(`PaymentTypesId`)
    );

    INSERT INTO Customers_has_PaymentTypes VALUES (null, 1, 1);
    INSERT INTO Customers_has_PaymentTypes VALUES (null, 2, 2);

    CREATE TABLE `Customers` (
        `CustomersId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        `FirstName`    VARCHAR NOT NULL,
        `LastName`    VARCHAR NOT NULL,
        `AccountCreatedDate`    DATE NOT NULL,
        `LastActiveDate`    DATE NOT NULL,
        `Active`    BOOLEAN NOT NULL
    );

    INSERT INTO Customers VALUES (null, 'Nathan', 'Baker', '02-FEB-2008', '02-FEB-2008', 'False');
    INSERT INTO Customers VALUES (null, 'Larry', 'Blue', '02-FEB-2008', '02-JAN-2017', 'True');

    CREATE TABLE `Orders` (
        `OrdersId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        `Customers_CustomersId`    INTEGER NOT NULL,
        `PaymentTypes_PaymentTypesId`    INTEGER NOT NULL,
        `Active`    BOOLEAN NOT NULL,
        FOREIGN KEY(`PaymentTypes_PaymentTypesId`) REFERENCES `PaymentTypes`(`PaymentTypesId`),
        FOREIGN KEY(`Customers_CustomersId`) REFERENCES `Customers`(`CustomersId`)
    );

    INSERT INTO Orders VALUES (null, 2, 2, 'True');
    INSERT INTO Orders VALUES (null, 1, 1, 'False');

    CREATE TABLE `Products` (
        `ProductsId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        `ProductTypes_ProductTypesId`    INTEGER NOT NULL,
        `ProductPrice`    INTEGER NOT NULL,
        `ProductTitle`    VARCHAR NOT NULL,
        `ProductDescription`    VARCHAR NOT NULL,
        `Customers_CustomersId`    INTEGER NOT NULL,
        `Orders_OrdersId`    INTEGER NOT NULL,
        FOREIGN KEY(`ProductTypes_ProductTypesId`) REFERENCES `ProductTypes`(`ProductTypesId`),
        FOREIGN KEY(`Customers_CustomersId`) REFERENCES `Customers`(`CustomersId`)
    );

        INSERT INTO Products VALUES (null, 1, 332, "Red Shirt", "Cotton summer shirt in red", 1, 2);
        INSERT INTO Products VALUES (null, 2, 33, "Copper", "A truckload of copper", 2, 1);

    CREATE TABLE `ProductTypes` (
        `ProductTypesId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        `Name`    VARCHAR NOT NULL
    );

    INSERT INTO ProductTypes VALUES (null, "Shirts");
    INSERT INTO ProductTypes VALUES (null, "Metals");
    INSERT INTO ProductTypes VALUES (null, "Animals");
