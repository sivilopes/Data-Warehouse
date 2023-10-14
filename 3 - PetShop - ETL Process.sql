------------------------------------------------------------------------------
--Project  - Data Warehouse Implementation
--Pet shop - Dat Mart
------------------------------------------------------------------------------

--DROP TABLE Customer_STAGE;
--DROP TABLE Orders_Stage;
--DROP TABLE Sales_STAGE;
--DROP TABLE Supplier_STAGE;

--DROP TABLE Customer_PRELOAD;
--DROP TABLE orders_PRELOAD;
--DROP TABLE Sales_PRELOAD;
--DROP TABLE Supplier_PRELOAD;
--
--DROP SEQUENCE customerkey;
--DROP SEQUENCE Saleskey;
--DROP SEQUENCE Supplierkey;

--DROP PROCEDURE CUSTOMER_EXTRACT;
--DROP PROCEDURE ORDERS_EXTRACT;
--DROP PROCEDURE SALES_EXTRACT;
--DROP PROCEDURE SUPPLIER_EXTRACT;
--
--DROP PROCEDURE CUSTOMER_TRANSFORM;
--DROP PROCEDURE ORDERS_TRANSFORM;
--DROP PROCEDURE SALES_TRANSFORM;
--DROP PROCEDURE SUPPLIER_TRANSFORM;
--
--DROP PROCEDURE CUSTOMER_LOAD;
--DROP PROCEDURE ORDERS_LOAD;
--DROP PROCEDURE SALES_LOAD;
--DROP PROCEDURE SUPPLIER_LOAD;
--DROP PROCEDURE DIMDATE_LOAD;
--
--COMMIT;

-------------------------------------------
-- ETL Process
-------------------------------------------

-------------------------------------------
-- STAGE Tables 
-------------------------------------------

-------------------------------------------
--Customers_STAGE 
CREATE TABLE Customer_STAGE (
    CustomerNum             NUMBER(10), --CustomerID from Customer
    CustomerFirstName       NVARCHAR2(100), 
    CustomerLastName        NVARCHAR2(100), 
    CityName                NVARCHAR2(50),
    StateProvName           NVARCHAR2(50),
    CountryName             NVARCHAR2(50),
    CustomerStatus          NUMBER(1)
);

-----------------------------------
--Orders_Stage
CREATE TABLE Orders_Stage (
    OrderDate               DATE,
    OrderType               NVARCHAR2(20),
    Quantity                NUMBER(3),
    UnitPrice               NUMBER(18,2),
    TaxRate                 NUMBER(18,3),
    productServiceNum       NVARCHAR2(30), --productID or productID 
    CustomerNum             NUMBER(10), --CustomerID from Customer
    supplierNum             NUMBER(10) --CustomerID from Customer
);


-----------------------------------
-- Sales_Stage
CREATE TABLE Sales_STAGE(
    SalesNum            NVARCHAR2(30),
    SalesName           NVARCHAR2(100),
    SalesCategory       NVARCHAR2(50),
    UnitPrice           NUMBER(10,2),
    retailPrice         NUMBER(10,2),
    Supplier            NVARCHAR2(50),
    SupplierContact     NVARCHAR2(50)
);

-----------------------------------
--Supplier_STAGE
CREATE TABLE Supplier_STAGE(
    SupplierNum             NUMBER(10), 
    CompanyName             NVARCHAR2(100), 
    ContactName             NVARCHAR2(50),
    SupplierType            NVARCHAR2(50),
    SupplierStatus          NUMBER(1)
);

COMMIT;

------------------------------
--EXTRACT PROCEDURES
------------------------------

------------------------------
--Customer_Extract
create or replace NONEDITIONABLE PROCEDURE Customer_Extract 
IS
    RowCt NUMBER(10):=0;
    v_sql VARCHAR(255) := 'TRUNCATE TABLE Customer_Stage DROP STORAGE';
