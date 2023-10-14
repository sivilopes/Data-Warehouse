------------------------------------------------------------------------------
--Project  - Data Warehouse Implementation
--Pet shop - Dat Mart - Dimensions
------------------------------------------------------------------------------

------------------------------------------------------------------------------
--Create a Schema connect with system
------------------------------------------------------------------------------
--ALTER SESSION SET "_ORACLE_SCRIPT" = true;
--
--CREATE USER petshopdm identified by petshopdm;
--
--GRANT ALL PRIVILEGES TO petshopdm;

--SELECT * FROM all_users ORDER BY Created DESC;

------------------------------------------------------------------------------
--DROP TABLE FactSales;
--DROP TABLE dimdate;
--DROP TABLE DimCustomer;
--DROP TABLE DimSales;
--DROP TABLE DimSupplier;

------------------------------------------------------------------------------
--Fact Table
------------------------------------------------------------------------------

CREATE TABLE FactSales (
CustomerKey         NUMBER(10)      NOT NULL,
SalesKey            NUMBER(10)      NOT NULL,
SupplierKey         NUMBER(10)      NOT NULL,
DateKey             NUMBER(8)       NOT NULL,
Quantity            NUMBER(4)       NOT NULL,
UnitPrice           NUMBER(10,2)    NOT NULL,
TaxRate             NUMBER(10,3)    NOT NULL,
TotalBeforeTax      NUMBER(10,2)    NOT NULL,
TotalAfterTax       NUMBER(10,2)    NOT NULL
);

-- Create Indexes
CREATE INDEX IX_FactSales_CustomerKey   ON FactSales(CustomerKey);
CREATE INDEX IX_FactSales_SalesKey    ON FactSales(SalesKey);
CREATE INDEX IX_FactSales_SupplierKey   ON FactSales(SupplierKey);
CREATE INDEX IX_FactSales_DateKey       ON FactSales(DateKey);

COMMIT;


------------------------------------------------------------------------------
--Create Dimensional Model tables
------------------------------------------------------------------------------

-----------------------------------
--Create the DimDate - Type 0

CREATE TABLE dimdate (
    datekey       NUMBER(10)    NOT NULL,
    datevalue     DATE          NOT NULL,
    cyear         NUMBER(10)    NOT NULL,
    yearspan      NUMBER(10)    NOT NULL,
    cqtr          NUMBER(1)     NOT NULL,
    qtrspan       NUMBER(10)    NOT NULL,
    qtrstart      DATE          NOT NULL,
    qtrend        DATE          NOT NULL,
    cmonth        NUMBER(2)     NOT NULL,
    monthspan     NUMBER(10)    NOT NULL,
    dayno         NUMBER(2)     NOT NULL,
    startofmonth  DATE          NOT NULL,
    endofmonth    DATE          NOT NULL,
    monthname     VARCHAR2(9)   NOT NULL,
    dayofweekname VARCHAR2(9)   NOT NULL,
    CONSTRAINT pk_dimdate PRIMARY KEY ( datekey )
);

-----------------------------------
--Create the DimCustomer - Type 1
CREATE TABLE DimCustomer(
    CustomerKey             NUMBER(10),
    CustomerNum             NUMBER(10)      NULL, --CustomerID from Customer
    CustomerFullName        NVARCHAR2(100)  NULL, 
    CityName                NVARCHAR2(50)   NULL,
    StateProvName           NVARCHAR2(50)   NULL,
    CountryName             NVARCHAR2(50)   NULL,
    CustomerStatus          NVARCHAR2(20)   NULL,
CONSTRAINT PK_DimCustomer PRIMARY KEY ( CustomerKey )
);

-----------------------------------
--Create the DimSales - Type 2
CREATE TABLE DimSales(
    SalesKey            NUMBER(10),
    SalesNum            NVARCHAR2(30), --ProductID from Products
    SalesName           NVARCHAR2(100)  NULL,
    SalesCategory       NVARCHAR2(50)   NULL,
    UnitPrice           NUMBER(10,2)    NULL,
    Supplier            NVARCHAR2(50)   NULL,    
    SupplierContact     NVARCHAR2(50)   NULL,    
    StartDate           DATE            NOT NULL,
    EndDate             DATE            NULL,
CONSTRAINT PK_DimSales PRIMARY KEY ( SalesKey )
);

-----------------------------------
--Create the DimService - Type 1
CREATE TABLE DimSupplier(
    SupplierKey             NUMBER(10),
    SupplierNum             NUMBER(10)      NULL, --SupplierID from Supplier
    CompanyName             NVARCHAR2(100)  NULL, 
    ContactName             NVARCHAR2(50)   NULL,
    SupplierType            NVARCHAR2(50)   NULL,
    SupplierStatus          NVARCHAR2(20)   NULL,
CONSTRAINT PK_DimSupplier PRIMARY KEY ( SupplierKey )
);

-----------------------------------
-- Create constraints 
ALTER TABLE factsales ADD CONSTRAINT FK_FactSales_DimCustomer       FOREIGN KEY (CustomerKey)       REFERENCES DimCustomer (CustomerKey);
ALTER TABLE factsales ADD CONSTRAINT FK_FactSales_DimSales          FOREIGN KEY (SalesKey)        REFERENCES DimSales (SalesKey);
ALTER TABLE factsales ADD CONSTRAINT FK_FactSales_DimSupplier       FOREIGN KEY (SupplierKey)       REFERENCES DimSupplier (SupplierKey);
ALTER TABLE factsales ADD CONSTRAINT FK_FactSales_DimDate           FOREIGN KEY (DateKey)           REFERENCES DimDate (dateKey);

COMMIT;