BEGIN
    EXECUTE IMMEDIATE v_sql;

    INSERT INTO Customer_Stage
    SELECT     
           c.CustomerID,
           c.CustomerFirstName,
           c.CustomerLastName,
           c.City,
           c.Province,
           c.Country,
           c.Status
    FROM petshopdb.Customer c;

    RowCt := SQL%ROWCOUNT;
    DBMS_OUTPUT.PUT_LINE('Number of customers added: ' || TO_CHAR(SQL%ROWCOUNT));
    
    EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlerrm);
        dbms_output.put_line(v_sql);
END;
/

------------------------------
-- Sales_Extract

create or replace NONEDITIONABLE PROCEDURE Sales_Extract
IS
    RowCt NUMBER(10):=0;
    v_sql VARCHAR(255) := 'TRUNCATE TABLE Sales_Stage DROP STORAGE';
BEGIN
    EXECUTE IMMEDIATE v_sql;

    INSERT INTO Sales_STAGE
        SELECT 
            PR.PRODUCTCOD,
            PR.PRODUCTNAME,
            PC.CATEGORYNAME, 
            PR.SUPPLIERSPRICE,
            PR.RETAILPRICE,
            SP.SUPPLIERNAME,
            SP.SUPPLIERCONTACTPERSON
        FROM petshopdb.PRODUCT PR
        LEFT OUTER JOIN petshopdb.PRODUCTCATEGORY PC ON (PR.PRODUCTCATEGORYID = PC.PRODUCTCATEGORYID)
        LEFT OUTER JOIN petshopdb.SUPPLIERS SP ON (SP.SUPPLIERID = PR.SUPPLIERID)
        
        UNION
        
        SELECT 
            s.SERVICECOD,
            s.SERVICENAME,
            sc.CATEGORYNAME,
            s.serviceFee,
            s.serviceFee,
            SP.SUPPLIERNAME,
            SP.SUPPLIERCONTACTPERSON
        FROM petshopdb.Service S
        LEFT OUTER JOIN petshopdb.PRODUCTCATEGORY SC ON (S.PRODUCTCATEGORYID = SC.PRODUCTCATEGORYID)
        LEFT OUTER JOIN petshopdb.SUPPLIERS SP ON (S.SUPPLIERID = SP.SUPPLIERID);
        
    RowCt := SQL%ROWCOUNT;
    DBMS_OUTPUT.PUT_LINE('Number of Products added: ' || TO_CHAR(SQL%ROWCOUNT));

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlerrm);
        dbms_output.put_line(v_sql);
        
END;
/

------------------------------
--Supplier_Extract

create or replace NONEDITIONABLE PROCEDURE Supplier_Extract 
IS
    RowCt NUMBER(10):=0;
    v_sql VARCHAR(255) := 'TRUNCATE TABLE Supplier_Stage DROP STORAGE';
BEGIN
    EXECUTE IMMEDIATE v_sql;

    INSERT INTO Supplier_Stage
    SELECT     
           SP.SupplierID,
           SP.SupplierName,
           SP.SUPPLIERCONTACTPERSON,
           T.TYPENAME,
           SP.SUPPLIERSTATUS
    FROM petshopdb.Suppliers SP
    LEFT OUTER JOIN petshopdb.type T on (SP.TYPEID = T.TYPEID);

    RowCt := SQL%ROWCOUNT;
    DBMS_OUTPUT.PUT_LINE('Number of customers added: ' || TO_CHAR(SQL%ROWCOUNT));
    
    EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlerrm);
        dbms_output.put_line(v_sql);
END;
/

------------------------------
-- Orders_Extract

create or replace NONEDITIONABLE PROCEDURE Orders_Extract 
AS
    RowCt NUMBER(10);
    v_sql VARCHAR(255) := 'TRUNCATE TABLE Orders_Stage DROP STORAGE';
BEGIN
    EXECUTE IMMEDIATE v_sql;

    INSERT INTO Orders_Stage
       SELECT O.orderdate,
            T.typename,
            po.prodquantity,
            po.prodprice,
            po.taxrate,
            p.productCOD,
            C.customerid,
            S.supplierid
        FROM petshopdb.Orders O
            LEFT JOIN petshopdb.PRODUCTORDERDETAIL PO      ON (O.OrderID = PO.OrderID)  
            LEFT JOIN petshopdb.customer C                 ON (O.CustomerID = C.CustomerID)
            LEFT JOIN petshopdb.TYPE T                     ON (O.ORDERTYPE = T.TYPEID)
            LEFT JOIN petshopdb.PRODUCT P                  ON (PO.PRODUCTID = P.PRODUCTID)
            LEFT JOIN petshopdb.suppliers S                ON (P.SUPPLIERID = S.SUPPLIERID)
        WHERE ORDERTYPE = 1
UNION ALL
       SELECT O.orderdate,
            T.TYPENAME,
            SO.SERVICEQUANTITY,
            SO.SERVICEPRICE,
            SO.TAXRATE,
            S.serviceCOD,
            C.customerid,
            SP.supplierid
        FROM petshopdb.Orders O
            LEFT JOIN petshopdb.SERVICEORDERDETAIL SO      ON (O.OrderID = SO.OrderID)
            LEFT JOIN petshopdb.customer C                 ON (O.CustomerID = C.CustomerID)
            LEFT JOIN petshopdb.TYPE T                     ON (O.ORDERTYPE = T.TYPEID)
            LEFT JOIN petshopdb.SERVICE S                  ON (SO.SERVICEID = S.SERVICEID)
            LEFT JOIN petshopdb.suppliers SP               ON (S.SUPPLIERID = SP.SUPPLIERID)
        WHERE ORDERTYPE = 2;

    RowCt := SQL%ROWCOUNT;
    IF sql%notfound THEN
       dbms_output.put_line('No records found. Check with source system.');
    ELSIF sql%found THEN
       DBMS_OUTPUT.PUT_LINE('Number of Orders added: ' || TO_CHAR(SQL%ROWCOUNT));
    END IF;

 EXCEPTION
    WHEN OTHERS THEN
       dbms_output.put_line(SQLERRM);
       dbms_output.put_line(v_sql);
END;
/


COMMIT;

------------------------
-- EXECUTE  - Extract proccedures
------------------------
EXECUTE Customer_Extract;
EXECUTE Supplier_Extract;
EXECUTE Sales_Extract;
EXECUTE Orders_Extract;

COMMIT;

-------------------------------------------
-- PRELOAD Tables 
-------------------------------------------

-------------------------------------------
--Customers_preload type 1
CREATE TABLE customer_preload (
    customerkey           NUMBER(10)        NOT NULL,
    customernum           NUMBER(10)        NOT NULL,
    customerfullname      NVARCHAR2(100)    NULL, -- Join First and Last names
    cityname              NVARCHAR2(50)     NULL,
    StateProvName         NVARCHAR2(50)     NULL,
    CountryName           NVARCHAR2(50)     NULL,
    CustomerStatus        NVARCHAR2(20)     NULL, -- Change number to string
    CONSTRAINT pk_customers_preload PRIMARY KEY ( customerkey )
);

--Orders_preload type 1
CREATE TABLE orders_preload (
    customerkey             NUMBER(10)      NOT NULL,
    Saleskey              NUMBER(10)      NOT NULL,
    Supplierkey             NUMBER(10)      NOT NULL,
    datekey                 NUMBER(8)       NOT NULL,
    quantity                NUMBER(3)       NOT NULL,
    unitprice               NUMBER(18, 2)   NOT NULL,
    taxrate                 NUMBER(18, 3)   NOT NULL,
    totalbeforetax          NUMBER(18, 2)   NOT NULL,
    totalaftertax           NUMBER(18, 2)   NOT NULL
);

-------------------------------------------
--Sales_Preload type 2

CREATE TABLE Sales_Preload (
    Saleskey            INT             NOT NULL,
    SalesNum            NVARCHAR2(30)   NOT NULL,
    SalesName           NVARCHAR2(100)  NULL,
    SalesCategory       NVARCHAR2(50)   NULL,
    UnitPrice           NUMBER(10,2)    NULL,
    Supplier            NVARCHAR2(50)   NULL,
    SupplierContact     NVARCHAR2(50)   NULL,
    StartDate           DATE            NOT NULL,
    EndDate             DATE            NULL,
    CONSTRAINT PK_Sales_Preload PRIMARY KEY (Saleskey)
);

-------------------------------------------
--Supplier_Preload type 1

CREATE TABLE Supplier_Preload (
    Supplierkey         INT             NOT NULL,
    SupplierNum         NUMBER(10)      NOT NULL, 
    CompanyName         NVARCHAR2(100)  NULL, 
    ContactName         NVARCHAR2(50)   NULL,
    SupplierType        NVARCHAR2(50)   NULL,
    SupplierStatus      NVARCHAR2(20)   NULL, -- Change number to string
    CONSTRAINT PK_Supplier_Preload PRIMARY KEY (Supplierkey)
);

-------------------------------------------
--Create sequences

CREATE SEQUENCE Customerkey START WITH 1;
CREATE SEQUENCE Saleskey    START WITH 1;
CREATE SEQUENCE Supplierkey START WITH 1;


COMMIT;

-------------------------------------------
-- TRANSFORME procedures
-------------------------------------------
----------------------
--Customer_Transform
create or replace NONEDITIONABLE PROCEDURE Customer_Transform
AS
  RowCt NUMBER(10);
  v_sql VARCHAR(255) := 'TRUNCATE TABLE Customer_Preload DROP STORAGE';
BEGIN
    EXECUTE IMMEDIATE v_sql;
    
    INSERT INTO Customer_Preload -- Insert New row
        SELECT  CustomerKey.NEXTVAL AS CustomerKey,
                cs.CustomerNum, 
                cs.CustomerFirstName||' '|| CustomerLastName,
                cs.CityName,
                cs.StateProvName,
                cs.CountryName,
                CASE 
                   WHEN cs.CustomerStatus = 1 THEN 'active'
                   ELSE 'inactive'
                END AS CustomerStatus
        FROM Customer_Stage cs
        WHERE
            NOT EXISTS ( SELECT 1 FROM DimCustomer dc
                WHERE cs.CustomerNum = dc.CustomerNum);
            
        INSERT INTO Customer_Preload 
        SELECT  CustomerKey.NEXTVAL AS CustomerKey,
                cs.CustomerNum, 
                cs.CustomerFirstName||' '|| CustomerLastName,
                cs.CityName,
                cs.StateProvName,
                cs.CountryName,
                CASE 
                   WHEN cs.CustomerStatus = 1 THEN 'active'
                   ELSE 'inactive'
                END AS CustomerStatus
        FROM Customer_Stage cs
        JOIN DimCustomer dc
            ON cs.CustomerNUM = dc.CustomerNUM 
        WHERE cs.CustomerFirstName||' '|| cs.CustomerLastName <> dc.customerfullname
              OR cs.cityname <> dc.cityname
              OR cs.StateProvName <> dc.StateProvName
              OR cs.CountryName <> dc.CountryName
              OR cs.CustomerStatus <> dc.CustomerStatus;

   RowCt := SQL%ROWCOUNT;
    dbms_output.put_line(TO_CHAR(RowCt) ||' Rows have been inserted!');

  EXCEPTION
    WHEN OTHERS THEN
       dbms_output.put_line(SQLERRM);
       dbms_output.put_line(v_sql);
       
COMMIT;
END;
/

-------------------------------------------
--Sales_Transform

create or replace NONEDITIONABLE PROCEDURE Sales_Transform
AS
  RowCt NUMBER(10);
  v_sql VARCHAR(255) := 'TRUNCATE TABLE Sales_Preload DROP STORAGE';
  StartDate DATE := SYSDATE; 
  v_EndDate DATE := SYSDATE - 1;
BEGIN
    EXECUTE IMMEDIATE v_sql;

-- Add updated rows 
    INSERT INTO Sales_Preload --Insert Products
    SELECT  SalesKey.NEXTVAL AS SalesKey,
            ST.SalesNum,
            ST.SalesName,
            ST.SalesCategory,
            ST.UnitPrice,
            ST.Supplier,
            ST.SupplierContact,
            StartDate,
            NULL
    FROM Sales_Stage ST
    JOIN DimSales DS
        ON ST.SalesNum               =   DS.SalesNum AND DS.EndDate IS NULL
    WHERE ST.SalesNum               <>  DS.SalesName
          OR ST.Supplier            <>  DS.Supplier
          OR ST.UnitPrice           <>  DS.UnitPrice;
          
   -- Add existing rows, and expire as necessary
    INSERT INTO Sales_Preload
    SELECT  DS.SalesKey,
            DS.SalesNum,
            DS.SalesName,
            DS.SalesCategory,
            DS.UnitPrice,
            DS.Supplier,
            DS.SupplierContact,
            DS.StartDate,
        CASE
            WHEN SP.SalesNum IS NULL THEN NULL
            ELSE v_EndDate
        END AS EndDate
    FROM DimSales DS
    LEFT JOIN Sales_Preload SP    
        ON SP.SalesNum = DS.SalesNum
        AND DS.EndDate IS NULL;


-- Create new records
    INSERT INTO Sales_Preload
    SELECT  SalesKey.NEXTVAL AS SalesKey,
            ST.SalesNum,
            ST.SalesName,
            ST.SalesCategory,
            ST.UnitPrice,
            ST.Supplier,
            ST.SupplierContact,
            StartDate,
            NULL
    FROM Sales_Stage ST
    WHERE NOT EXISTS ( SELECT 1 FROM DimSales DS WHERE ST.SalesNum = DS.SalesNum );
        
         
    -- Expire missing records
    INSERT INTO Sales_Preload/* Column list excluded for brevity */
    SELECT  DS.SalesKey,
            DS.SalesNum,
            DS.SalesName,
            DS.SalesCategory,
            DS.UnitPrice,
            DS.Supplier,
            DS.SupplierContact,
            DS.StartDate,
            EndDate
    FROM DimSales DS
    WHERE NOT EXISTS ( SELECT 1 FROM Sales_Stage PS WHERE PS.SalesNum = DS.SalesNum )
          AND DS.EndDate IS NULL;

   RowCt := SQL%ROWCOUNT;
    dbms_output.put_line(TO_CHAR(RowCt) ||' Rows have been inserted!');

  EXCEPTION
    WHEN OTHERS THEN
       dbms_output.put_line(SQLERRM);
       dbms_output.put_line(v_sql);
END;
/

-------------------------------------------
--Supplier_Transform
create or replace NONEDITIONABLE PROCEDURE Supplier_Transform
AS
  RowCt NUMBER(10);
  v_sql VARCHAR(255) := 'TRUNCATE TABLE Supplier_Preload DROP STORAGE';
BEGIN
    EXECUTE IMMEDIATE v_sql;
    
    INSERT INTO Supplier_Preload -- Insert New row
        SELECT  SupplierKey.NEXTVAL AS SupplierKey,
                SS.SupplierNum, 
                SS.CompanyName,
                SS.ContactName,
                SS.SupplierType,
                CASE 
                   WHEN SS.SupplierStatus = 1 THEN 'active'
                   ELSE 'inactive'
                END AS SupplierStatus
        FROM Supplier_Stage SS
        WHERE
            NOT EXISTS ( SELECT 1 FROM DimSupplier ds
                WHERE SS.SupplierNum = ds.SupplierNum);
            
        INSERT INTO Supplier_Preload 
        SELECT  SupplierKey.NEXTVAL AS SupplierKey,
                SS.SupplierNum, 
                SS.CompanyName,
                SS.ContactName,
                SS.SupplierType,
                CASE 
                   WHEN SS.SupplierStatus = 1 THEN 'active'
                   ELSE 'inactive'
                END AS SupplierStatus
        FROM Supplier_Stage SS
        JOIN DimSupplier ds
            ON SS.SupplierNUM = ds.SupplierNUM 
        WHERE SS.CompanyName <> ds.CompanyName
              OR SS.ContactName <> ds.ContactName;

   RowCt := SQL%ROWCOUNT;
    dbms_output.put_line(TO_CHAR(RowCt) ||' Rows have been inserted!');

  EXCEPTION
    WHEN OTHERS THEN
       dbms_output.put_line(SQLERRM);
       dbms_output.put_line(v_sql);
       
COMMIT;
END;
/

-------------------------------------------------
-- EXECUTE  - Transform proccedures
-------------------------------------------------
EXECUTE Customer_Transform;
EXECUTE Sales_Transform;
EXECUTE Supplier_Transform;
COMMIT;

-------------------------------------------
--Orders_Transform

create or replace NONEDITIONABLE PROCEDURE Orders_Transform
AS
    RowCt NUMBER(10);
    v_sql VARCHAR(255) := 'TRUNCATE TABLE Orders_Preload DROP STORAGE';
BEGIN
    EXECUTE IMMEDIATE v_sql;
    INSERT INTO Orders_Preload 
    SELECT DISTINCT
        cp.CustomerKey,
        sk.SalesKey,
        sp.SupplierKey,
        EXTRACT(YEAR FROM ord.OrderDate)*10000 + EXTRACT(Month FROM ord.OrderDate)*100 + EXTRACT(Day FROM ord.OrderDate),
        SUM(ord.Quantity) AS Quantity,
        trunc(AVG(ord.UnitPrice),2) AS UnitPrice,
        AVG(ord.TaxRate) AS TaxRate,
        SUM(ord.Quantity * ord.UnitPrice) AS TotalBeforeTax,
        SUM(ord.Quantity * ord.UnitPrice * (1 + ord.TaxRate/100)) AS TotalAfterTax
    FROM Orders_Stage ord         
    JOIN Customer_Preload cp
        ON ord.CustomerNum = cp.CustomerNum
    JOIN Sales_Preload sk
        ON ord.productServiceNum = sk.SalesNum
    JOIN Supplier_Preload sp
        ON ord.SupplierNum = sp.SupplierNum
    Group by ord.OrderDate ,
            cp.CustomerKey,
            sk.SalesKey,
            sp.SupplierKey;
    
    RowCt := SQL%ROWCOUNT;
    IF sql%notfound THEN
       dbms_output.put_line('No records found. Check with source system.');
    ELSIF sql%found THEN
       dbms_output.put_line(TO_CHAR(RowCt) ||' Rows have been inserted!');
    END IF;
    
    EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlerrm);
        dbms_output.put_line(v_sql);
COMMIT;
END;
/


COMMIT;

-------------------------------------------------
-- EXECUTE  - orders_Transform proccedures
-------------------------------------------------

EXECUTE orders_Transform;
COMMIT;


------------------------
--LOAD PROCEDURES
-----------------------

--DIMDATE_LOAD
create or replace NONEDITIONABLE PROCEDURE dimdate_load (
    datevalue IN DATE
) IS
BEGIN
    SAVEPOINT start_dimdate_load;
    INSERT INTO dimdate
        SELECT
            EXTRACT(YEAR FROM datevalue) * 10000 + EXTRACT(MONTH FROM datevalue) * 100 + EXTRACT(DAY FROM datevalue) datekey,
            datevalue                                                                                                datevalue,
            EXTRACT(YEAR FROM datevalue)                                                                             cyear,
            add_months(trunc(datevalue,'YYYY'),12) -trunc(datevalue,'YYYY')                                          yearspan,
            CAST(to_char(datevalue, 'Q') AS INT)                                                                     cqtr,
            (add_months(trunc(datevalue, 'Q'), 3) ) - (trunc(datevalue, 'Q'))                                        qtrspan,
            trunc(datevalue, 'Q')                                                                                    qtrstart,
            add_months(trunc(datevalue, 'Q'), 3) - 1                                                                 qtrend,
            EXTRACT(MONTH FROM datevalue)                                                                            cmonth,
            (add_months(trunc(datevalue) -(TO_NUMBER(to_char(datevalue, 'DD')) - 1), 1)) - 
            (trunc(datevalue) - ( TO_NUMBER(to_char(datevalue, 'DD')) - 1 ))                                         monthspan,
            EXTRACT(DAY FROM datevalue)                                                                              "Day",
            trunc(datevalue) - ( TO_NUMBER(to_char(datevalue, 'DD')) - 1 )                                           startofmonth,
            add_months(trunc(datevalue) -(TO_NUMBER(to_char(datevalue, 'DD')) - 1), 1) - 1                           endofmonth,
            to_char(datevalue, 'MONTH')                                                                              monthname,
            to_char(datevalue, 'DY')                                                                                 dayofweekname
        FROM
            dual;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlerrm);
        ROLLBACK TO start_dimdate_load;
        COMMIT;
END;
/


--CUSTOMER_LOAD
CREATE OR REPLACE NONEDITIONABLE PROCEDURE customer_load AS
BEGIN
    SAVEPOINT start_customer_load;
    DELETE FROM dimcustomer dc
    WHERE
        EXISTS (
            SELECT
                NULL
            FROM
                customer_preload pl
            WHERE
                dc.customerkey = pl.customerkey
        );

    INSERT INTO dimcustomer
        SELECT
            * 
        FROM
            customer_preload;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlerrm);
        ROLLBACK TO start_customer_load;
        COMMIT;
END;
/

--Sales_LOAD
CREATE OR REPLACE NONEDITIONABLE PROCEDURE Sales_load AS
BEGIN
    SAVEPOINT start_Sales_load;
    DELETE FROM dimsales dc
    WHERE
        EXISTS (
            SELECT
                NULL
            FROM
                sales_preload pl
            WHERE
                dc.saleskey = pl.saleskey
        );

    INSERT INTO dimSales
        SELECT
            * 
        FROM
            sales_preload;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlerrm);
        ROLLBACK TO start_sales_load;
        COMMIT;
END;
/


--SUPPLIER_LOAD
CREATE OR REPLACE NONEDITIONABLE PROCEDURE Supplier_load AS
BEGIN
    SAVEPOINT start_Supplier_load;
    DELETE FROM dimSupplier dc
    WHERE
        EXISTS (
            SELECT
                NULL
            FROM
                Supplier_preload pl
            WHERE
                dc.Supplierkey = pl.Supplierkey
        );

    INSERT INTO dimSupplier
        SELECT
            * 
        FROM
            Supplier_preload;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlerrm);
        ROLLBACK TO start_Supplier_load;
        COMMIT;
END;
/

--ORDERS_LOAD
create or replace NONEDITIONABLE PROCEDURE orders_load AS
BEGIN
    SAVEPOINT start_orders_load;
    INSERT INTO factsales 
        SELECT
            * 
        FROM
            orders_preload;
            
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlerrm);
        ROLLBACK TO start_orders_load;
        COMMIT;
END;
/

--------------------------------------------
-- EXECUTE the LOAD procedures 
DECLARE 
    countYear   NUMBER := 1;
    datevalue   DATE;
BEGIN
    datevalue := TO_DATE ( '2021-01-01', 'YYYY-MM-DD' );
  
    WHILE countYear <= 1095 LOOP
        
        dimdate_load(datevalue + 1);
        countYear := countYear + 1;
        datevalue := (datevalue + 1);
    END LOOP;
END;
/


EXECUTE CUSTOMER_LOAD;
EXECUTE SALES_LOAD;
EXECUTE SUPPLIER_LOAD;
COMMIT;

EXECUTE ORDERS_LOAD;
COMMIT;
