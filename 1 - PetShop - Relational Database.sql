------------------------------------------------------------------------------
--Project  - Data Warehouse Implementation
--Pet shop - Relational Database
------------------------------------------------------------------------------

------------------------------------------------------------------------------
--Create a Schema connect with system
------------------------------------------------------------------------------
--ALTER SESSION SET "_ORACLE_SCRIPT" = true;

--CREATE USER petshopdb identified by petshopdb;

--GRANT ALL PRIVILEGES TO petshopdb;

--SELECT * FROM all_users ORDER BY Created DESC;


------------------------------------------------------------------------------
--Work on petshopDB - connect with petshopdb 
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--DROP tables and sequences
------------------------------------------------------------------------------
--DROP TABLE serviceOrderDetail;
--DROP TABLE productOrderDetail;
--DROP TABLE service;
--DROP TABLE product;
--DROP TABLE suppliers;
--DROP TABLE pet;
--DROP TABLE gender;
--DROP TABLE category;
--DROP TABLE Type;
--DROP TABLE productCategory;
--DROP TABLE ORDERS;
--DROP TABLE customer;
--
--DROP SEQUENCE customerID;
--DROP SEQUENCE orderID;
--DROP SEQUENCE productOrderDetailID;
--DROP SEQUENCE serviceOrderDetailID;
--DROP SEQUENCE TypeID;
--DROP SEQUENCE petID;
--DROP SEQUENCE categoryID;
--DROP SEQUENCE genderID;
--DROP SEQUENCE productID;
--DROP SEQUENCE productCategoryID;
--DROP SEQUENCE serviceID;
--DROP SEQUENCE supplierID;
--
--COMMIT;
------------------------------------------------------------------------------
--Create tables
------------------------------------------------------------------------------
-----------------------------------
-- Table CUSTOMER
-----------------------------------
CREATE TABLE CUSTOMER (
    customerID          NUMBER(10)      NOT NULL,
    customerCod         NVARCHAR2(10)   NOT NULL,
    customerFirstName   NVARCHAR2(30)   NOT NULL,
    customerLastName    NVARCHAR2(30)   NOT NULL,
    emailAddress        NVARCHAR2(50)   NOT NULL,
    contactNumber       NVARCHAR2(15)   NOT NULL,
    Address             NVARCHAR2(60)   NOT NULL,
    City                NVARCHAR2(30)   NOT NULL,
    Province            NVARCHAR2(30)   NOT NULL,
    Country             NVARCHAR2(30)   NOT NULL,
    status              NUMBER(1)       NOT NULL,
    CONSTRAINT PK_customer_ID PRIMARY KEY (customerID),
    CONSTRAINT UQ_customer_customerCod UNIQUE (customerCod)
) ;

-----------------------------------
-- Table ORDERS
-----------------------------------
CREATE TABLE orders (
  orderID               NUMBER(10)      NOT NULL,
  customerID            NUMBER(10)      NOT NULL,
  orderDate             DATE            NOT NULL,
  orderType             NUMBER(1)       NOT NULL,
  expectedDeliveryDate  DATE            NOT NULL,
  totalAmount           NUMBER(10,2)    NULL,
  numberOfItems         NUMBER(5)       NULL,
  CONSTRAINT PK_order_ID            PRIMARY KEY (orderID),
  CONSTRAINT FK_orders_customerID  FOREIGN KEY (customerID)  REFERENCES customer (customerID)
) ;

-----------------------------------
-- Table PRODUCTCATEGORY
-----------------------------------
CREATE TABLE PRODUCTCATEGORY (
  productCategoryID         NUMBER(10)      NOT NULL,
  categoryName              NVARCHAR2(30)   NOT NULL,
  CONSTRAINT PK_productCategory_ID              PRIMARY KEY (productCategoryID),
  CONSTRAINT UQ_productCategory_categoryName    UNIQUE (categoryName)
);

-----------------------------------
-- Table TYPE
-----------------------------------
CREATE TABLE TYPE (
  TypeID       NUMBER(10)       NOT NULL,
  TypeName     NVARCHAR2(20)    NOT NULL,
  CONSTRAINT PK_Type_ID PRIMARY KEY (TypeID),
  CONSTRAINT UQ_Type_TypeName     UNIQUE (TypeName)
);

-----------------------------------
-- Table CATEGORY
-----------------------------------
CREATE TABLE CATEGORY (
  categoryID        NUMBER(10)      NOT NULL,
  categoryName      NVARCHAR2(30)   NOT NULL,
  CONSTRAINT PK_category_ID                  PRIMARY KEY (categoryID),
  CONSTRAINT UQ_petcategory_categoryName        UNIQUE (categoryName)
);

-----------------------------------
-- Table GENDER
-----------------------------------
CREATE TABLE GENDER (
  genderID          NUMBER(10)      NOT NULL,
  genderName       NVARCHAR2(30)   NOT NULL,
  CONSTRAINT PK_gender_ID PRIMARY KEY (genderID),
  CONSTRAINT UQ_gender_genderyName    UNIQUE (genderName)
);

-----------------------------------
-- Table PET
-----------------------------------

CREATE TABLE PET (
  petID             NUMBER(10)      NOT NULL,
  petName           NVARCHAR2(50)   NOT NULL,
  petBreed          NVARCHAR2(50)   NOT NULL,
  GenderID          NUMBER(10)      NOT NULL,
  petStatus         NUMBER(1)       NOT NULL,
  birthDate         DATE            NOT NULL,
  categoryID        NUMBER(10)      NOT NULL,
  customerID        NUMBER(10)      NOT NULL,
  CONSTRAINT PK_pet_ID PRIMARY KEY (petID),
  CONSTRAINT FK_pet_GenderID            FOREIGN KEY (GenderID)      REFERENCES Gender (GenderID),  
  CONSTRAINT FK_pet_categoryID       FOREIGN KEY (categoryID)    REFERENCES category (categoryID),
  CONSTRAINT FK_pet_customerID          FOREIGN KEY (customerID)    REFERENCES customer (customerID),
  CONSTRAINT UQ_pet_PetNamexCustomer    UNIQUE (petName, customerID)
);

-----------------------------------
-- Table SUPPLIERS
-----------------------------------
CREATE TABLE SUPPLIERS (
  supplierID                NUMBER(10)      NOT NULL,
  supplierCOD               NVARCHAR2(10)   NOT NULL,  
  supplierName              NVARCHAR2(50)   NOT NULL,
  supplierContactPerson     NVARCHAR2(30)   NOT NULL,
  supplierEmail             NVARCHAR2(40)   NOT NULL,
  supplierContact_number    NVARCHAR2(15)   NOT NULL,
  supplierWebsite           NVARCHAR2(30)   NOT NULL,
  TypeID                    NUMBER(1)       NOT NULL,
  supplierStatus            NUMBER(1)       NOT NULL,
  CONSTRAINT PK_suppliers_ID             PRIMARY KEY (supplierID),
  CONSTRAINT FK_suppliers_TypeID         FOREIGN KEY (TypeID)    REFERENCES Type (TypeID), 
  CONSTRAINT UQ_suppliers_supplierCOD    UNIQUE (supplierCOD)
);

-----------------------------------
-- Table PRODUCT
-----------------------------------
CREATE TABLE PRODUCT (
  productID             NUMBER(10)          NOT NULL,
  productCOD            NVARCHAR2(30)       NOT NULL,
  productName           NVARCHAR2(50)       NOT NULL,
  productDetail         NVARCHAR2(200)      NOT NULL,
  productCategoryID     NUMBER(10)          NOT NULL,
  quantityOnHand        NUMBER(5)           NOT NULL,
  suppliersPrice        NUMBER(10,2)        NOT NULL,
  retailPrice           NUMBER(10,2)        NOT NULL,
  discount              NUMBER(10,2)        NOT NULL,
  supplierID            NUMBER(10)          NOT NULL,
  productStatus         NUMBER(1)           NOT NULL,
  CONSTRAINT PK_product_ID                      PRIMARY KEY (productID),
  CONSTRAINT FK_product_productCategoryID       FOREIGN KEY (productCategoryID)   REFERENCES productCategory (productCategoryID),
  CONSTRAINT FK_product_supplierID              FOREIGN KEY (supplierID)          REFERENCES suppliers (supplierID),
  CONSTRAINT UQ_product_productCOD              UNIQUE (productCOD)  
);

-----------------------------------
-- Table SERVICE
-----------------------------------
CREATE TABLE SERVICE (
  serviceID             NUMBER(10)          NOT NULL,
  serviceCOD            NVARCHAR2(30)       NOT NULL,  
  serviceName           NVARCHAR2(30)       NOT NULL,
  serviceDetail         NVARCHAR2(200)      NOT NULL,
  productCategoryID     NUMBER(10)          NOT NULL,
  serviceFee            NUMBER(10,2)        NOT NULL,
  supplierID            NUMBER(10)          NOT NULL,
  CONSTRAINT PK_service_ID PRIMARY KEY (serviceID),
  CONSTRAINT FK_service_productCategoryID       FOREIGN KEY (productCategoryID)   REFERENCES productCategory (productCategoryID),
  CONSTRAINT FK_service_supplierID              FOREIGN KEY (supplierID)          REFERENCES suppliers (supplierID),
  CONSTRAINT UQ_service_serviceCOD              UNIQUE (serviceCOD)    
);

-----------------------------------
-- Table PRODUCTORDERDETAIL
-----------------------------------
CREATE TABLE PRODUCTORDERDETAIL (
  productOrderDetailID      NUMBER(10)      NOT NULL,
  orderID                   NUMBER(10)      NOT NULL,
  productID                 NUMBER(10)      NOT NULL,
  prodQuantity              NUMBER(5)       NOT NULL,
  prodPrice                 NUMBER(10,2)    NOT NULL,
  productTotal              NUMBER(10,2)    NOT NULL,
  taxRate                   NUMBER(10,2)    NOT NULL,
  CONSTRAINT PK_productOrderDetail_ID           PRIMARY KEY (productOrderDetailID),
  CONSTRAINT FK_productOrderDetail_orderID      FOREIGN KEY (orderID)   REFERENCES orders(orderID),
  CONSTRAINT FK_productOrderDetail_productID    FOREIGN KEY (productID) REFERENCES product(productID)
);

-----------------------------------
-- Table SERVICEORDERDETAIL
-----------------------------------
CREATE TABLE SERVICEORDERDETAIL (
  serviceOrderDetailID      NUMBER(10)      NOT NULL,
  orderID                   NUMBER(10)      NOT NULL,
  serviceID                 NUMBER(10)      NOT NULL,
  serviceQuantity           NUMBER(5)       NOT NULL,
  servicePrice              NUMBER(10,2)    NOT NULL,
  serviceTotal              NUMBER(10,2)    NOT NULL,
  taxRate                   NUMBER(10,2)    NOT NULL,  
  CONSTRAINT PK_serviceOrderDetail_ID           PRIMARY KEY (serviceOrderDetailID),
  CONSTRAINT FK_serviceOrderDetail_orderID      FOREIGN KEY (orderID)   REFERENCES orders(orderID),
  CONSTRAINT FK_serviceOrderDetail_serviceID    FOREIGN KEY (serviceID) REFERENCES service(serviceID)
);

------------------------------------------------------------------------------
-- INDEXES 
------------------------------------------------------------------------------
-----------------------------------
-- Indexes for table ORDERS
-----------------------------------
CREATE    INDEX    IX_orders_customerID	    ON orders(customerID);

-----------------------------------
-- Indexes for table PET
-----------------------------------
CREATE    INDEX    IX_pet_genderID	        ON pet(genderID);
CREATE    INDEX    IX_pet_categoryID	    ON pet(categoryID);
CREATE    INDEX    IX_pet_customerID	    ON pet(customerID);

-----------------------------------
-- Indexes for table SUPPLIERS
-----------------------------------
CREATE    INDEX    IX_suppliers_TypeID	    ON suppliers(TypeID);

-----------------------------------
-- Indexes for table PRODUCT
-----------------------------------
CREATE    INDEX    IX_product_productCategoryID	    ON product(productCategoryID);
CREATE    INDEX    IX_product_supplierID	        ON product(supplierID);

-----------------------------------
-- Indexes for table PRODUCTORDERDETAIL
-----------------------------------
CREATE    INDEX    IX_productOrderDetail_orderID	        ON productOrderDetail(orderID);
CREATE    INDEX    IX_productOrderDetail_productID          ON productOrderDetail(productID);

-----------------------------------
-- Indexes for table SERVICEDETAIL
-----------------------------------
CREATE    INDEX    IX_serviceOrderDetail_orderID	        ON serviceOrderDetail(orderID);
CREATE    INDEX    IX_serviceOrderDetail_serviceID          ON serviceOrderDetail(serviceID );


------------------------------------------------------------------------------
-- Create SEQUENCES
------------------------------------------------------------------------------
CREATE SEQUENCE customerID START WITH 1;
CREATE SEQUENCE orderID START WITH 1;
CREATE SEQUENCE productOrderDetailID START WITH 1;
CREATE SEQUENCE serviceOrderDetailID START WITH 1;
CREATE SEQUENCE TypeID START WITH 1;
CREATE SEQUENCE petID START WITH 1;
CREATE SEQUENCE categoryID START WITH 1;
CREATE SEQUENCE genderID START WITH 1;
CREATE SEQUENCE productID START WITH 1;
CREATE SEQUENCE productCategoryID START WITH 1;
CREATE SEQUENCE serviceID START WITH 1;
CREATE SEQUENCE supplierID START WITH 1;


------------------------------------------------------------------------------
-- INSERTS
------------------------------------------------------------------------------
-----------------------------------
-- Inserts - table CUSTOMER
-----------------------------------
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00001'	,	'Christophe-William'	,	'Charpentier'	,	'Christophe-WilliamCharpentier@gmail.com'	,	'0607 297 4017'	,	'94 WAREHOUSE LN'	,	'Belcher'	,	'Kentucky'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00002'	,	'Mathilde-Michelle'	,	'Vidal'	,	'Mathilde-MichelleVidal@gmail.com'	,	'039784-284 1-23'	,	'11 S CAMPUS DR'	,	'Grace'	,	'Idaho'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00003'	,	'Eleonore-Marcelle'	,	'Riou'	,	'Eleonore-MarcelleRiou@gmail.com'	,	'02354923 76-8'	,	'2802 GOVERNMENT ST'	,	'Marshallton'	,	'Delaware'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00004'	,	'Marguerite-Paulette'	,	'Pereira'	,	'Marguerite-PaulettePereira@gmail.com'	,	'743-157004'	,	'330 N 4TH ST'	,	'Clear Creek'	,	'Utah'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00005'	,	'Iolanda'	,	'Bertolucci-Surian'	,	'IolandaBertolucci-Surian@gmail.com'	,	'0059678369-58'	,	'39 FORESTRY LN'	,	'Aragon'	,	'Georgia'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00006'	,	'Timothee-Gilbert'	,	'Vallee'	,	'Timothee-GilbertVallee@gmail.com'	,	'0910-03229 30'	,	'6401 CAMEREN OAKS DR'	,	'Colfax'	,	'Illinois'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00007'	,	'Sylvie-Caroline'	,	'Roussel'	,	'Sylvie-CarolineRoussel@gmail.com'	,	'0218-258-03-28'	,	'4250 BLOUNT RD, UNIT 15'	,	'Arundel Village'	,	'Maryland'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00008'	,	'Celine'	,	'Langlois-Wagner'	,	'CelineLanglois-Wagner@gmail.com'	,	'0356-835 0340'	,	'15716 FAWN RIDGE AVE'	,	'Belcher'	,	'Kentucky'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00009'	,	'Francois'	,	'Huet-Courtois'	,	'FrancoisHuet-Courtois@gmail.com'	,	'020-76896 69'	,	'6700-6800 S TIGER BEND RD'	,	'Baker'	,	'California'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00010'	,	'Griselda'	,	'Anguillara-Fabbri'	,	'GriseldaAnguillara-Fabbri@gmail.com'	,	'0856-194-24-57'	,	'9007 HIGHLAND RD, STE 31'	,	'Grizzly'	,	'Oregon'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00011'	,	'Francoise'	,	'Fournier-Baudry'	,	'FrancoiseFournier-Baudry@gmail.com'	,	'035642-28163-93'	,	'217 E CAMPUS DR'	,	'Buckeye'	,	'Colorado'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00012'	,	'Catherine'	,	'Richard-Monnier'	,	'CatherineRichard-Monnier@gmail.com'	,	'0235-97 97 57'	,	'501 S QUAD DR'	,	'Colfax'	,	'Illinois'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00013'	,	'Edouard'	,	'Paul-Blanchard'	,	'EdouardPaul-Blanchard@gmail.com'	,	'06712639-89'	,	'17629 FIVE OAKS DR'	,	'Bertrand'	,	'Michigan'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00014'	,	'Benjamin'	,	'Leclercq-Denis'	,	'BenjaminLeclercq-Denis@gmail.com'	,	'0147 40-4290'	,	'14305 GRAND SETTLEMENT BLVD'	,	'Fulton'	,	'South Dakota'	,	'United States'	,	0	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00015'	,	'Renee'	,	'Charpentier-Ruiz'	,	'ReneeCharpentier-Ruiz@gmail.com'	,	'951-83525'	,	'15044 LILY AVE'	,	'Barrington'	,	'New Jersey'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00016'	,	'Tristan'	,	'Boulay-Bourdon'	,	'TristanBoulay-Bourdon@gmail.com'	,	'154-652103'	,	'177 N GREEK ROW LOT'	,	'Derry'	,	'New Hampshire'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00017'	,	'Michele'	,	'Bonneau-Rousseau'	,	'MicheleBonneau-Rousseau@gmail.com'	,	'008-564-51 31'	,	'10418 SAVANNAH JANE LN'	,	'Grace'	,	'Idaho'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00018'	,	'Celine-Julie'	,	'Thibault'	,	'Celine-JulieThibault@gmail.com'	,	'054 1534 08'	,	'3038 NORTH ST, STE A'	,	'Derry'	,	'New Hampshire'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00019'	,	'Stephane'	,	'Lambert-Paris'	,	'StephaneLambert-Paris@gmail.com'	,	'075183-81-5197'	,	'6019 BYRON ST'	,	'Bertrand'	,	'Michigan'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00020'	,	'Madeleine-Christine'	,	'Chretien'	,	'Madeleine-ChristineChretien@gmail.com'	,	'0305508 0419'	,	'373 TOWER DR'	,	'Bagdad'	,	'Arizona'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00021'	,	'Constance'	,	'Breton-Descamps'	,	'ConstanceBreton-Descamps@gmail.com'	,	'302-504768'	,	'16431 VILLA BRIELLE AVE'	,	'Derry'	,	'New Hampshire'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00022'	,	'Thibault-Martin'	,	'Lagarde'	,	'Thibault-MartinLagarde@gmail.com'	,	'04352-82 857'	,	'22865 SHELLMIRE LN'	,	'Aragon'	,	'Georgia'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00023'	,	'Annunziata'	,	'Roccabonella'	,	'AnnunziataRoccabonella@gmail.com'	,	'0230 678 48-75'	,	'25 REILLY THEATER LOT'	,	'Arrey'	,	'New Mexico'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00024'	,	'Puccio'	,	'Sonnino-Branciforte'	,	'PuccioSonnino-Branciforte@gmail.com'	,	'00832-30585 85'	,	'110 VETERANS DR'	,	'Buckeye'	,	'Colorado'	,	'United States'	,	0	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00025'	,	'Alfredo'	,	'Vespa-Mercantini'	,	'AlfredoVespa-Mercantini@gmail.com'	,	'013576 54965 54'	,	'1675 N 27TH ST'	,	'Grizzly'	,	'Oregon'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00026'	,	'Vanessa'	,	'Peruzzi-Avogadro'	,	'VanessaPeruzzi-Avogadro@gmail.com'	,	'004 594 0170'	,	'12333 JEFFERSON HWY, STE F'	,	'Forest Center'	,	'Minnesota'	,	'United States'	,	0	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00027'	,	'Laureano'	,	'Cristoforetti'	,	'LaureanoCristoforetti@gmail.com'	,	'019-260 90-26'	,	'4250 BLOUNT RD, UNIT 82'	,	'Hilo'	,	'Hawaii'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00028'	,	'Margaret'	,	'Olivier-Grondin'	,	'MargaretOlivier-Grondin@gmail.com'	,	'03482 839 43-51'	,	'204 S STADIUM DR'	,	'Arrey'	,	'New Mexico'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00029'	,	'Paulette'	,	'Chevalier-Gilbert'	,	'PauletteChevalier-Gilbert@gmail.com'	,	'00217 815 8 52'	,	'7414 BOARD DR'	,	'Chaseley'	,	'North Dakota'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00030'	,	'Suzanne'	,	'Vidal-Barthelemy'	,	'SuzanneVidal-Barthelemy@gmail.com'	,	'014950 81-28'	,	'7863 BURDEN LN'	,	'Chaseley'	,	'North Dakota'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00031'	,	'Manon-Simone'	,	'Deschamps'	,	'Manon-SimoneDeschamps@gmail.com'	,	'0078 59-70 93'	,	'13668 HARVESTON WAY'	,	'Enfield'	,	'Connecticut'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00032'	,	'Philippine-Therese'	,	'Durand'	,	'Philippine-ThereseDurand@gmail.com'	,	'0142 15-0105'	,	'3660 DELAWARE ST'	,	'Ira'	,	'Vermont'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00033'	,	'Aurelie'	,	'Vidal-Barthelemy'	,	'AurelieVidal-Barthelemy@gmail.com'	,	'054 457596'	,	'11745 BRICKSOME AVE, STE A3'	,	'Bagdad'	,	'Arizona'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00034'	,	'Frederique'	,	'Potier-Guillot'	,	'FrederiquePotier-Guillot@gmail.com'	,	'0270452-1361'	,	'267 S STADIUM DR'	,	'Bagdad'	,	'Arizona'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00035'	,	'Claire-Alexandria'	,	'Hoarau'	,	'Claire-AlexandriaHoarau@gmail.com'	,	'021365-7372'	,	'7536 BURDEN LN'	,	'Chaseley'	,	'North Dakota'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00036'	,	'Martine'	,	'Wagner-Mathieu'	,	'MartineWagner-Mathieu@gmail.com'	,	'0856 98310 63'	,	'708 S STADIUM DR'	,	'Baker'	,	'California'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00037'	,	'Franck'	,	'Legros-Maillet'	,	'FranckLegros-Maillet@gmail.com'	,	'087693 275 89'	,	'4250 BLOUNT RD, UNIT 11'	,	'Charlotte Amalie'	,	'Virgin Islands (US Territory)'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00038'	,	'Clelia'	,	'Brunello-Gentilini'	,	'CleliaBrunello-Gentilini@gmail.com'	,	'04981096298 28'	,	'18622 SANCTUARY AVE'	,	'Kittrell'	,	'North Carolina'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00039'	,	'Patrick'	,	'Vaillant-Nicolas'	,	'PatrickVaillant-Nicolas@gmail.com'	,	'032 57 06-28'	,	'4625 PARKOAKS DR, STE 30'	,	'Ira'	,	'Vermont'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00040'	,	'Benoit'	,	'Teixeira-Buisson'	,	'BenoitTeixeira-Buisson@gmail.com'	,	'034587178 61'	,	'9564 FLORIDA BLVD, STE C'	,	'Flats'	,	'Nebraska'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00041'	,	'Chantal-Constance'	,	'Masse'	,	'Chantal-ConstanceMasse@gmail.com'	,	'002564-952-91-8'	,	'148 W STADIUM DR'	,	'Aragon'	,	'Georgia'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00042'	,	'Penelope'	,	'Girard-Pichon'	,	'PenelopeGirard-Pichon@gmail.com'	,	'0874219 917'	,	'5420 CORPORATE BLVD, STE 204'	,	'Missoula'	,	'Montana'	,	'United States'	,	0	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00043'	,	'Romina'	,	'Murialdo-Cianciolo'	,	'RominaMurialdo-Cianciolo@gmail.com'	,	'08095-98-1 2'	,	'182 POWERHOUSE LN'	,	'Carolina'	,	'Rhode Island'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00044'	,	'Matilda'	,	'Golino-Liverotti'	,	'MatildaGolino-Liverotti@gmail.com'	,	'068204-1479104'	,	'223 S CAMPUS DR'	,	'Missoula'	,	'Montana'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00045'	,	'Benjamin'	,	'Arnaud-Picard'	,	'BenjaminArnaud-Picard@gmail.com'	,	'0847 745 83 06'	,	'2288 GOURRIER AVE'	,	'Carolina'	,	'Rhode Island'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00046'	,	'Matthieu'	,	'Marechal-Hernandez'	,	'MatthieuMarechal-Hernandez@gmail.com'	,	'005231-0256 31'	,	'6251 PERKINS RD, STE C'	,	'Belcher'	,	'Kentucky'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00047'	,	'Corrado'	,	'Agnesi-Morgagni'	,	'CorradoAgnesi-Morgagni@gmail.com'	,	'068-32-20 4'	,	'22812 HOO SHOO TOO RD'	,	'Burlington'	,	'Maine'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00048'	,	'Augustin'	,	'Legendre-Chauveau'	,	'AugustinLegendre-Chauveau@gmail.com'	,	'084259 129-34-5'	,	'48 LAB SCHOOL SERVICE LOT'	,	'Arthur'	,	'Nevada'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00049'	,	'Renee-Madeleine'	,	'Muller'	,	'Renee-MadeleineMuller@gmail.com'	,	'06437-80 2'	,	'5233 WASHINGTON AVE'	,	'Amchitka'	,	'Alaska'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00050'	,	'Loretta'	,	'Paoletti-Filzi'	,	'LorettaPaoletti-Filzi@gmail.com'	,	'0518419 41'	,	'138 O  T RD'	,	'Ira'	,	'Vermont'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00051'	,	'Daniele'	,	'Ceri-Pascarella'	,	'DanieleCeri-Pascarella@gmail.com'	,	'064984 48-58'	,	'99 FORESTRY LN'	,	'Enfield'	,	'Connecticut'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00052'	,	'Jacqueline'	,	'Ledoux-Guilbert'	,	'JacquelineLedoux-Guilbert@gmail.com'	,	'058 87-5616'	,	'3231 CALUMET ST'	,	'Baker'	,	'California'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00053'	,	'Gemma'	,	'Sabbatini-Piovani'	,	'GemmaSabbatini-Piovani@gmail.com'	,	'087179682 75'	,	'238 ASTER ST'	,	'Arrey'	,	'New Mexico'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00054'	,	'Dorothee-Audrey'	,	'Peltier'	,	'Dorothee-AudreyPeltier@gmail.com'	,	'050872-68 20'	,	'18844 SANCTUARY AVE'	,	'Argyle'	,	'Texas'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00055'	,	'Annunziata'	,	'Bruscantini-Cilibrasi'	,	'AnnunziataBruscantini-Cilibrasi@gmail.com'	,	'07316816 89 19'	,	'14635 S HARRELLS FERRY RD, STE 2B'	,	'Dalmatia'	,	'Pennsylvania'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00056'	,	'Elise-Marguerite'	,	'Morin'	,	'Elise-MargueriteMorin@gmail.com'	,	'01265 146 78 97'	,	'5816 EASTWOOD DR'	,	'Carolina'	,	'Rhode Island'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00057'	,	'Ornella'	,	'Malenchini-Bazzi'	,	'OrnellaMalenchini-Bazzi@gmail.com'	,	'054261162-9376'	,	'506 TOWER DR'	,	'Charlotte Amalie'	,	'Virgin Islands (US Territory)'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00058'	,	'Gilbert'	,	'Dupuis-Lebreton'	,	'GilbertDupuis-Lebreton@gmail.com'	,	'0783-86575 9'	,	'4401 DALRYMPLE DR'	,	'Carolina'	,	'Rhode Island'	,	'United States'	,	0	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00059'	,	'Ermenegildo'	,	'Mercantini'	,	'ErmenegildoMercantini@gmail.com'	,	'0350516 2-0'	,	'4347 HIGH ST, STE 107'	,	'Chadwick'	,	'Missouri'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00060'	,	'Lucas'	,	'Navarro-Bourgeois'	,	'LucasNavarro-Bourgeois@gmail.com'	,	'0276-736-95-59'	,	'227 E CAMPUS DR'	,	'Amchitka'	,	'Alaska'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00061'	,	'Laurent'	,	'Deschamps-Gomez'	,	'LaurentDeschamps-Gomez@gmail.com'	,	'059 469-0-43'	,	'17739 GLEN FOREST AVE'	,	'Hilo'	,	'Hawaii'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00062'	,	'Mathilde'	,	'Poulain-Delmas'	,	'MathildePoulain-Delmas@gmail.com'	,	'02487-2967543'	,	'14141 AIRLINE HWY, STE 3U'	,	'Burlington'	,	'Maine'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00063'	,	'Emmanuel'	,	'Verdier-Bourdon'	,	'EmmanuelVerdier-Bourdon@gmail.com'	,	'070316-46968 59'	,	'4920 PRESCOTT RD'	,	'Garnett'	,	'Kansas'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00064'	,	'Riccardo'	,	'Folliero-Spinelli'	,	'RiccardoFolliero-Spinelli@gmail.com'	,	'04103 41-9198'	,	'619 SCAUP ST'	,	'Arthur'	,	'Nevada'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00065'	,	'Suzanne-Aurelie'	,	'Bonneau'	,	'Suzanne-AurelieBonneau@gmail.com'	,	'078-327 10-4'	,	'511 S STADIUM DR'	,	'Carolina'	,	'Rhode Island'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00066'	,	'Sophie-Patricia'	,	'Bourgeois'	,	'Sophie-PatriciaBourgeois@gmail.com'	,	'034-91249 21'	,	'3405 MADISON AVE'	,	'Forest Center'	,	'Minnesota'	,	'United States'	,	0	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00067'	,	'Simone-Constance'	,	'Verdier'	,	'Simone-ConstanceVerdier@gmail.com'	,	'04163032 17 45'	,	'4250 BLOUNT RD, UNIT 99'	,	'Cascade'	,	'Iowa'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00068'	,	'Alexandria-Virginie'	,	'Morel'	,	'Alexandria-VirginieMorel@gmail.com'	,	'0382 213 93 3'	,	'10107 AVENUE I'	,	'Carolina'	,	'Rhode Island'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00069'	,	'Ubaldo'	,	'Morgagni-Galeati'	,	'UbaldoMorgagni-Galeati@gmail.com'	,	'0705-670-9471'	,	'9945 AIRLINE HWY, STE E'	,	'Chaseley'	,	'North Dakota'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00070'	,	'Christine-Henriette'	,	'Begue'	,	'Christine-HenrietteBegue@gmail.com'	,	'020457189-4'	,	'4048 LYNN ST'	,	'Chase'	,	'Alabama'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00071'	,	'Adrienne'	,	'Evrard-Robert'	,	'AdrienneEvrard-Robert@gmail.com'	,	'0543-1889'	,	'18517 SANCTUARY AVE'	,	'Ira'	,	'Vermont'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00072'	,	'Gianmarco'	,	'Barbarigo-Zamengo'	,	'GianmarcoBarbarigo-Zamengo@gmail.com'	,	'07542-6763-47'	,	'17405 CULPS BLUFF AVE'	,	'Minor Hill'	,	'Tennessee'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00073'	,	'Amico'	,	'Savorgnan-Guidone'	,	'AmicoSavorgnan-Guidone@gmail.com'	,	'012 805-634'	,	'5 FREY LOT'	,	'Washington'	,	'District of Columbia'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00074'	,	'Antoinette'	,	'David-Allain'	,	'AntoinetteDavid-Allain@gmail.com'	,	'0167630-41-27'	,	'419 ATHLETIC SERVICE LN'	,	'Baker'	,	'California'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00075'	,	'Thierry-Philippe'	,	'Potier'	,	'Thierry-PhilippePotier@gmail.com'	,	'002-78618 80'	,	'276 CONFERENCE CENTER LN'	,	'Derry'	,	'New Hampshire'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00076'	,	'Paola'	,	'Falcone-Buscetta'	,	'PaolaFalcone-Buscetta@gmail.com'	,	'04180 536 814'	,	'4250 BLOUNT RD, UNIT 59'	,	'Grizzly'	,	'Oregon'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00077'	,	'Benjamin-Zacharie'	,	'Carlier'	,	'Benjamin-ZacharieCarlier@gmail.com'	,	'0968 651 91 85'	,	'4250 BLOUNT RD, UNIT 14'	,	'Cascade'	,	'Iowa'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00078'	,	'Stephanie-Monique'	,	'Launay'	,	'Stephanie-MoniqueLaunay@gmail.com'	,	'089-86768-32'	,	'254 S STADIUM DR'	,	'Evelyn'	,	'Louisiana'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00079'	,	'Emmanuel'	,	'Ferrand-Allard'	,	'EmmanuelFerrand-Allard@gmail.com'	,	'0958065-7867'	,	'3341 ALASKA ST'	,	'Forest Center'	,	'Minnesota'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00080'	,	'Gregoire-William'	,	'Riou'	,	'Gregoire-WilliamRiou@gmail.com'	,	'0170-037-07 64'	,	'1926 VILLE MARIE ST'	,	'Barrington'	,	'New Jersey'	,	'United States'	,	0	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00081'	,	'Lorraine'	,	'Laporte-Bruneau'	,	'LorraineLaporte-Bruneau@gmail.com'	,	'0324 548 86-25'	,	'7522 ASSOCIATE DR'	,	'Hilo'	,	'Hawaii'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00082'	,	'Philippe-Raymond'	,	'Rodriguez'	,	'Philippe-RaymondRodriguez@gmail.com'	,	'067512 50849 16'	,	'3930 W LAKESHORE DR'	,	'Bryant'	,	'Indiana'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00083'	,	'Genevieve'	,	'Bernier-Tanguy'	,	'GenevieveBernier-Tanguy@gmail.com'	,	'003502-92-56'	,	'538 LIVE OAK BLVD'	,	'Grizzly'	,	'Oregon'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00084'	,	'Aurelie-Margaret'	,	'Valentin'	,	'Aurelie-MargaretValentin@gmail.com'	,	'345-13540120'	,	'4568 DALRYMPLE DR'	,	'Colfax'	,	'Illinois'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00085'	,	'Emmanuel-Paul'	,	'Rodrigues'	,	'Emmanuel-PaulRodrigues@gmail.com'	,	'07925-9010716'	,	'525 ROSELAWN AVE'	,	'Housatonic'	,	'Massachusetts[E]'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00086'	,	'Antoinette'	,	'Delmas-Poirier'	,	'AntoinetteDelmas-Poirier@gmail.com'	,	'0736-936-3950'	,	'258 W STADIUM DR'	,	'Kittrell'	,	'North Carolina'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00087'	,	'Margot'	,	'Garnier-Couturier'	,	'MargotGarnier-Couturier@gmail.com'	,	'0096495-73-85'	,	'3936 N BARROW DR'	,	'Comanche'	,	'Oklahoma'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00088'	,	'Dominique'	,	'Regnier-Chartier'	,	'DominiqueRegnier-Chartier@gmail.com'	,	'0394-0650 96'	,	'4250 BLOUNT RD, UNIT 65'	,	'Missoula'	,	'Montana'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00089'	,	'Margaret-Marie'	,	'Guillaume'	,	'Margaret-MarieGuillaume@gmail.com'	,	'028396-81639 15'	,	'186 V.J. BELLA DR'	,	'Missoula'	,	'Montana'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00090'	,	'Theodore-Zacharie'	,	'Michaud'	,	'Theodore-ZacharieMichaud@gmail.com'	,	'062 852-09'	,	'484 FIELD HOUSE DR'	,	'Dalmatia'	,	'Pennsylvania'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00091'	,	'Charlotte'	,	'Fleury-Leveque'	,	'CharlotteFleury-Leveque@gmail.com'	,	'064-79-87-17'	,	'14345 GRAND SETTLEMENT BLVD'	,	'Downsville'	,	'New York'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00092'	,	'Jacqueline'	,	'Jacquot-Laine'	,	'JacquelineJacquot-Laine@gmail.com'	,	'003-9802628'	,	'18843 SANCTUARY AVE'	,	'Dillon'	,	'South Carolina'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00093'	,	'Emmanuel-Alfred'	,	'Diallo'	,	'Emmanuel-AlfredDiallo@gmail.com'	,	'043 14 3059'	,	'140 CUBS CIR'	,	'Grace'	,	'Idaho'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00094'	,	'Benjamin'	,	'Rousset-Hardy'	,	'BenjaminRousset-Hardy@gmail.com'	,	'02946-03570 05'	,	'5024 PRESCOTT RD'	,	'Ira'	,	'Vermont'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00095'	,	'Margot'	,	'Alexandre-Pineau'	,	'MargotAlexandre-Pineau@gmail.com'	,	'072950 07-32'	,	'13717 BROWN RD'	,	'Grace'	,	'Idaho'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00096'	,	'Gregoire'	,	'Martineau-Guillaume'	,	'GregoireMartineau-Guillaume@gmail.com'	,	'0685342-89'	,	'319 SPRUCE LN'	,	'Kittrell'	,	'North Carolina'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00097'	,	'Raymond'	,	'Pottier-Briand'	,	'RaymondPottier-Briand@gmail.com'	,	'03691-981-39-65'	,	'3850 NICHOLSON DR'	,	'Meadville'	,	'Mississippi'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00098'	,	'Vincent-Laurent'	,	'Meunier'	,	'Vincent-LaurentMeunier@gmail.com'	,	'01421-03 32'	,	'184 E CAMPUS DR'	,	'Kittrell'	,	'North Carolina'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00099'	,	'Tristan'	,	'Gilles-Bouchet'	,	'TristanGilles-Bouchet@gmail.com'	,	'06159 086 392'	,	'17137 WAX RD, STE G'	,	'Marshallton'	,	'Delaware'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00100'	,	'Daniel'	,	'Gomez-Deschamps'	,	'DanielGomez-Deschamps@gmail.com'	,	'078 485-9-04'	,	'4250 BLOUNT RD, UNIT 31'	,	'Enfield'	,	'Connecticut'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00101'	,	'Francoise-Arnaude'	,	'Gautier'	,	'Francoise-ArnaudeGautier@gmail.com'	,	'0614-97434 8'	,	'28 N STADIUM DR'	,	'Kittrell'	,	'North Carolina'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00102'	,	'Paulette-Suzanne'	,	'Bernier'	,	'Paulette-SuzanneBernier@gmail.com'	,	'052-48587 1'	,	'2924 BRAKLEY DR, STE B4'	,	'Biscayne Park'	,	'Florida'	,	'United States'	,	1	);
INSERT INTO CUSTOMER (customerID,customerCod, customerFirstName,customerLastName,emailAddress,contactNumber,Address,city,province,country,status) VALUES (	customerid.NEXTVAL	,	'CUS00103'	,	'Marguerite-Maggie'	,	'Vallee'	,	'Marguerite-MaggieVallee@gmail.com'	,	'032671 538 74-9'	,	'3743 W LAKESHORE DR'	,	'Alabam'	,	'Arkansas'	,	'United States'	,	1	);

-----------------------------------
-- Inserts - table ORDERS
-----------------------------------
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	61	,	'2021-09-03'	,	2	,	'2021-09-07'	,	50	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	24	,	'2022-02-09'	,	1	,	'2022-02-13'	,	201.92	,	4	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	8	,	'2022-08-09'	,	2	,	'2022-08-13'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	83	,	'2022-06-30'	,	1	,	'2022-07-04'	,	40.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	31	,	'2021-09-22'	,	1	,	'2021-09-26'	,	299.97	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	56	,	'2021-08-03'	,	2	,	'2021-08-07'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	46	,	'2022-09-26'	,	1	,	'2022-09-30'	,	23.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	56	,	'2021-10-10'	,	2	,	'2021-10-14'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	85	,	'2022-06-26'	,	2	,	'2022-06-30'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	46	,	'2022-04-17'	,	1	,	'2022-04-21'	,	3.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	52	,	'2022-10-02'	,	1	,	'2022-10-06'	,	263.95	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	35	,	'2021-08-22'	,	1	,	'2021-08-26'	,	25.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	52	,	'2021-10-31'	,	1	,	'2021-11-04'	,	206.58	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	101	,	'2022-04-26'	,	1	,	'2022-04-30'	,	79.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	28	,	'2021-08-14'	,	1	,	'2021-08-18'	,	22.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	11	,	'2021-05-24'	,	2	,	'2021-05-28'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	100	,	'2021-10-09'	,	1	,	'2021-10-13'	,	16.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	30	,	'2021-11-22'	,	1	,	'2021-11-26'	,	13.49	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	45	,	'2022-05-03'	,	1	,	'2022-05-07'	,	77.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	47	,	'2021-07-16'	,	1	,	'2021-07-20'	,	3.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	68	,	'2021-04-24'	,	1	,	'2021-04-28'	,	23.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	68	,	'2021-08-11'	,	1	,	'2021-08-15'	,	10.08	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	95	,	'2021-11-20'	,	1	,	'2021-11-24'	,	34.81	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	6	,	'2022-01-09'	,	2	,	'2022-01-13'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	94	,	'2021-12-09'	,	1	,	'2021-12-13'	,	221.47	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	18	,	'2022-04-18'	,	1	,	'2022-04-22'	,	63.2	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	56	,	'2022-01-27'	,	1	,	'2022-01-31'	,	38.94	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	89	,	'2022-11-19'	,	1	,	'2022-11-23'	,	118.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	45	,	'2021-03-01'	,	1	,	'2021-03-05'	,	52.01	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	20	,	'2021-09-04'	,	1	,	'2021-09-08'	,	53.88	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	33	,	'2021-07-27'	,	1	,	'2021-07-31'	,	19.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	82	,	'2021-12-16'	,	1	,	'2021-12-20'	,	43.94	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	21	,	'2022-11-18'	,	1	,	'2022-11-22'	,	34.89	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	46	,	'2021-04-16'	,	2	,	'2021-04-20'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	89	,	'2021-04-20'	,	2	,	'2021-04-24'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	10	,	'2022-01-14'	,	1	,	'2022-01-18'	,	12.49	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	34	,	'2021-06-16'	,	2	,	'2021-06-20'	,	500	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	49	,	'2022-01-22'	,	2	,	'2022-01-26'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	87	,	'2022-05-05'	,	1	,	'2022-05-09'	,	181.2	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	13	,	'2022-03-08'	,	1	,	'2022-03-12'	,	5093.81	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	72	,	'2021-08-21'	,	1	,	'2021-08-25'	,	104.06	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	53	,	'2022-04-05'	,	2	,	'2022-04-09'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	5	,	'2022-09-17'	,	1	,	'2022-09-21'	,	4.59	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	72	,	'2021-06-02'	,	1	,	'2021-06-06'	,	80.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	1	,	'2021-07-03'	,	1	,	'2021-07-07'	,	25.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	25	,	'2022-07-09'	,	1	,	'2022-07-13'	,	95.59	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	77	,	'2021-05-28'	,	1	,	'2021-06-01'	,	16.55	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	15	,	'2022-03-16'	,	1	,	'2022-03-20'	,	86.95	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	8	,	'2021-06-15'	,	1	,	'2021-06-19'	,	99.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	25	,	'2021-03-14'	,	1	,	'2021-03-18'	,	19.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	38	,	'2021-09-04'	,	2	,	'2021-09-08'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	95	,	'2022-05-10'	,	1	,	'2022-05-14'	,	19.44	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	13	,	'2022-01-26'	,	1	,	'2022-01-30'	,	22.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	56	,	'2021-05-09'	,	1	,	'2021-05-13'	,	32.52	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	67	,	'2022-01-12'	,	1	,	'2022-01-16'	,	18.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	99	,	'2021-08-30'	,	2	,	'2021-09-03'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	62	,	'2022-11-30'	,	1	,	'2022-12-04'	,	118.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	30	,	'2022-07-23'	,	1	,	'2022-07-27'	,	18.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	5	,	'2021-03-08'	,	1	,	'2021-03-12'	,	30.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	53	,	'2022-04-29'	,	1	,	'2022-05-03'	,	123.91	,	4	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	77	,	'2022-04-24'	,	2	,	'2022-04-28'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	3	,	'2022-02-08'	,	2	,	'2022-02-12'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	15	,	'2022-06-20'	,	1	,	'2022-06-24'	,	12.53	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	28	,	'2021-08-04'	,	1	,	'2021-08-08'	,	13.49	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	76	,	'2021-12-14'	,	1	,	'2021-12-18'	,	7.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	62	,	'2021-09-25'	,	2	,	'2021-09-29'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	32	,	'2022-11-22'	,	1	,	'2022-11-26'	,	172.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	62	,	'2022-07-20'	,	2	,	'2022-07-24'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	7	,	'2021-11-05'	,	2	,	'2021-11-09'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	91	,	'2022-12-01'	,	2	,	'2022-12-05'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	21	,	'2021-10-18'	,	1	,	'2021-10-22'	,	164.94	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	2	,	'2021-11-25'	,	1	,	'2021-11-29'	,	23.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	39	,	'2022-03-24'	,	2	,	'2022-03-28'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	90	,	'2022-10-25'	,	2	,	'2022-10-29'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	99	,	'2021-08-26'	,	2	,	'2021-08-30'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	12	,	'2021-10-10'	,	1	,	'2021-10-14'	,	59.66	,	4	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	92	,	'2022-05-22'	,	1	,	'2022-05-26'	,	35.94	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	62	,	'2022-11-20'	,	2	,	'2022-11-24'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	46	,	'2022-03-08'	,	2	,	'2022-03-12'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	24	,	'2022-08-17'	,	1	,	'2022-08-21'	,	138.79	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	46	,	'2021-08-25'	,	1	,	'2021-08-29'	,	98.65	,	5	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	23	,	'2022-10-04'	,	2	,	'2022-10-08'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	51	,	'2021-11-20'	,	1	,	'2021-11-24'	,	15.18	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	52	,	'2022-01-31'	,	2	,	'2022-02-04'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	52	,	'2022-07-04'	,	1	,	'2022-07-08'	,	15.18	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	63	,	'2022-02-02'	,	1	,	'2022-02-06'	,	72.15	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	60	,	'2022-09-21'	,	1	,	'2022-09-25'	,	17.84	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	29	,	'2021-09-23'	,	1	,	'2021-09-27'	,	182.96	,	4	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	96	,	'2021-02-22'	,	2	,	'2021-02-26'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	43	,	'2022-11-30'	,	1	,	'2022-12-04'	,	50.97	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	98	,	'2021-02-03'	,	1	,	'2021-02-07'	,	79.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	4	,	'2022-02-03'	,	1	,	'2022-02-07'	,	49.45	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	65	,	'2022-08-21'	,	1	,	'2022-08-25'	,	79.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	87	,	'2022-01-10'	,	1	,	'2022-01-14'	,	195.61	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	13	,	'2022-03-22'	,	1	,	'2022-03-26'	,	36.52	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	38	,	'2021-08-21'	,	1	,	'2021-08-25'	,	58.07	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	50	,	'2022-05-07'	,	2	,	'2022-05-11'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	77	,	'2022-09-11'	,	1	,	'2022-09-15'	,	267.1	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	100	,	'2022-04-04'	,	1	,	'2022-04-08'	,	12.49	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	13	,	'2022-06-13'	,	1	,	'2022-06-17'	,	139.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	93	,	'2021-08-20'	,	1	,	'2021-08-24'	,	64.63	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	21	,	'2021-12-18'	,	1	,	'2021-12-22'	,	58.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	38	,	'2022-09-27'	,	1	,	'2022-10-01'	,	59.8	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	92	,	'2021-06-08'	,	1	,	'2021-06-12'	,	104.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	42	,	'2021-03-31'	,	1	,	'2021-04-04'	,	118.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	3	,	'2022-04-19'	,	1	,	'2022-04-23'	,	221.47	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	88	,	'2021-10-06'	,	2	,	'2021-10-10'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	79	,	'2022-08-19'	,	1	,	'2022-08-23'	,	139.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	58	,	'2022-07-26'	,	1	,	'2022-07-30'	,	16.55	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	50	,	'2021-06-02'	,	1	,	'2021-06-06'	,	8.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	83	,	'2022-01-31'	,	2	,	'2022-02-04'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	31	,	'2022-04-29'	,	2	,	'2022-05-03'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	102	,	'2021-12-28'	,	2	,	'2022-01-01'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	82	,	'2021-12-07'	,	2	,	'2021-12-11'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	88	,	'2021-03-30'	,	1	,	'2021-04-03'	,	19.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	6	,	'2021-04-01'	,	2	,	'2021-04-05'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	58	,	'2021-04-03'	,	1	,	'2021-04-07'	,	13.49	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	6	,	'2021-08-19'	,	1	,	'2021-08-23'	,	111.96	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	94	,	'2021-09-06'	,	1	,	'2021-09-10'	,	10.94	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	97	,	'2021-09-07'	,	1	,	'2021-09-11'	,	30.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	88	,	'2021-08-24'	,	1	,	'2021-08-28'	,	7.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	1	,	'2021-10-10'	,	1	,	'2021-10-14'	,	215.96	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	17	,	'2022-02-11'	,	2	,	'2022-02-15'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	95	,	'2021-11-04'	,	2	,	'2021-11-08'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	55	,	'2021-07-24'	,	2	,	'2021-07-28'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	3	,	'2022-01-30'	,	1	,	'2022-02-03'	,	191.97	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	58	,	'2022-01-27'	,	2	,	'2022-01-31'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	64	,	'2021-03-25'	,	1	,	'2021-03-29'	,	72.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	17	,	'2021-08-03'	,	1	,	'2021-08-07'	,	24.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	44	,	'2021-12-28'	,	1	,	'2022-01-01'	,	4.59	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	103	,	'2022-02-09'	,	1	,	'2022-02-13'	,	92.06	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	54	,	'2021-09-28'	,	1	,	'2021-10-02'	,	246.81	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	12	,	'2021-10-24'	,	2	,	'2021-10-28'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	94	,	'2021-03-29'	,	2	,	'2021-04-02'	,	150	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	97	,	'2021-07-17'	,	1	,	'2021-07-21'	,	67.88	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	64	,	'2022-03-08'	,	1	,	'2022-03-12'	,	36.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	11	,	'2022-04-05'	,	2	,	'2022-04-09'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	55	,	'2021-09-14'	,	1	,	'2021-09-18'	,	31.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	23	,	'2022-11-18'	,	2	,	'2022-11-22'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	36	,	'2022-08-29'	,	2	,	'2022-09-02'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	16	,	'2021-04-05'	,	1	,	'2021-04-09'	,	19.07	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	8	,	'2022-03-03'	,	1	,	'2022-03-07'	,	135.76	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	97	,	'2022-10-09'	,	1	,	'2022-10-13'	,	12.49	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	64	,	'2022-01-14'	,	1	,	'2022-01-18'	,	47.42	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	10	,	'2022-11-24'	,	1	,	'2022-11-28'	,	299.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	78	,	'2022-03-25'	,	2	,	'2022-03-29'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	98	,	'2021-06-30'	,	1	,	'2021-07-04'	,	54.99	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	70	,	'2021-05-05'	,	1	,	'2021-05-09'	,	35.54	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	17	,	'2021-02-28'	,	1	,	'2021-03-04'	,	210.11	,	4	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	80	,	'2021-09-20'	,	1	,	'2021-09-24'	,	14.05	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	15	,	'2022-10-12'	,	1	,	'2022-10-16'	,	3.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	23	,	'2022-04-06'	,	1	,	'2022-04-10'	,	19.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	96	,	'2022-06-21'	,	2	,	'2022-06-25'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	51	,	'2021-11-03'	,	1	,	'2021-11-07'	,	19.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	80	,	'2021-02-12'	,	2	,	'2021-02-16'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	46	,	'2021-07-18'	,	1	,	'2021-07-22'	,	29.29	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	80	,	'2021-10-15'	,	1	,	'2021-10-19'	,	32.76	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	39	,	'2021-05-22'	,	2	,	'2021-05-26'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	34	,	'2021-12-24'	,	1	,	'2021-12-28'	,	99.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	61	,	'2021-07-15'	,	1	,	'2021-07-19'	,	139.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	75	,	'2021-03-19'	,	1	,	'2021-03-23'	,	23.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	42	,	'2021-06-20'	,	1	,	'2021-06-24'	,	59.94	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	49	,	'2021-09-17'	,	1	,	'2021-09-21'	,	78.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	47	,	'2022-10-01'	,	1	,	'2022-10-05'	,	18.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	66	,	'2021-08-30'	,	1	,	'2021-09-03'	,	3.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	49	,	'2021-03-08'	,	2	,	'2021-03-12'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	65	,	'2021-06-14'	,	1	,	'2021-06-18'	,	251.42	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	31	,	'2022-10-16'	,	1	,	'2022-10-20'	,	34.89	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	15	,	'2021-10-12'	,	2	,	'2021-10-16'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	81	,	'2021-08-09'	,	1	,	'2021-08-13'	,	19.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	99	,	'2022-06-07'	,	1	,	'2022-06-11'	,	59.72	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	89	,	'2021-09-10'	,	1	,	'2021-09-14'	,	39.97	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	92	,	'2021-03-01'	,	1	,	'2021-03-05'	,	31.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	84	,	'2022-06-24'	,	1	,	'2022-06-28'	,	3.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	62	,	'2022-08-20'	,	1	,	'2022-08-24'	,	42.96	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	38	,	'2022-11-23'	,	1	,	'2022-11-27'	,	38.97	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	67	,	'2022-05-15'	,	1	,	'2022-05-19'	,	13.94	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	62	,	'2022-06-19'	,	1	,	'2022-06-23'	,	33.47	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	21	,	'2021-12-30'	,	1	,	'2022-01-03'	,	215.94	,	4	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	49	,	'2022-11-08'	,	1	,	'2022-11-12'	,	219.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	14	,	'2022-02-13'	,	1	,	'2022-02-17'	,	79.82	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	22	,	'2021-03-21'	,	2	,	'2021-03-25'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	53	,	'2022-01-27'	,	1	,	'2022-01-31'	,	35.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	17	,	'2021-03-25'	,	1	,	'2021-03-29'	,	7.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	34	,	'2021-12-19'	,	1	,	'2021-12-23'	,	221.47	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	73	,	'2021-03-07'	,	2	,	'2021-03-11'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	41	,	'2022-11-09'	,	1	,	'2022-11-13'	,	34.89	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	7	,	'2022-06-28'	,	1	,	'2022-07-02'	,	5.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	23	,	'2022-08-18'	,	1	,	'2022-08-22'	,	13.49	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	37	,	'2021-08-30'	,	2	,	'2021-09-03'	,	150	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	47	,	'2021-04-03'	,	1	,	'2021-04-07'	,	3.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	44	,	'2022-10-22'	,	2	,	'2022-10-26'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	46	,	'2021-05-17'	,	1	,	'2021-05-21'	,	89.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	9	,	'2022-05-07'	,	1	,	'2022-05-11'	,	18.84	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	86	,	'2022-03-25'	,	1	,	'2022-03-29'	,	3.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	61	,	'2021-12-20'	,	1	,	'2021-12-24'	,	19.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	50	,	'2022-07-04'	,	2	,	'2022-07-08'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	50	,	'2021-06-06'	,	1	,	'2021-06-10'	,	195.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	58	,	'2022-04-24'	,	1	,	'2022-04-28'	,	19.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	16	,	'2022-08-17'	,	2	,	'2022-08-21'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	94	,	'2022-02-15'	,	2	,	'2022-02-19'	,	250	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	62	,	'2022-10-02'	,	1	,	'2022-10-06'	,	48.38	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	61	,	'2022-06-19'	,	2	,	'2022-06-23'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	93	,	'2021-05-21'	,	1	,	'2021-05-25'	,	8.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	103	,	'2022-01-15'	,	2	,	'2022-01-19'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	91	,	'2021-06-30'	,	1	,	'2021-07-04'	,	26.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	33	,	'2021-06-01'	,	1	,	'2021-06-05'	,	3.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	73	,	'2021-04-24'	,	1	,	'2021-04-28'	,	23.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	98	,	'2022-07-05'	,	2	,	'2022-07-09'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	52	,	'2022-07-01'	,	1	,	'2022-07-05'	,	16.96	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	61	,	'2022-07-31'	,	1	,	'2022-08-04'	,	144.83	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	55	,	'2022-10-04'	,	1	,	'2022-10-08'	,	103.29	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	79	,	'2022-09-25'	,	1	,	'2022-09-29'	,	74.82	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	48	,	'2022-10-19'	,	1	,	'2022-10-23'	,	6.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	23	,	'2022-01-25'	,	1	,	'2022-01-29'	,	222.92	,	4	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	57	,	'2022-06-28'	,	1	,	'2022-07-02'	,	5.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	103	,	'2021-04-04'	,	1	,	'2021-04-08'	,	58.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	71	,	'2022-06-28'	,	1	,	'2022-07-02'	,	29.29	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	72	,	'2021-06-09'	,	1	,	'2021-06-13'	,	19.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	50	,	'2022-09-03'	,	1	,	'2022-09-07'	,	39.43	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	96	,	'2022-03-03'	,	1	,	'2022-03-07'	,	19.95	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	67	,	'2022-07-29'	,	2	,	'2022-08-02'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	2	,	'2022-06-26'	,	2	,	'2022-06-30'	,	200	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	27	,	'2022-07-11'	,	1	,	'2022-07-15'	,	477.88	,	5	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	49	,	'2022-05-29'	,	1	,	'2022-06-02'	,	19.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	57	,	'2021-06-01'	,	2	,	'2021-06-05'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	59	,	'2022-08-02'	,	2	,	'2022-08-06'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	51	,	'2021-04-02'	,	1	,	'2021-04-06'	,	50.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	30	,	'2021-09-08'	,	1	,	'2021-09-12'	,	34.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	27	,	'2021-07-23'	,	1	,	'2021-07-27'	,	9.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	19	,	'2022-11-10'	,	1	,	'2022-11-14'	,	46.97	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	92	,	'2021-06-01'	,	1	,	'2021-06-05'	,	40.48	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	70	,	'2021-09-14'	,	1	,	'2021-09-18'	,	9.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	66	,	'2021-09-30'	,	1	,	'2021-10-04'	,	33.96	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	77	,	'2022-10-23'	,	1	,	'2022-10-27'	,	12.53	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	96	,	'2022-05-02'	,	1	,	'2022-05-06'	,	47.94	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	52	,	'2022-01-23'	,	2	,	'2022-01-27'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	46	,	'2022-01-28'	,	1	,	'2022-02-01'	,	50.81	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	84	,	'2021-08-19'	,	1	,	'2021-08-23'	,	26.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	45	,	'2022-07-11'	,	1	,	'2022-07-15'	,	69.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	82	,	'2021-08-24'	,	1	,	'2021-08-28'	,	55.11	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	8	,	'2022-04-23'	,	2	,	'2022-04-27'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	70	,	'2021-12-26'	,	2	,	'2021-12-30'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	101	,	'2022-09-09'	,	1	,	'2022-09-13'	,	90.68	,	4	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	27	,	'2021-02-12'	,	1	,	'2021-02-16'	,	29.15	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	15	,	'2022-07-03'	,	2	,	'2022-07-07'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	21	,	'2021-09-09'	,	2	,	'2021-09-13'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	3	,	'2021-11-04'	,	1	,	'2021-11-08'	,	18.08	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	100	,	'2022-05-02'	,	1	,	'2022-05-06'	,	324.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	25	,	'2022-01-26'	,	1	,	'2022-01-30'	,	139.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	4	,	'2022-03-16'	,	2	,	'2022-03-20'	,	50	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	14	,	'2022-03-24'	,	1	,	'2022-03-28'	,	22.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	43	,	'2022-09-01'	,	2	,	'2022-09-05'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	26	,	'2022-05-19'	,	1	,	'2022-05-23'	,	210.34	,	4	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	92	,	'2021-09-30'	,	2	,	'2021-10-04'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	13	,	'2022-07-22'	,	2	,	'2022-07-26'	,	50	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	81	,	'2022-11-07'	,	1	,	'2022-11-11'	,	115.66	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	20	,	'2022-03-20'	,	1	,	'2022-03-24'	,	74.82	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	80	,	'2021-07-08'	,	2	,	'2021-07-12'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	1	,	'2021-05-11'	,	2	,	'2021-05-15'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	103	,	'2021-06-13'	,	1	,	'2021-06-17'	,	49.47	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	15	,	'2021-12-16'	,	1	,	'2021-12-20'	,	11.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	61	,	'2021-05-14'	,	1	,	'2021-05-18'	,	36.83	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	12	,	'2021-12-06'	,	1	,	'2021-12-10'	,	242.08	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	20	,	'2021-12-15'	,	1	,	'2021-12-19'	,	30.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	97	,	'2022-01-10'	,	1	,	'2022-01-14'	,	77.52	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	5	,	'2022-08-01'	,	2	,	'2022-08-05'	,	50	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	52	,	'2022-04-25'	,	2	,	'2022-04-29'	,	50	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	33	,	'2021-09-28'	,	1	,	'2021-10-02'	,	34.81	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	95	,	'2022-02-28'	,	1	,	'2022-03-04'	,	34.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	7	,	'2021-08-29'	,	1	,	'2021-09-02'	,	196.53	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	84	,	'2021-08-02'	,	1	,	'2021-08-06'	,	33.97	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	18	,	'2021-02-16'	,	2	,	'2021-02-20'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	3	,	'2022-09-09'	,	2	,	'2022-09-13'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	42	,	'2022-01-20'	,	1	,	'2022-01-24'	,	146.68	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	62	,	'2022-06-24'	,	1	,	'2022-06-28'	,	23.96	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	96	,	'2021-06-18'	,	1	,	'2021-06-22'	,	67.88	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	21	,	'2022-07-23'	,	2	,	'2022-07-27'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	92	,	'2021-06-11'	,	2	,	'2021-06-15'	,	50	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	4	,	'2021-09-22'	,	2	,	'2021-09-26'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	59	,	'2021-02-11'	,	1	,	'2021-02-15'	,	24.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	101	,	'2022-06-04'	,	2	,	'2022-06-08'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	59	,	'2022-05-28'	,	2	,	'2022-06-01'	,	50	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	60	,	'2021-12-13'	,	1	,	'2021-12-17'	,	59.88	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	48	,	'2021-05-14'	,	1	,	'2021-05-18'	,	10.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	72	,	'2022-07-06'	,	2	,	'2022-07-10'	,	50	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	31	,	'2021-07-31'	,	1	,	'2021-08-04'	,	25.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	93	,	'2021-02-25'	,	1	,	'2021-03-01'	,	31.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	27	,	'2021-03-19'	,	1	,	'2021-03-23'	,	82.52	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	79	,	'2022-03-09'	,	1	,	'2022-03-13'	,	20.18	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	18	,	'2022-10-21'	,	1	,	'2022-10-25'	,	69.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	70	,	'2022-09-28'	,	2	,	'2022-10-02'	,	50	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	92	,	'2022-08-07'	,	1	,	'2022-08-11'	,	11.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	64	,	'2021-11-05'	,	1	,	'2021-11-09'	,	45.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	73	,	'2022-06-03'	,	1	,	'2022-06-07'	,	59.88	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	75	,	'2021-07-11'	,	1	,	'2021-07-15'	,	32.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	44	,	'2022-02-03'	,	1	,	'2022-02-07'	,	10.08	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	70	,	'2022-07-20'	,	1	,	'2022-07-24'	,	7.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	94	,	'2021-03-12'	,	2	,	'2021-03-16'	,	50	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	101	,	'2021-07-05'	,	1	,	'2021-07-09'	,	65.41	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	54	,	'2021-06-02'	,	2	,	'2021-06-06'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	41	,	'2021-06-19'	,	2	,	'2021-06-23'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	34	,	'2021-02-27'	,	1	,	'2021-03-03'	,	74.85	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	67	,	'2022-10-22'	,	1	,	'2022-10-26'	,	32.96	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	102	,	'2021-07-27'	,	1	,	'2021-07-31'	,	28.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	71	,	'2022-10-21'	,	1	,	'2022-10-25'	,	34.81	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	17	,	'2021-03-18'	,	1	,	'2021-03-22'	,	113.97	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	61	,	'2021-07-11'	,	1	,	'2021-07-15'	,	226.94	,	4	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	71	,	'2021-08-31'	,	2	,	'2021-09-04'	,	50	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	5	,	'2021-12-19'	,	1	,	'2021-12-23'	,	69.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	96	,	'2021-06-21'	,	1	,	'2021-06-25'	,	17.84	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	52	,	'2022-11-26'	,	1	,	'2022-11-30'	,	19.44	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	78	,	'2021-11-26'	,	1	,	'2021-11-30'	,	41.97	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	53	,	'2021-10-04'	,	1	,	'2021-10-08'	,	56.15	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	68	,	'2022-10-11'	,	2	,	'2022-10-15'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	94	,	'2022-09-30'	,	1	,	'2022-10-04'	,	69.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	45	,	'2021-05-15'	,	1	,	'2021-05-19'	,	18.84	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	93	,	'2022-08-22'	,	1	,	'2022-08-26'	,	119.69	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	84	,	'2021-07-27'	,	2	,	'2021-07-31'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	86	,	'2022-01-26'	,	1	,	'2022-01-30'	,	224.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	64	,	'2022-05-17'	,	1	,	'2022-05-21'	,	6.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	94	,	'2022-07-21'	,	1	,	'2022-07-25'	,	3.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	6	,	'2022-11-14'	,	2	,	'2022-11-18'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	92	,	'2022-05-25'	,	2	,	'2022-05-29'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	29	,	'2022-02-09'	,	1	,	'2022-02-13'	,	83.47	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	50	,	'2021-02-02'	,	2	,	'2021-02-06'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	100	,	'2021-03-13'	,	1	,	'2021-03-17'	,	10.08	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	99	,	'2021-08-10'	,	2	,	'2021-08-14'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	48	,	'2021-06-29'	,	1	,	'2021-07-03'	,	19.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	66	,	'2021-11-01'	,	2	,	'2021-11-05'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	28	,	'2022-10-05'	,	1	,	'2022-10-09'	,	211.96	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	35	,	'2022-10-18'	,	1	,	'2022-10-22'	,	177.5	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	39	,	'2022-12-01'	,	1	,	'2022-12-05'	,	20.18	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	72	,	'2022-03-22'	,	1	,	'2022-03-26'	,	11.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	54	,	'2022-08-08'	,	2	,	'2022-08-12'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	76	,	'2021-10-15'	,	1	,	'2021-10-19'	,	31.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	36	,	'2022-03-24'	,	1	,	'2022-03-28'	,	187.1	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	37	,	'2022-04-23'	,	1	,	'2022-04-27'	,	62.97	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	94	,	'2022-08-04'	,	1	,	'2022-08-08'	,	57.87	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	89	,	'2022-11-29'	,	2	,	'2022-12-03'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	19	,	'2021-05-25'	,	1	,	'2021-05-29'	,	13.49	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	46	,	'2022-09-17'	,	1	,	'2022-09-21'	,	118.83	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	8	,	'2021-07-15'	,	1	,	'2021-07-19'	,	103.97	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	95	,	'2022-06-19'	,	1	,	'2022-06-23'	,	4.59	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	26	,	'2022-01-23'	,	2	,	'2022-01-27'	,	50	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	1	,	'2021-10-13'	,	1	,	'2021-10-17'	,	10.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	46	,	'2021-12-26'	,	2	,	'2021-12-30'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	67	,	'2021-09-24'	,	1	,	'2021-09-28'	,	142.8	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	30	,	'2022-01-12'	,	1	,	'2022-01-16'	,	29.29	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	46	,	'2022-07-24'	,	2	,	'2022-07-28'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	75	,	'2022-07-14'	,	1	,	'2022-07-18'	,	29.29	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	83	,	'2021-04-06'	,	1	,	'2021-04-10'	,	167.11	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	76	,	'2022-01-03'	,	1	,	'2022-01-07'	,	61.88	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	87	,	'2021-02-17'	,	1	,	'2021-02-21'	,	19.44	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	31	,	'2021-11-05'	,	2	,	'2021-11-09'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	94	,	'2022-09-24'	,	1	,	'2022-09-28'	,	91.95	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	15	,	'2022-02-08'	,	2	,	'2022-02-12'	,	50	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	64	,	'2022-04-14'	,	2	,	'2022-04-18'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	95	,	'2022-01-29'	,	1	,	'2022-02-02'	,	40.79	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	3	,	'2021-04-22'	,	1	,	'2021-04-26'	,	12.49	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	85	,	'2022-07-19'	,	1	,	'2022-07-23'	,	10.08	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	52	,	'2022-04-02'	,	2	,	'2022-04-06'	,	50	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	73	,	'2022-11-17'	,	1	,	'2022-11-21'	,	4.59	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	68	,	'2022-10-06'	,	1	,	'2022-10-10'	,	221.47	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	90	,	'2022-08-30'	,	1	,	'2022-09-03'	,	83.48	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	6	,	'2021-04-09'	,	1	,	'2021-04-13'	,	6.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	96	,	'2022-09-10'	,	1	,	'2022-09-14'	,	167.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	25	,	'2021-10-23'	,	1	,	'2021-10-27'	,	32.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	41	,	'2022-06-18'	,	2	,	'2022-06-22'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	84	,	'2021-05-25'	,	1	,	'2021-05-29'	,	41.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	87	,	'2021-04-28'	,	1	,	'2021-05-02'	,	19.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	103	,	'2022-04-24'	,	1	,	'2022-04-28'	,	28.67	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	86	,	'2022-04-16'	,	2	,	'2022-04-20'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	3	,	'2021-12-10'	,	1	,	'2021-12-14'	,	32.48	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	35	,	'2022-03-18'	,	1	,	'2022-03-22'	,	69.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	54	,	'2021-11-04'	,	1	,	'2021-11-08'	,	9.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	92	,	'2022-05-08'	,	1	,	'2022-05-12'	,	26.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	89	,	'2022-05-24'	,	2	,	'2022-05-28'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	30	,	'2021-04-24'	,	2	,	'2021-04-28'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	55	,	'2022-07-12'	,	1	,	'2022-07-16'	,	269.29	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	40	,	'2022-01-10'	,	1	,	'2022-01-14'	,	96.54	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	5	,	'2022-11-05'	,	1	,	'2022-11-09'	,	37.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	74	,	'2021-03-11'	,	1	,	'2021-03-15'	,	5.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	22	,	'2022-05-04'	,	1	,	'2022-05-08'	,	101.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	98	,	'2022-05-07'	,	1	,	'2022-05-11'	,	23.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	35	,	'2022-09-05'	,	2	,	'2022-09-09'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	101	,	'2021-05-19'	,	1	,	'2021-05-23'	,	69.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	4	,	'2022-08-26'	,	1	,	'2022-08-30'	,	15.88	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	33	,	'2021-05-24'	,	2	,	'2021-05-28'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	10	,	'2022-03-16'	,	1	,	'2022-03-20'	,	5.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	1	,	'2021-06-06'	,	1	,	'2021-06-10'	,	37.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	65	,	'2022-02-26'	,	1	,	'2022-03-02'	,	59.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	76	,	'2021-10-12'	,	1	,	'2021-10-16'	,	89.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	36	,	'2022-04-10'	,	1	,	'2022-04-14'	,	45.07	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	43	,	'2021-09-28'	,	1	,	'2021-10-02'	,	20.18	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	74	,	'2021-03-21'	,	2	,	'2021-03-25'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	36	,	'2022-06-26'	,	1	,	'2022-06-30'	,	11.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	7	,	'2021-11-28'	,	1	,	'2021-12-02'	,	73.95	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	50	,	'2022-12-02'	,	1	,	'2022-12-06'	,	84.96	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	39	,	'2022-04-23'	,	1	,	'2022-04-27'	,	241.45	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	14	,	'2022-06-13'	,	1	,	'2022-06-17'	,	221.47	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	8	,	'2022-05-09'	,	1	,	'2022-05-13'	,	13.49	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	97	,	'2021-06-19'	,	1	,	'2021-06-23'	,	4.59	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	69	,	'2022-03-02'	,	2	,	'2022-03-06'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	56	,	'2021-06-10'	,	1	,	'2021-06-14'	,	19.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	24	,	'2022-02-07'	,	1	,	'2022-02-11'	,	56.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	55	,	'2022-05-29'	,	1	,	'2022-06-02'	,	3.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	91	,	'2021-06-13'	,	2	,	'2021-06-17'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	40	,	'2021-02-18'	,	1	,	'2021-02-22'	,	47.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	39	,	'2021-12-23'	,	2	,	'2021-12-27'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	13	,	'2021-12-30'	,	1	,	'2022-01-03'	,	3.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	3	,	'2021-12-04'	,	1	,	'2021-12-08'	,	19.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	49	,	'2022-05-09'	,	2	,	'2022-05-13'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	78	,	'2021-02-02'	,	1	,	'2021-02-06'	,	266.81	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	13	,	'2021-02-19'	,	1	,	'2021-02-23'	,	34.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	83	,	'2022-04-04'	,	2	,	'2022-04-08'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	1	,	'2021-03-16'	,	1	,	'2021-03-20'	,	138.96	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	38	,	'2021-05-14'	,	1	,	'2021-05-18'	,	6.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	5	,	'2021-04-24'	,	1	,	'2021-04-28'	,	12.53	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	57	,	'2022-06-07'	,	1	,	'2022-06-11'	,	199.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	71	,	'2021-05-12'	,	1	,	'2021-05-16'	,	20.18	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	15	,	'2021-05-29'	,	2	,	'2021-06-02'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	43	,	'2021-05-20'	,	1	,	'2021-05-24'	,	130.03	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	79	,	'2022-01-23'	,	2	,	'2022-01-27'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	99	,	'2022-08-28'	,	2	,	'2022-09-01'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	47	,	'2021-04-22'	,	1	,	'2021-04-26'	,	8.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	25	,	'2021-02-13'	,	2	,	'2021-02-17'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	79	,	'2022-10-09'	,	1	,	'2022-10-13'	,	55.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	35	,	'2021-06-08'	,	2	,	'2021-06-12'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	31	,	'2022-09-01'	,	1	,	'2022-09-05'	,	22.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	70	,	'2022-05-03'	,	2	,	'2022-05-07'	,	150	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	2	,	'2022-07-12'	,	2	,	'2022-07-16'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	18	,	'2021-12-12'	,	1	,	'2021-12-16'	,	41.94	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	55	,	'2021-10-16'	,	2	,	'2021-10-20'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	62	,	'2021-03-27'	,	1	,	'2021-03-31'	,	28.96	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	70	,	'2022-11-02'	,	2	,	'2022-11-06'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	85	,	'2022-09-17'	,	1	,	'2022-09-21'	,	29.29	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	59	,	'2022-08-26'	,	1	,	'2022-08-30'	,	139.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	98	,	'2022-07-12'	,	1	,	'2022-07-16'	,	265.45	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	5	,	'2021-09-04'	,	1	,	'2021-09-08'	,	130.24	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	86	,	'2022-10-19'	,	1	,	'2022-10-23'	,	19.95	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	102	,	'2022-04-08'	,	1	,	'2022-04-12'	,	79.96	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	26	,	'2021-04-15'	,	1	,	'2021-04-19'	,	34.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	90	,	'2022-08-16'	,	1	,	'2022-08-20'	,	49.28	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	81	,	'2022-10-03'	,	1	,	'2022-10-07'	,	128.46	,	5	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	79	,	'2022-02-10'	,	1	,	'2022-02-14'	,	7.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	62	,	'2021-09-22'	,	1	,	'2021-09-26'	,	59.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	102	,	'2021-08-09'	,	2	,	'2021-08-13'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	63	,	'2021-10-18'	,	1	,	'2021-10-22'	,	54.93	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	100	,	'2022-05-12'	,	1	,	'2022-05-16'	,	42.97	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	26	,	'2021-07-13'	,	1	,	'2021-07-17'	,	34.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	10	,	'2022-05-08'	,	1	,	'2022-05-12'	,	285.19	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	6	,	'2021-03-31'	,	1	,	'2021-04-04'	,	376.38	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	16	,	'2021-08-05'	,	1	,	'2021-08-09'	,	83.07	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	91	,	'2022-04-20'	,	1	,	'2022-04-24'	,	24.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	39	,	'2021-09-30'	,	1	,	'2021-10-04'	,	34.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	26	,	'2022-10-14'	,	2	,	'2022-10-18'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	25	,	'2022-09-18'	,	1	,	'2022-09-22'	,	99.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	49	,	'2022-04-13'	,	1	,	'2022-04-17'	,	18.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	101	,	'2021-10-05'	,	2	,	'2021-10-09'	,	200	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	65	,	'2021-06-07'	,	2	,	'2021-06-11'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	22	,	'2021-07-15'	,	2	,	'2021-07-19'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	75	,	'2022-05-10'	,	2	,	'2022-05-14'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	22	,	'2022-08-07'	,	1	,	'2022-08-11'	,	17.84	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	23	,	'2022-01-07'	,	1	,	'2022-01-11'	,	69.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	49	,	'2021-11-09'	,	1	,	'2021-11-13'	,	309.57	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	97	,	'2022-11-24'	,	1	,	'2022-11-28'	,	64.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	74	,	'2021-02-05'	,	1	,	'2021-02-09'	,	36.97	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	40	,	'2021-04-06'	,	1	,	'2021-04-10'	,	7.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	102	,	'2021-06-18'	,	2	,	'2021-06-22'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	33	,	'2021-04-10'	,	2	,	'2021-04-14'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	63	,	'2022-04-17'	,	2	,	'2022-04-21'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	11	,	'2022-07-18'	,	2	,	'2022-07-22'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	67	,	'2022-03-31'	,	1	,	'2022-04-04'	,	68.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	2	,	'2022-08-20'	,	1	,	'2022-08-24'	,	23.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	100	,	'2022-08-31'	,	2	,	'2022-09-04'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	85	,	'2022-04-17'	,	1	,	'2022-04-21'	,	78.95	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	11	,	'2021-08-06'	,	1	,	'2021-08-10'	,	19.44	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	52	,	'2021-12-07'	,	1	,	'2021-12-11'	,	24.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	85	,	'2022-02-17'	,	2	,	'2022-02-21'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	78	,	'2021-06-21'	,	2	,	'2021-06-25'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	28	,	'2022-02-06'	,	1	,	'2022-02-10'	,	169.97	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	40	,	'2022-03-09'	,	1	,	'2022-03-13'	,	18.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	69	,	'2021-11-12'	,	1	,	'2021-11-16'	,	51.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	101	,	'2021-05-03'	,	1	,	'2021-05-07'	,	64.45	,	4	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	34	,	'2022-07-15'	,	2	,	'2022-07-19'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	54	,	'2022-04-13'	,	1	,	'2022-04-17'	,	37.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	100	,	'2021-10-18'	,	1	,	'2021-10-22'	,	221.47	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	44	,	'2021-11-10'	,	1	,	'2021-11-14'	,	29.29	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	29	,	'2022-05-24'	,	1	,	'2022-05-28'	,	16.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	35	,	'2021-06-14'	,	1	,	'2021-06-18'	,	31.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	34	,	'2022-11-12'	,	2	,	'2022-11-16'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	58	,	'2021-02-05'	,	1	,	'2021-02-09'	,	41.96	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	7	,	'2021-06-29'	,	2	,	'2021-07-03'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	29	,	'2021-05-20'	,	1	,	'2021-05-24'	,	228.96	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	87	,	'2022-05-03'	,	1	,	'2022-05-07'	,	92.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	75	,	'2021-09-22'	,	1	,	'2021-09-26'	,	115.78	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	70	,	'2021-10-07'	,	1	,	'2021-10-11'	,	136.82	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	33	,	'2022-04-02'	,	1	,	'2022-04-06'	,	89.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	2	,	'2021-02-09'	,	1	,	'2021-02-13'	,	50.14	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	3	,	'2022-03-30'	,	1	,	'2022-04-03'	,	38.83	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	84	,	'2022-04-15'	,	1	,	'2022-04-19'	,	24.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	13	,	'2021-09-22'	,	1	,	'2021-09-26'	,	69.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	15	,	'2021-08-25'	,	1	,	'2021-08-29'	,	145.67	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	30	,	'2021-11-20'	,	1	,	'2021-11-24'	,	20.96	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	22	,	'2022-12-02'	,	1	,	'2022-12-06'	,	49.25	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	45	,	'2021-04-23'	,	1	,	'2021-04-27'	,	36.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	55	,	'2021-12-31'	,	1	,	'2022-01-04'	,	19.95	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	99	,	'2022-06-26'	,	2	,	'2022-06-30'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	42	,	'2021-03-22'	,	1	,	'2021-03-26'	,	8.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	42	,	'2021-06-02'	,	2	,	'2021-06-06'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	54	,	'2021-05-24'	,	1	,	'2021-05-28'	,	224.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	15	,	'2022-05-16'	,	2	,	'2022-05-20'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	3	,	'2021-11-09'	,	1	,	'2021-11-13'	,	100.23	,	4	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	60	,	'2021-12-28'	,	1	,	'2022-01-01'	,	3.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	14	,	'2021-10-06'	,	1	,	'2021-10-10'	,	144.98	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	46	,	'2022-04-04'	,	1	,	'2022-04-08'	,	28.58	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	89	,	'2022-02-02'	,	1	,	'2022-02-06'	,	9.97	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	56	,	'2022-04-01'	,	2	,	'2022-04-05'	,	1000	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	67	,	'2021-02-02'	,	1	,	'2021-02-06'	,	72.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	61	,	'2021-04-04'	,	1	,	'2021-04-08'	,	50.04	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	48	,	'2022-10-06'	,	1	,	'2022-10-10'	,	19.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	16	,	'2021-11-28'	,	1	,	'2021-12-02'	,	84.75	,	4	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	77	,	'2022-11-10'	,	1	,	'2022-11-14'	,	21.48	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	29	,	'2022-10-01'	,	1	,	'2022-10-05'	,	99.7	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	66	,	'2021-08-04'	,	2	,	'2021-08-08'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	38	,	'2021-12-10'	,	1	,	'2021-12-14'	,	4.59	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	29	,	'2021-02-17'	,	2	,	'2021-02-21'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	47	,	'2022-10-30'	,	1	,	'2022-11-03'	,	30.96	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	14	,	'2022-09-25'	,	1	,	'2022-09-29'	,	47.98	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	7	,	'2021-05-08'	,	2	,	'2021-05-12'	,	100	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	16	,	'2021-09-14'	,	2	,	'2021-09-18'	,	50	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	15	,	'2022-11-19'	,	1	,	'2022-11-23'	,	52.28	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	34	,	'2021-10-07'	,	1	,	'2021-10-11'	,	7.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	95	,	'2021-09-22'	,	1	,	'2021-09-26'	,	105.95	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	66	,	'2021-07-27'	,	1	,	'2021-07-31'	,	18.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	30	,	'2021-11-13'	,	1	,	'2021-11-17'	,	73.92	,	3	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	27	,	'2022-05-30'	,	2	,	'2022-06-03'	,	10	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	28	,	'2021-10-23'	,	2	,	'2021-10-27'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	48	,	'2022-02-04'	,	1	,	'2022-02-08'	,	4.59	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	54	,	'2022-06-09'	,	1	,	'2022-06-13'	,	37.99	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	25	,	'2021-09-22'	,	1	,	'2021-09-26'	,	34.17	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	72	,	'2021-05-09'	,	1	,	'2021-05-13'	,	13.94	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	34	,	'2022-05-27'	,	1	,	'2022-05-31'	,	29.96	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	26	,	'2022-03-05'	,	1	,	'2022-03-09'	,	19.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	49	,	'2022-08-14'	,	2	,	'2022-08-18'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	69	,	'2021-04-04'	,	2	,	'2021-04-08'	,	15	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	36	,	'2021-03-28'	,	1	,	'2021-04-01'	,	103.29	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	72	,	'2022-06-27'	,	1	,	'2022-07-01'	,	117.46	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	43	,	'2022-08-24'	,	1	,	'2022-08-28'	,	19.98	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	33	,	'2021-12-07'	,	1	,	'2021-12-11'	,	19.95	,	1	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	95	,	'2021-02-21'	,	1	,	'2021-02-25'	,	32.97	,	2	);
INSERT INTO ORDERS (orderID,customerID,orderDate,orderType,expectedDeliveryDate,totalAmount,numberOfItems) VALUES (	orderID.NEXTVAL	,	2	,	'2022-03-09'	,	2	,	'2022-03-13'	,	15	,	1	);

-----------------------------------
-- Inserts - table PRODUCTCATEGORY
-----------------------------------
INSERT INTO PRODUCTCATEGORY (productCategoryID, categoryName) VALUES (	productCategoryID.NEXTVAL	,	'Equipment'	);
INSERT INTO PRODUCTCATEGORY (productCategoryID, categoryName) VALUES (	productCategoryID.NEXTVAL	,	'Toys'	);
INSERT INTO PRODUCTCATEGORY (productCategoryID, categoryName) VALUES (	productCategoryID.NEXTVAL	,	'Snack'	);
INSERT INTO PRODUCTCATEGORY (productCategoryID, categoryName) VALUES (	productCategoryID.NEXTVAL	,	'Supplements'	);
INSERT INTO PRODUCTCATEGORY (productCategoryID, categoryName) VALUES (	productCategoryID.NEXTVAL	,	'Bedding'	);
INSERT INTO PRODUCTCATEGORY (productCategoryID, categoryName) VALUES (	productCategoryID.NEXTVAL	,	'Medicine'	);
INSERT INTO PRODUCTCATEGORY (productCategoryID, categoryName) VALUES (	productCategoryID.NEXTVAL	,	'Housing'	);
INSERT INTO PRODUCTCATEGORY (productCategoryID, categoryName) VALUES (	productCategoryID.NEXTVAL	,	'Food'	);
INSERT INTO PRODUCTCATEGORY (productCategoryID, categoryName) VALUES (	productCategoryID.NEXTVAL	,	'Clothes'	);
INSERT INTO PRODUCTCATEGORY (productCategoryID, categoryName) VALUES (	productCategoryID.NEXTVAL	,	'Accessory'	);
INSERT INTO PRODUCTCATEGORY (productCategoryID, categoryName) VALUES (	productCategoryID.NEXTVAL	,	'Pet Care'	);

-----------------------------------
-- Inserts - table TYPE
-----------------------------------
INSERT INTO TYPE(typeID, typeName) VALUES (	typeID.NEXTVAL	,	'Product'	);
INSERT INTO TYPE(typeID, typeName) VALUES (	typeID.NEXTVAL	,	'Service'	);

-----------------------------------
-- Inserts - table CATEGORY
-----------------------------------
SET DEFINE OFF
INSERT INTO CATEGORY(categoryID, categoryName) VALUES (	categoryID.NEXTVAL	,	'Bird'	);
INSERT INTO CATEGORY(categoryID, categoryName) VALUES (	categoryID.NEXTVAL	,	'Cat'	);
INSERT INTO CATEGORY(categoryID, categoryName) VALUES (	categoryID.NEXTVAL	,	'Dog'	);
INSERT INTO CATEGORY(categoryID, categoryName) VALUES (	categoryID.NEXTVAL	,	'Fish & Aquatic Pets'	);
INSERT INTO CATEGORY(categoryID, categoryName) VALUES (	categoryID.NEXTVAL	,	'Insect'	);
INSERT INTO CATEGORY(categoryID, categoryName) VALUES (	categoryID.NEXTVAL	,	'Reptiles & Amphibian'	);
INSERT INTO CATEGORY(categoryID, categoryName) VALUES (	categoryID.NEXTVAL	,	'Small Animals'	);


-----------------------------------
-- Inserts - table GENDER
-----------------------------------
INSERT INTO GENDER(genderID, genderName) VALUES (genderID.NEXTVAL,	'Male'	);
INSERT INTO GENDER(genderID, genderName) VALUES (genderID.NEXTVAL,	'Female');

-----------------------------------
-- Inserts - table PET
-----------------------------------
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Zazu'	,	'Canaries'	,	1	,	1	,	'2021-01-30'	,	1	,	1	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Ruby'	,	'Miniature Schnauzers'	,	2	,	1	,	'2020-10-03'	,	3	,	2	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Bob'	,	'Convict Cichlids'	,	1	,	1	,	'2019-12-14'	,	4	,	3	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Finneus'	,	'The Betta'	,	1	,	1	,	'2019-03-04'	,	4	,	4	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Milo'	,	'Abyssinian'	,	1	,	1	,	'2017-10-04'	,	2	,	5	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Bear'	,	'Brittanys'	,	1	,	1	,	'2017-07-19'	,	3	,	15	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Coco'	,	'Dachshunds'	,	2	,	1	,	'2019-12-21'	,	3	,	16	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Oliver'	,	'Scottish Fold'	,	1	,	1	,	'2018-01-03'	,	2	,	17	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Wave'	,	'Oscars'	,	1	,	1	,	'2021-04-28'	,	4	,	18	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Ginger'	,	'Beagles'	,	2	,	1	,	'2017-04-13'	,	3	,	19	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Rosie'	,	'Great Danes'	,	2	,	0	,	'2021-07-04'	,	3	,	20	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Tori'	,	'Cockatoo'	,	2	,	1	,	'2017-08-17'	,	1	,	21	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Riley'	,	'Havanese'	,	1	,	1	,	'2020-10-04'	,	3	,	22	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'McFish'	,	'Fancy Guppies'	,	1	,	1	,	'2017-05-28'	,	4	,	23	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Tucker'	,	'Shetland Sheepdogs'	,	1	,	1	,	'2018-03-09'	,	3	,	25	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Charlie'	,	'Siamese'	,	1	,	1	,	'2021-07-17'	,	2	,	27	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Toothy'	,	'Rosy Boa'	,	2	,	1	,	'2017-01-21'	,	6	,	28	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Lucky'	,	'Miniature American Shepherds'	,	1	,	1	,	'2019-01-30'	,	3	,	29	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Piglet'	,	'Red Ratsnake'	,	2	,	1	,	'2019-01-18'	,	6	,	30	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Zoe'	,	'Poodles'	,	2	,	1	,	'2021-11-12'	,	3	,	31	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Miso'	,	'Fancy Goldfish'	,	1	,	1	,	'2021-09-13'	,	4	,	32	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Fluffy'	,	'Chinchilla’s '	,	1	,	1	,	'2020-02-15'	,	7	,	33	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Tweety'	,	'Hyacinth Macaws'	,	2	,	1	,	'2020-12-08'	,	1	,	34	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Snowball'	,	'Milk Snakes'	,	2	,	1	,	'2020-10-21'	,	6	,	35	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Daisy'	,	'Pionus Parrots'	,	2	,	1	,	'2017-09-15'	,	1	,	36	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Swedish'	,	'Freshwater Angelfish'	,	1	,	0	,	'2019-04-04'	,	4	,	37	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Cody'	,	'Cane Corso'	,	1	,	1	,	'2020-10-29'	,	3	,	38	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Blaster'	,	'Rabbit'	,	2	,	0	,	'2021-07-11'	,	7	,	39	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Annie'	,	'Doberman Pinschers'	,	2	,	1	,	'2020-03-17'	,	3	,	40	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Princess'	,	'Boxers'	,	2	,	1	,	'2021-11-10'	,	3	,	41	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Runt'	,	'Leopard Gecko'	,	1	,	1	,	'2020-12-27'	,	6	,	43	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Max'	,	'Norwegian Forest Cat'	,	1	,	1	,	'2018-07-25'	,	2	,	44	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Rosita'	,	'Tortoises'	,	2	,	1	,	'2019-12-18'	,	6	,	45	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Chloe'	,	'French Bulldogs'	,	2	,	1	,	'2019-10-22'	,	3	,	46	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Nala'	,	'Maine Coon'	,	2	,	1	,	'2021-01-27'	,	2	,	47	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Flotsam'	,	'Mbuna Cichlids'	,	1	,	1	,	'2018-08-14'	,	4	,	48	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Murphy'	,	'Spaniels (Cocker)'	,	1	,	0	,	'2018-02-22'	,	3	,	49	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Armageddon'	,	'Tonkinese'	,	1	,	1	,	'2021-01-17'	,	2	,	50	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Jewel'	,	'African Grey Parrots'	,	2	,	1	,	'2018-01-26'	,	1	,	51	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Lucy'	,	'Persian'	,	2	,	1	,	'2019-07-02'	,	2	,	52	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Angel'	,	'Yorkshire Terriers'	,	2	,	1	,	'2021-01-29'	,	3	,	53	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Max'	,	'Central Bearded Dragon'	,	1	,	1	,	'2021-03-11'	,	6	,	54	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Teddy'	,	'Border Collies'	,	1	,	1	,	'2018-03-12'	,	3	,	55	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Tiny'	,	'Mice'	,	1	,	0	,	'2017-07-21'	,	7	,	60	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Abby'	,	'Bulldogs'	,	2	,	1	,	'2020-01-02'	,	3	,	61	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Fluffy'	,	'Hamster'	,	2	,	1	,	'2020-03-12'	,	7	,	62	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Bugsy'	,	'Ferret '	,	1	,	1	,	'2021-11-04'	,	7	,	63	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Bella'	,	'British Shorthair'	,	2	,	1	,	'2017-02-21'	,	2	,	64	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Luna'	,	'Ragdoll'	,	2	,	1	,	'2017-04-18'	,	2	,	65	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Lily'	,	'Exotic Shorthair'	,	2	,	1	,	'2018-11-22'	,	2	,	67	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Roxy'	,	'Gerbil '	,	1	,	1	,	'2020-01-25'	,	7	,	68	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Sasha'	,	'Pembroke Welsh Corgis'	,	2	,	1	,	'2018-09-12'	,	3	,	69	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Flo'	,	'Royal Python'	,	1	,	1	,	'2021-05-17'	,	6	,	70	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Iago'	,	'Doves'	,	1	,	1	,	'2018-01-01'	,	1	,	71	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Simba'	,	'Bengal'	,	1	,	1	,	'2017-04-08'	,	2	,	72	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Kitty'	,	'Devon Rex'	,	2	,	0	,	'2019-10-23'	,	2	,	73	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Alvin'	,	'Guinea pig'	,	2	,	1	,	'2018-02-15'	,	7	,	74	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Cleo'	,	'Sphynx'	,	2	,	0	,	'2021-01-25'	,	2	,	78	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Duke'	,	'Boston Terriers'	,	1	,	1	,	'2019-05-02'	,	3	,	79	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Loki'	,	'Cornish Rex'	,	1	,	1	,	'2021-07-27'	,	2	,	81	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Woodstock'	,	'Parakeets or Budgies'	,	1	,	1	,	'2017-04-09'	,	1	,	82	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Beast'	,	'Crested Gecko'	,	2	,	0	,	'2017-10-20'	,	6	,	83	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Ollie'	,	'Siberian'	,	1	,	1	,	'2021-01-08'	,	2	,	88	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Jasper'	,	'Burmese'	,	1	,	0	,	'2017-07-16'	,	2	,	89	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Daffy'	,	'Cockatiels'	,	1	,	1	,	'2020-12-29'	,	1	,	90	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Chips'	,	'Oscars'	,	1	,	1	,	'2020-09-24'	,	4	,	91	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Cooper'	,	'Pomeranians'	,	1	,	0	,	'2017-08-05'	,	3	,	92	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Emma'	,	'Cavalier King Charles Spaniels'	,	2	,	1	,	'2018-04-26'	,	3	,	93	);
INSERT INTO PET (petID, petName, petBreed, GenderID, petStatus, birthDate, categoryID, customerID) VALUES (	petID.NEXTVAL	,	'Becky'	,	'Green-Cheeked Conures'	,	2	,	1	,	'2020-05-21'	,	1	,	94	);

-----------------------------------
-- Inserts - table SUPPLIERS
-----------------------------------
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00001'	,	'CPYOSN'	,	'Victoire Laurent'	,	'victoirelaurent@cpyosn.com'	,	42701404576	,	'https://CPYOSN.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00002'	,	'Arm & Hammer'	,	'Christelle Blanchard'	,	'christelleblanchard@armhammer.com'	,	40189254827	,	'https://ArmHammer.com'	,	1	,	0	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00003'	,	'Charming Pet'	,	'Valentine Martin'	,	'valentinemartin@charmingpet.com'	,	39846295328	,	'https://CharmingPet.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00004'	,	'SHARLOVY'	,	'Denis Gomez'	,	'denisgomez@sharlovy.com'	,	41891507128	,	'https://SHARLOVY.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00005'	,	'HuggleHounds'	,	'Gerard Herve'	,	'gerardherve@hugglehounds.com'	,	43159026150	,	'https://HuggleHounds.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00006'	,	'Petstages'	,	'Gregoire Riou'	,	'gregoireriou@petstages.com'	,	43614916484	,	'https://Petstages.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00007'	,	'Planet Dog'	,	'Lavinia Rocha'	,	'laviniarocha@planetdog.com'	,	40970963148	,	'https://PlanetDog.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00008'	,	'CAROZEN'	,	'Aurora Basadonna'	,	'aurorabasadonna@carozen.com'	,	43615909568	,	'https://CAROZEN.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00009'	,	'Nylabone'	,	'Benjamin Carlier'	,	'benjamincarlier@nylabone.com'	,	39150217880	,	'https://Nylabone.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00010'	,	'goDog'	,	'Fernanda Mata'	,	'fernandamata@godog.com'	,	38544505790	,	'https://goDog.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00011'	,	'JW Pet'	,	'Benjamin Williams'	,	'benjaminwilliams@jwpet.com'	,	42070423940	,	'https://JWPet.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00012'	,	'Sundrawy'	,	'Milena Gargallo'	,	'milenagargallo@sundrawy.com'	,	42586373168	,	'https://Sundrawy.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00013'	,	'Wilmotpets'	,	'Jacques Petit'	,	'Jacques_Petit@gmail.com'	,	43765048320	,	'https://Wilmotpets.com'	,	2	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00014'	,	'MULTIPET'	,	'Susanne Joubert'	,	'susannejoubert@multipet.com'	,	39524564689	,	'https://MULTIPET.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00015'	,	'KILIN'	,	'Matthew Blackwell'	,	'matthewblackwell@kilin.com'	,	43173865997	,	'https://KILIN.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00016'	,	'WeLovePets'	,	'Benjamin Pages'	,	'Benjamin_Pages@gmail.com'	,	42967982156	,	'https://WeLovePets.com'	,	2	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00017'	,	'ALL FOR PAWS'	,	'Sylvie Didier'	,	'sylviedidier@allforpaws.com'	,	42092858660	,	'https://ALLFORPAWS.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00018'	,	'petizer'	,	'Audrey Lelievre'	,	'audreylelievre@petizer.com'	,	42967983816	,	'https://petizer.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00019'	,	'Benebone'	,	'Aimee Monnier'	,	'aimeemonnier@benebone.com'	,	39280825032	,	'https://Benebone.com'	,	1	,	0	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00020'	,	'Nerf Dog'	,	'Victor Silva'	,	'victorsilva@nerfdog.com'	,	39601073294	,	'https://NerfDog.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00021'	,	'Toozey'	,	'Isis Costa'	,	'isiscosta@toozey.com'	,	40238278109	,	'https://Toozey.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00022'	,	'KONG'	,	'Henry Wilcox'	,	'henrywilcox@kong.com'	,	39041591394	,	'https://KONG.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00023'	,	'LEGEND SANDY'	,	'Lee Hall'	,	'leehall@legendsandy.com'	,	41038599120	,	'https://LEGENDSANDY.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00024'	,	'Star Wars'	,	'Traci Cole'	,	'tracicole@starwars.com'	,	42076898503	,	'https://StarWars.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00025'	,	'Hartz'	,	'Brenda Ribeiro'	,	'brendaribeiro@hartz.com'	,	38520629380	,	'https://Hartz.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00026'	,	'ZippyPaws'	,	'Eduarda Campos'	,	'eduardacampos@zippypaws.com'	,	39606797947	,	'https://ZippyPaws.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00027'	,	'CHIWAVA'	,	'Daniel Morris'	,	'danielmorris@chiwava.com'	,	41674599571	,	'https://CHIWAVA.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00028'	,	'Chuckit!'	,	'Andre Martin'	,	'andremartin@chuckit.com'	,	38546975053	,	'https://Chuckit.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00029'	,	'MIDOG'	,	'Renee Charpentier'	,	'reneecharpentier@midog.com'	,	45036618472	,	'https://MIDOG.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00030'	,	'Mypets'	,	'Belinda Dawson'	,	'Belinda_Dawson@gmail.com'	,	42586373142	,	'https://Mypets.com'	,	2	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00031'	,	'PetsLove'	,	'Melissa Watkins'	,	'Melissa_Watkins@gmail.com'	,	42076891250	,	'https://PetsLove.com'	,	2	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00032'	,	'Petsafe'	,	'Igor Cruz'	,	'igorcruz@petsafe.com'	,	40732524638	,	'https://Petsafe.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00033'	,	'WEST PAW'	,	'Roland Dumont'	,	'rolanddumont@westpaw.com'	,	41782398971	,	'https://WESTPAW.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00034'	,	'Tuffys'	,	'Denis Launay'	,	'denislaunay@tuffys.com'	,	42385363073	,	'https://Tuffys.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00035'	,	'PETIARKIT'	,	'Maite Moraes'	,	'maitemoraes@petiarkit.com'	,	43829799412	,	'https://PETIARKIT.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00036'	,	'Outward Hound'	,	'Caroline Monnier'	,	'carolinemonnier@outwardhound.com'	,	38279684094	,	'https://OutwardHound.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00037'	,	'Jolly Pets'	,	'Anne Lebon'	,	'annelebon@jollypets.com'	,	43765048270	,	'https://JollyPets.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00038'	,	'Youngever'	,	'Alfredo Mercantini'	,	'alfredomercantini@youngever.com'	,	45178953515	,	'https://Youngever.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00039'	,	'FOXMM'	,	'Ines Besson'	,	'inesbesson@foxmm.com'	,	42580629596	,	'https://FOXMM.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00040'	,	'Zeaxuie'	,	'Michele Marin'	,	'michelemarin@zeaxuie.com'	,	42893545841	,	'https://Zeaxuie.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00041'	,	'SmartPetLove'	,	'Tonya Jacobs'	,	'tonyajacobs@smartpetlove.com'	,	43098175743	,	'https://SmartPetLove.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00042'	,	'Pet Qwerks'	,	'Jessica Allen'	,	'jessicaallen@petqwerks.com'	,	41039728563	,	'https://PetQwerks.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00043'	,	'Starmark'	,	'Alix Buisson'	,	'alixbuisson@starmark.com'	,	42817683779	,	'https://Starmark.com'	,	1	,	1	);
INSERT INTO SUPPLIERS (supplierID,supplierCOD,supplierName,supplierContactPerson,supplierEmail,supplierContact_number,supplierWebsite,TypeID,supplierStatus) VALUES (	SUPPLIERID.NEXTVAL	,	'SUP00044'	,	'HugSmart'	,	'Alice Dumont'	,	'alicedumont@hugsmart.com'	,	43263419664	,	'https://HugSmart.com'	,	1	,	1	);

-----------------------------------
-- Inserts - table PRODUCT
-----------------------------------
SET DEFINE OFF
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00001'	,	'Carrot'	,	'Living World Nibblers Corn Husk Pet Chew, Carrot'	,	3	,	7	,	2.38	,	3.97	,	0	,	14	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00002'	,	'Rabbit Pellets'	,	'Rabbit Pellets, 5-Pound'	,	10	,	9	,	6.59	,	10.99	,	0	,	5	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00003'	,	'Fresh News Paper Small Animal Litter'	,	'Fresh News Paper Small Animal Litter, 10,000cc Gray 1 Count (Pack of 1)'	,	10	,	4	,	10.19	,	16.99	,	0	,	6	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00004'	,	'Small Animal Donuts '	,	'Living World Small Animal Donuts - 120 g (4.2 oz)'	,	8	,	1	,	2.75	,	4.59	,	0	,	7	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00005'	,	'Drops Hamster Treat'	,	'Living World Drops Hamster Treat, 2.6-Ounce, Field Berry'	,	3	,	6	,	2.38	,	3.97	,	0	,	8	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00006'	,	'Bed for Cats/Small Dogs'	,	'Bedsure Pet Tent Cave Bed for Cats/Small Dogs - 15x15x15 inches 2-in-1 Cat Tent/Kitten Bed/Cat Hut with Removable Washable Cushioned Pillow - Microfiber Indoor Outdoor Pet Beds, Light Grey'	,	10	,	10	,	20.99	,	34.99	,	0	,	9	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00007'	,	'Natural Small Animal Bedding'	,	'Kaytee Clean & Cozy Natural Small Animal Bedding, Expands to 49.2L'	,	10	,	8	,	15.59	,	25.99	,	0	,	10	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00008'	,	'Eco Plus Water Bottle'	,	'Living World Eco Plus Water Bottle, 12-Ounce'	,	10	,	2	,	5.38	,	8.97	,	0	,	24	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00009'	,	'Dog Water Bottle for Walking'	,	'Sofunii Dog Water Bottle for Walking, Portable Pet Travel Water Drink Cup Mug Dish Bowl Dispenser, Made of Food-Grade Material Leak Proof & BPA Free - 15oz Capacity (Blue)'	,	10	,	8	,	11.99	,	19.98	,	0	,	10	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00010'	,	'Pet Carrier'	,	'SHERPA Original Deluxe Airline Approved Pet Carrier, Medium, Black'	,	10	,	7	,	47.99	,	79.99	,	0	,	25	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00011'	,	'Automatic Cat Feeder'	,	'PETLIBRO Automatic Cat Feeder, Pet Dry Food Dispenser Triple Preservation with Stainless Steel Bowl & Twist Lock Lid, Up to 50 Portions 6 Meals Per Day, Granary for Small/Medium Pets'	,	10	,	3	,	53.99	,	89.99	,	0	,	1	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00012'	,	'Budgies Honey Treat Stick'	,	'Living World 80671 Budgies Honey Treat Sticks, 5.3-Ounce'	,	3	,	4	,	5.39	,	8.99	,	0	,	6	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00013'	,	'Pig Cage Liners'	,	'Guinea Pig Cage Liners, Absorbent Washable Reusable Guinea Pig Fleece Bedding for Midwest and C&C Cages with Leakproof Bottom'	,	10	,	3	,	8.09	,	13.49	,	0	,	36	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00014'	,	'Pet Carrier'	,	'X-ZONE PET Cat Carrier Dog Carrier Pet Carrier for Small Medium Cats Dogs Puppies of 15 Lbs,Airline Approved Soft Sided Pet Travel Carrier,Dog Carriers for Small Dogs - Black Grey Purple Blue Brown'	,	10	,	7	,	22.79	,	37.99	,	0	,	29	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00015'	,	'Shock Collar for Dogs'	,	'Shock Collar for Dogs(10-150 lbs) - 2600ft - IPX7 Waterproof - Dog Shock Collar with Remote for Small Medium Large Dogs Breeds – w/3 Modes - Humane'	,	10	,	3	,	41.99	,	69.99	,	0	,	35	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00016'	,	'Tunnel Collapsible'	,	'PAWZ Road Cat Tunnel Collapsible S Shape Cat Play Tube 10.5 Inches in Diameter'	,	2	,	1	,	16.79	,	27.99	,	0	,	6	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00017'	,	'Hamster Fruit Treat Sticks'	,	'Living World 60661 Hamster Fruit Treat Sticks, 4-Ounce'	,	3	,	3	,	3.59	,	5.98	,	0	,	20	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00018'	,	'Pet Bedding'	,	'Carefresh Complete Pet Bedding Bedding, Natural.'	,	10	,	5	,	20.99	,	34.99	,	0	,	23	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00019'	,	'Probiotics Chews'	,	'Dog Probiotics Chews - Gas, Diarrhea, Allergy, Constipation, Upset Stomach Relief, with Digestive Enzymes + Prebiotics - Chewable Fiber Supplement - Improve Digestion, Immunity - Made in USA - 120 Ct'	,	6	,	1	,	20.89	,	34.81	,	0	,	22	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00020'	,	'Advanced Odor Remover'	,	'ez-clean Advanced Odor Remover- Highly Concentrated Bio Enzyme - Pet Odor Eliminator for Dog, Cat, and Small Animal Urine - Indoor & Outdoor Use for Any Organic Spills(1 L Spray)'	,	10	,	3	,	11.97	,	19.95	,	0	,	29	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00021'	,	'White Bedding'	,	'Kaytee Clean & Cozy White Bedding Pet For Guinea Pigs, Rabbits, Hamsters, Gerbils, and Chinchillas, 49.2 Liters'	,	10	,	9	,	14.99	,	24.99	,	0	,	34	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00022'	,	'Wood Shavings'	,	'Living World Aspen Wood Shavings for Small Animals, Bedding & Nesting Material, 1200 Cubic Inches'	,	10	,	3	,	4.18	,	6.97	,	0	,	23	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00023'	,	'Drops Rabbit Treat'	,	'Living World Drops Rabbit Treat, 2.6-Ounce, Carrot'	,	10	,	5	,	2.38	,	3.97	,	0	,	9	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00024'	,	'Pet Odor Eliminator'	,	'Angry Orange Pet Odor Eliminator - Ready to Use, Citrus Carpet Deodorizer for Cats and Dogs - Deodorizing Spray for Carpets, Furniture, and Floors – Puppy Supplies'	,	10	,	10	,	14.99	,	24.99	,	0	,	4	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00025'	,	'Small Size Shock Collar'	,	'ABBIDOT Small Size Shock Collar for Dogs(8-120 lbs) - 3000 Ft Dog Training Collar Waterproof Bark Collar with Remote for Small Medium Large Dogs'	,	10	,	4	,	33.59	,	55.99	,	0	,	39	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00026'	,	'Classic Squirrel Pet Toys'	,	'All for Paws Classic Squirrel Pet Toys, Small'	,	2	,	10	,	7.49	,	12.49	,	0	,	21	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00027'	,	'Squeaky Latex Dog Toys'	,	'Chiwava 3 Pack 9" Squeaky Latex Dog Toys Standing Stick Animal Puppy Fetch Interactive Play for Small Medium Dogs'	,	2	,	9	,	13.79	,	22.98	,	0	,	1	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00028'	,	'Christmas Dog Toys'	,	'Christmas Dog Toys [2 Pack],Cute Plush Parody Dog Toys with Squeaker for Small,Medium,Large Dog Birthday Gift'	,	2	,	10	,	11.99	,	19.98	,	0	,	14	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00029'	,	'Indoor Ball'	,	'Chuckit! Indoor Ball'	,	2	,	5	,	7.79	,	12.99	,	0	,	27	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00030'	,	'Dog Ball'	,	'Dog Ball, Pakaserily Large Dog Soccer Ball 7.5inch Interactive Dog Toy Ball Fetch Treat Ball for Medium & Big Dogs Unchewable Soccer Ball for Dogs Indoor Outdoor Dog Tug Toy (25-90lbs),Christmas Gift'	,	2	,	9	,	18.59	,	30.99	,	0	,	38	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00031'	,	'Dog Toys for Aggressive Chewers'	,	'Dog Toys for Aggressive Chewers - Indestructible Durable Tough Dog Toys for Large Medium Dog Interactive Dog Toys for Large Breed'	,	2	,	4	,	11.99	,	19.99	,	0	,	9	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00032'	,	'Squeaky Goose for Large Breed'	,	'Dog Toys for Aggressive Chewers Indestructible Large Breed and Squeaky Goose for Large Breed'	,	2	,	1	,	7.19	,	11.99	,	0	,	39	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00033'	,	'Pineapple toy'	,	'FAIRWIN Ultra-Durable Dog Toys for Aggressive Chewer - Lifetime Replacement Guarantee - Indestructible Bite-Resistant Tough Chew Toys for Boredom Medium Large Dogs, Food Grade Non-Toxic Dental Pet Toy'	,	2	,	9	,	14.99	,	24.99	,	0	,	29	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00034'	,	'Dog Puzzle Toys '	,	'FOXMM Dog Puzzle Toys for Large Medium Small Dogs,Interactive Dog Toys for IQ Training & Mental Stimulating,Dog Enrichment Toys,Dog Treat Puzzle for Fun Slow Feeder'	,	2	,	7	,	14.39	,	23.99	,	0	,	39	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00035'	,	'Plush Duck Dog Toy'	,	'Hartz Natures Collection Quackers Plush Duck Dog Toy - Large'	,	2	,	1	,	5.98	,	9.97	,	0	,	22	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00036'	,	'Multipack Stuffingless Dog Squeaky'	,	'Jalousie Multipack Stuffingless Dog Squeaky Toys Dog Toy Dog with Durable Liner No Stuffing Dog Toy - Dog Toys for Pets Dogs for Small Medium Large Dogs (XLarge - 5 Pack)'	,	2	,	2	,	12.11	,	20.18	,	0	,	28	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00037'	,	'Puzzle Toys for IQ Training '	,	'Knitly Dog Puzzle Toys for IQ Training & Mental Enrichment, Interactive Dog Toys for Large Medium Small Dogs?Dog Treat Puzzle Dispensing Slow Feeder with Squeaky Design for Training & Fun Feeding'	,	2	,	8	,	14.39	,	23.99	,	0	,	22	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00038'	,	'Squeaky Toy Octopus'	,	'lifefav Dog Squeaky Toy Octopus, Interactive Dog Toy , Durable Dog Toys with Octopus Shape, Anti-Anxiety Soft Puppy Plush Dog Chew Toys for Puppy Small Medium Large Dogs Reduce Boredom Cleaning Teeth'	,	2	,	2	,	13.79	,	22.99	,	0	,	11	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00039'	,	'Treat Puzzle Dog Toy'	,	'Nina Ottosson by Outward Hound Dog Brick Interactive Treat Puzzle Dog Toy, Intermediate'	,	2	,	7	,	9.93	,	16.55	,	0	,	17	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00040'	,	'Hide and Seek Plush Dog Toys'	,	'Pet Craft Supply Hide and Seek Plush Dog Toys Crinkle Squeaky Interactive Burrow Activity Puzzle Chew Fetch Treat Hiding Brain Stimulating Cute Funny Toy Bundle Pack - Burrito'	,	2	,	4	,	7.52	,	12.53	,	0	,	17	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00041'	,	'Dog Bed Orthopedic'	,	'JOYELF Large Memory Foam Dog Bed Orthopedic Dog Bed & Sofa with Removable Washable Cover and Squeaker Toy as Gift'	,	10	,	8	,	59.99	,	99.99	,	0	,	35	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00042'	,	'Freeze Dried Raw Tantalizing Turkey Meal Mixer'	,	'Stella & Chewy’s Freeze Dried Raw Tantalizing Turkey Meal Mixer – Dog Food Topper for Small & Large Breeds – Grain Free, Protein Rich Recipe – 3.5 oz Bag'	,	3	,	1	,	6.05	,	10.08	,	0	,	40	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00043'	,	'Freeze-Dried Raw Maries Magical Dinner '	,	'Stella & Chewys Freeze-Dried Raw Maries Magical Dinner Dust Grass-Fed Beef Recipe Dog Food Topper, 7 oz'	,	3	,	10	,	11.30	,	18.84	,	0	,	25	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00044'	,	'Squeaky Dog'	,	'Squeaky Dog Toys Indestructible, No Stuffing Plush Dog Toys for Large Dogs, Interactive Dog Chew Toys with 2 Squeakers, Durable Tough Dog Toys Non-Toxic & Safe for Small and Medium Dogs'	,	2	,	3	,	17.57	,	29.29	,	0	,	9	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00045'	,	'Giggle Ball'	,	'Wobble Wag Giggle Ball, Interactive Dog Toy, Fun Giggle Sounds When Rolled or Shaken, Pets Know Best, As Seen On TV, NOT A CHEW TOY'	,	2	,	4	,	11.99	,	19.98	,	0	,	24	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00046'	,	'Tetra GloFish Half Moon Aquarium Kit'	,	'Aquaria 75029044: Tetra GloFish Half Moon Aquarium Kit, 3 Gal'	,	10	,	3	,	38.99	,	64.99	,	0	,	7	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00047'	,	'Triple Betta Bow Aquarium Tank'	,	'Penn-Plax Deluxe Triple Betta Bow Aquarium Tank, 0.7-Gallon'	,	10	,	2	,	19.18	,	31.97	,	0	,	15	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00048'	,	'Gallon Crescent Curved Fish Tank'	,	'Tetra Aquarium Kit, 5 Gallon Crescent Curved Fish Tank, Includes LED Lights and Filter'	,	10	,	10	,	61.97	,	103.29	,	0	,	33	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00049'	,	'Ecosystem Kit'	,	'SHRIMP BUBBLE Ecosystem Kit'	,	10	,	5	,	132.88	,	221.47	,	0	,	18	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00050'	,	'Free and Spill Free Aquarium Hook'	,	'Python Hands-Free and Spill Free Aquarium Hook, Green'	,	10	,	6	,	16.19	,	26.99	,	0	,	26	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00051'	,	'Back to the Roots Water Garden Fish Tank'	,	'Back to the Roots Water Garden Fish Tank, Deluxe'	,	10	,	3	,	71.39	,	118.98	,	0	,	5	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00052'	,	'Submersible Fish Tank Heater'	,	'NICREW Preset Aquarium Heater, Submersible Fish Tank Heater with Electronic Thermostat, UL Listed, 50W'	,	10	,	10	,	11.39	,	18.99	,	0	,	4	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00053'	,	'Aquarium Kit'	,	'Tetra Cube Aquarium Kit, 3 Gallon'	,	10	,	8	,	40.73	,	67.88	,	0	,	24	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00054'	,	'Glass LED Aquarium Kit'	,	'MarineLand Portrait Glass LED Aquarium Kit, 5 Gallons, Hidden Filtration, Clear (ML90609)'	,	10	,	9	,	100.27	,	167.11	,	0	,	37	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00055'	,	'CUBUS Glass Betta Kit'	,	'Marina 13485 CUBUS Glass Betta Kit'	,	10	,	1	,	33.13	,	55.22	,	0	,	34	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00056'	,	'Thermostat Fish Tank '	,	'Paste 500 Watt Submersible Aquarium Heater Auto Thermostat Fish Tank Heater 40-90 Gallon with Protective Sleeve and 3 Suckers'	,	10	,	9	,	22.19	,	36.99	,	0	,	29	,	0	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00057'	,	'Marina EZ Care Betta Kit'	,	'Marina EZ Care Betta Kit, Black'	,	10	,	1	,	20.99	,	34.98	,	0	,	6	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00058'	,	'Betta Falls for Aquarium'	,	'Aqueon Kit Betta Falls for Aquarium, Black'	,	10	,	10	,	59.82	,	99.70	,	0	,	25	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00059'	,	'Submersible Adjustable Aquarium Heater'	,	'HITOP 300W PTC Submersible Adjustable Aquarium Heater, for Fish Tank/Turtle Tank up to 80 Gallon (300W)'	,	10	,	2	,	20.93	,	34.89	,	0	,	5	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00060'	,	'Aquarium Water pH Raising Solution '	,	'API pH UP Freshwater Aquarium Water pH Raising Solution 1.25-Ounce Bottle'	,	10	,	3	,	4.79	,	7.98	,	0	,	1	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00061'	,	'Cat Toys Fish for Indoor'	,	'Cat Toys Fish for Indoor Cats - USB Floppy Fish Cat Dog Toy, Interactive Cat Toy with Catnip Bag, Realistic Moving Flippity Fish Toy for Cat and Kitten, Crucian Carp'	,	2	,	3	,	11.39	,	18.99	,	0	,	34	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00062'	,	'Dog Flirt Pole'	,	'Chasing Tails Flirt Pole For Dogs - Dog Flirt Pole, Dog Enrichment Toys, Interactive Dog Toys, Dog Exercise Equipment, Dog Rope Toy Pet Toys, Jouet Interactif Pour Chien, Dog Training Toys Dog Tug Toy'	,	2	,	7	,	19.79	,	32.99	,	0	,	18	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00063'	,	'Rope Fetch Dog Toys'	,	'Chuckit! 32220 CHUCKIT! Rope Fetch Dog Toys'	,	2	,	6	,	17.39	,	28.99	,	0	,	26	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00064'	,	'Cat Toy Ball'	,	'3.8 out of 5 stars?2,817'	,	2	,	3	,	9.11	,	15.18	,	0	,	28	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00065'	,	'Teaser Cat Toy'	,	'DILISS Feather Teaser Cat Toy, 2PCS Retractable Cat Wand Toys and 10PCS Replacement Teaser with Bell Refills, Interactive Catcher Teaser and Exercise Playing Toy for Kitten or Cats'	,	2	,	6	,	10.70	,	17.84	,	0	,	34	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00066'	,	'Cat Toys Ball with LED '	,	'Interactive Cat Toys Ball with LED Light & Catnip, Upgraded Ring Bell Feather Pet Toy, Auto Spinning Smart Cat Ball Toy, USB Rechargeable Stimulate Hunting Instinct Kitty Funny Chaser Roller'	,	2	,	5	,	11.99	,	19.99	,	0	,	6	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00067'	,	'Yellow Duck Plush Dog Toy'	,	'4.3 out of 5 stars 1,095'	,	2	,	5	,	11.66	,	19.44	,	0	,	22	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00068'	,	'Puppy Chew Ropes'	,	'Puppy Toys for Small Dogs, 7 Pack Dog Toy, Cute Durable Chew Ropes, 100% Natural Cotton Teething Toys for Pups, Non-Toxic and Safe'	,	2	,	4	,	11.99	,	19.99	,	0	,	15	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00069'	,	'Rope Toys for Dog'	,	'TRMESIA Dog Rope Toys for Dog,Dog Tug Toy for Large Dog Aggressive Chewers Dogs Rope Toys Indestructible Chew Toys Rope for Large and Medium Dog Cotton Rope Large Breed Dog Tug'	,	2	,	6	,	17.57	,	29.29	,	0	,	29	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00070'	,	'Bird Cage Flight Parrot House '	,	'PawHut 23" Bird Cage Flight Parrot House Cockatiels Playpen with Open Play Top and Feeding Bowl Perch Pet Furniture Black'	,	7	,	2	,	41.99	,	69.99	,	0	,	14	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00071'	,	'Roof Top Large Flight '	,	'Yaheetech Roof Top Large Flight Parakeet Parrot Bird Cage with Rolling Stand for Parakeets Cockatiels Lovebirds Finches Canaries Budgie Conure Small Parrot Bird Cage Birdcage'	,	7	,	9	,	83.99	,	139.99	,	0	,	11	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00072'	,	'Bird Cage Parrot Macaw '	,	'PawHut 30x20.5x54-Inch Bird Cage Parrot Macaw Finch Cockatoo Flight Cage with Wheels Black/White'	,	7	,	9	,	134.99	,	224.99	,	0	,	10	,	1	);
INSERT INTO PRODUCT (productID, productCOD, productName, productDetail, productCategoryID, quantityOnHand, suppliersPrice, retailPrice, discount, supplierID, Productstatus) VALUES (	productID.NEXTVAL	,	'PROD00073'	,	'Roof Top Large Flight Parrot Bird C'	,	'39-inch Roof Top Large Flight Parrot Bird Cage Accessories with Rolling Stand Medium Roof Top Large Flight cage for Small Cockatiel Canary Parakeet Sun Parakeet Conure Finches Budgie Lovebirds Pet Toy'	,	7	,	10	,	43.79	,	72.99	,	0	,	29	,	0	);

-----------------------------------
-- Inserts - table SERVICE
-----------------------------------
INSERT INTO SERVICE (serviceID, serviceCOD, serviceName, serviceDetail, productCategoryID, serviceFee, supplierid) VALUES (	serviceID.NEXTVAL	,	'SERV00001'	,	'Pet Walking'	,	'An hours walk for your pet to exercise and burn off energy. The value is per hour.'	,	11	,	 10.00 	 , 	16	);
INSERT INTO SERVICE (serviceID, serviceCOD, serviceName, serviceDetail, productCategoryID, serviceFee, supplierid) VALUES (	serviceID.NEXTVAL	,	'SERV00002'	,	'Pet Sitting'	,	'Pet sitting; in-Home Care for cats, dogs, lizards, birds, bunnies, fish, and chickens,  we have cared for it for you. The value is per hour.'	,	11	,	 15.00 	 , 	30	);
INSERT INTO SERVICE (serviceID, serviceCOD, serviceName, serviceDetail, productCategoryID, serviceFee, supplierid) VALUES (	serviceID.NEXTVAL	,	'SERV00003'	,	'Accommodation'	,	'Safe and pleasant place for your pet to stay wide awake while you are away. The value is per day.'	,	11	,	 50.00 	 , 	31	);

-----------------------------------
-- Inserts - table PRODUCTORDERDETAIL
-----------------------------------
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	441	,	20	,	1	,	19.95	,	19.95	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	506	,	36	,	1	,	20.18	,	20.18	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	383	,	17	,	1	,	5.98	,	5.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	497	,	48	,	1	,	103.29	,	103.29	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	217	,	6	,	1	,	34.99	,	34.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	291	,	15	,	1	,	69.99	,	69.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	261	,	21	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	523	,	7	,	1	,	25.99	,	25.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	442	,	29	,	2	,	12.99	,	25.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	398	,	6	,	2	,	34.99	,	69.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	94	,	47	,	3	,	31.97	,	95.91	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	224	,	5	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	212	,	48	,	1	,	103.29	,	103.29	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	440	,	22	,	1	,	6.97	,	6.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	356	,	22	,	1	,	6.97	,	6.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	393	,	11	,	1	,	89.99	,	89.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	219	,	9	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	344	,	4	,	1	,	4.59	,	4.59	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	176	,	17	,	1	,	5.98	,	5.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	206	,	12	,	3	,	8.99	,	26.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	86	,	38	,	2	,	22.99	,	45.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	398	,	5	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	485	,	12	,	2	,	8.99	,	17.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	477	,	47	,	1	,	31.97	,	31.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	101	,	43	,	2	,	18.84	,	37.68	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	12	,	29	,	2	,	12.99	,	25.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	325	,	6	,	2	,	34.99	,	69.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	10	,	23	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	213	,	38	,	1	,	22.99	,	22.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	179	,	28	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	19	,	7	,	3	,	25.99	,	77.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	143	,	26	,	1	,	12.49	,	12.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	230	,	35	,	1	,	9.97	,	9.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	96	,	42	,	3	,	10.08	,	30.24	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	119	,	1	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	549	,	26	,	1	,	12.49	,	12.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	150	,	42	,	1	,	10.08	,	10.08	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	141	,	42	,	1	,	10.08	,	10.08	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	29	,	7	,	1	,	25.99	,	25.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	392	,	31	,	3	,	19.99	,	59.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	48	,	3	,	4	,	16.99	,	67.96	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	64	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	367	,	25	,	3	,	55.99	,	167.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	281	,	21	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	496	,	25	,	1	,	55.99	,	55.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	458	,	41	,	1	,	99.99	,	99.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	60	,	3	,	4	,	16.99	,	67.96	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	453	,	51	,	3	,	118.98	,	356.94	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	474	,	38	,	3	,	22.99	,	68.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	418	,	22	,	1	,	6.97	,	6.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	261	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	295	,	21	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	132	,	53	,	3	,	67.88	,	203.64	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	254	,	7	,	3	,	25.99	,	77.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	129	,	33	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	149	,	4	,	1	,	4.59	,	4.59	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	270	,	18	,	1	,	34.99	,	34.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	359	,	19	,	1	,	34.81	,	34.81	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	80	,	43	,	1	,	18.84	,	18.84	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	55	,	52	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	485	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	342	,	41	,	1	,	99.99	,	99.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	368	,	29	,	1	,	12.99	,	12.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	308	,	2	,	1	,	10.99	,	10.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	372	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	132	,	38	,	1	,	22.99	,	22.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	380	,	51	,	2	,	118.98	,	237.96	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	145	,	41	,	3	,	99.99	,	299.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	521	,	45	,	2	,	19.98	,	39.96	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	490	,	3	,	1	,	16.99	,	16.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	271	,	11	,	2	,	89.99	,	179.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	238	,	47	,	1	,	31.97	,	31.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	215	,	52	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	445	,	8	,	1	,	8.97	,	8.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	535	,	28	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	423	,	40	,	2	,	12.53	,	25.06	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	163	,	38	,	1	,	22.99	,	22.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	159	,	41	,	1	,	99.99	,	99.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	172	,	3	,	1	,	16.99	,	16.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	452	,	46	,	2	,	64.99	,	129.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	234	,	24	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	80	,	10	,	1	,	79.99	,	79.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	204	,	8	,	1	,	8.97	,	8.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	177	,	22	,	2	,	6.97	,	13.94	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	2	,	22	,	1	,	6.97	,	6.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	60	,	7	,	1	,	25.99	,	25.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	178	,	45	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	524	,	12	,	1	,	8.99	,	8.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	377	,	13	,	2	,	13.49	,	26.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	22	,	42	,	1	,	10.08	,	10.08	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	514	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	224	,	51	,	3	,	118.98	,	356.94	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	523	,	17	,	3	,	5.98	,	17.94	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	80	,	9	,	2	,	19.98	,	39.96	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	321	,	22	,	1	,	6.97	,	6.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	445	,	36	,	3	,	20.18	,	60.54	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	487	,	14	,	1	,	37.99	,	37.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	308	,	9	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	397	,	32	,	1	,	11.99	,	11.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	88	,	41	,	1	,	99.99	,	99.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	92	,	50	,	1	,	26.99	,	26.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	17	,	3	,	1	,	16.99	,	16.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	13	,	48	,	2	,	103.29	,	206.58	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	149	,	15	,	1	,	69.99	,	69.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	32	,	37	,	1	,	23.99	,	23.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	307	,	12	,	1	,	8.99	,	8.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	479	,	24	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	348	,	30	,	4	,	30.99	,	123.96	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	449	,	5	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	419	,	1	,	2	,	3.97	,	7.94	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	313	,	34	,	1	,	23.99	,	23.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	81	,	26	,	1	,	12.49	,	12.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	245	,	36	,	1	,	20.18	,	20.18	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	360	,	26	,	1	,	12.49	,	12.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	402	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	232	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	148	,	52	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	535	,	10	,	1	,	79.99	,	79.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	264	,	33	,	3	,	24.99	,	74.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	533	,	38	,	1	,	22.99	,	22.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	284	,	21	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	304	,	1	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	142	,	53	,	2	,	67.88	,	135.76	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	2	,	53	,	2	,	67.88	,	135.76	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	262	,	32	,	1	,	11.99	,	11.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	157	,	4	,	3	,	4.59	,	13.77	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	170	,	9	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	294	,	18	,	1	,	34.99	,	34.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	11	,	30	,	4	,	30.99	,	123.96	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	423	,	6	,	3	,	34.99	,	104.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	215	,	11	,	2	,	89.99	,	179.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	71	,	27	,	2	,	22.98	,	45.96	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	152	,	28	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	5	,	41	,	1	,	99.99	,	99.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	502	,	21	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	202	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	303	,	45	,	2	,	19.98	,	39.96	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	258	,	16	,	2	,	27.99	,	55.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	4	,	32	,	1	,	11.99	,	11.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	162	,	9	,	3	,	19.98	,	59.94	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	272	,	27	,	1	,	22.98	,	22.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	71	,	51	,	1	,	118.98	,	118.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	517	,	4	,	1	,	4.59	,	4.59	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	501	,	31	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	264	,	54	,	1	,	167.11	,	167.11	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	263	,	65	,	1	,	17.84	,	17.84	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	271	,	39	,	1	,	16.55	,	16.55	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	449	,	52	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	29	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	110	,	8	,	1	,	8.97	,	8.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	500	,	66	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	523	,	65	,	1	,	17.84	,	17.84	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	211	,	33	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	484	,	21	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	224	,	37	,	1	,	23.99	,	23.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	102	,	16	,	1	,	27.99	,	27.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	466	,	4	,	1	,	4.59	,	4.59	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	496	,	56	,	1	,	36.99	,	36.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	338	,	24	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	339	,	59	,	1	,	34.89	,	34.89	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	465	,	70	,	1	,	69.99	,	69.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	131	,	66	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	254	,	26	,	1	,	12.49	,	12.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	439	,	49	,	1	,	221.47	,	221.47	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	381	,	39	,	1	,	16.55	,	16.55	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	488	,	49	,	1	,	221.47	,	221.47	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	258	,	43	,	1	,	18.84	,	18.84	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	108	,	71	,	1	,	139.99	,	139.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	303	,	59	,	1	,	34.89	,	34.89	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	314	,	17	,	1	,	5.98	,	5.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	254	,	58	,	1	,	99.7	,	99.7	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	235	,	40	,	1	,	12.53	,	12.53	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	450	,	27	,	1	,	22.98	,	22.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	535	,	17	,	1	,	5.98	,	5.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	244	,	22	,	1	,	6.97	,	6.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	343	,	29	,	1	,	12.99	,	12.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	284	,	59	,	1	,	34.89	,	34.89	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	15	,	27	,	1	,	22.98	,	22.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	444	,	44	,	1	,	29.29	,	29.29	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	337	,	54	,	1	,	167.11	,	167.11	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	117	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	76	,	23	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	77	,	23	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	454	,	73	,	1	,	72.99	,	72.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	95	,	40	,	1	,	12.53	,	12.53	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	20	,	23	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	359	,	17	,	1	,	5.98	,	5.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	229	,	18	,	1	,	34.99	,	34.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	275	,	32	,	1	,	11.99	,	11.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	409	,	38	,	1	,	22.99	,	22.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	241	,	4	,	1	,	4.59	,	4.59	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	244	,	67	,	1	,	19.44	,	19.44	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	420	,	41	,	2	,	99.99	,	199.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	325	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	403	,	4	,	1	,	4.59	,	4.59	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	305	,	63	,	1	,	28.99	,	28.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	417	,	45	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	365	,	15	,	1	,	69.99	,	69.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	372	,	64	,	1	,	15.18	,	15.18	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	101	,	27	,	1	,	22.98	,	22.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	506	,	61	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	76	,	36	,	1	,	20.18	,	20.18	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	440	,	28	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	175	,	47	,	1	,	31.97	,	31.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	428	,	25	,	1	,	55.99	,	55.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	118	,	47	,	1	,	31.97	,	31.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	339	,	27	,	1	,	22.98	,	22.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	211	,	48	,	1	,	103.29	,	103.29	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	27	,	61	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	313	,	12	,	2	,	8.99	,	17.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	187	,	59	,	1	,	34.89	,	34.89	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	40	,	49	,	22	,	221.47	,	4872.34	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	221	,	20	,	1	,	19.95	,	19.95	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	537	,	20	,	1	,	19.95	,	19.95	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	419	,	4	,	1	,	4.59	,	4.59	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	28	,	51	,	1	,	118.98	,	118.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	102	,	30	,	1	,	30.99	,	30.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	536	,	61	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	469	,	60	,	1	,	7.98	,	7.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	485	,	31	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	167	,	35	,	1	,	9.97	,	9.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	231	,	32	,	1	,	11.99	,	11.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	363	,	4	,	1	,	4.59	,	4.59	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	322	,	5	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	374	,	66	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	105	,	51	,	1	,	118.98	,	118.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	439	,	31	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	228	,	24	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	370	,	21	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	39	,	55	,	1	,	55.22	,	55.22	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	53	,	27	,	1	,	22.98	,	22.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	530	,	63	,	1	,	28.99	,	28.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	442	,	52	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	426	,	8	,	1	,	8.97	,	8.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	265	,	30	,	1	,	30.99	,	30.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	151	,	1	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	298	,	60	,	1	,	7.98	,	7.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	40	,	49	,	1	,	221.47	,	221.47	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	318	,	31	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	406	,	61	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	548	,	48	,	1	,	103.29	,	103.29	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	375	,	15	,	1	,	69.99	,	69.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	52	,	67	,	1	,	19.44	,	19.44	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	171	,	39	,	1	,	16.55	,	16.55	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	285	,	2	,	1	,	10.99	,	10.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	447	,	38	,	1	,	22.99	,	22.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	387	,	6	,	2	,	34.99	,	69.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	406	,	14	,	1	,	37.99	,	37.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	249	,	41	,	1	,	99.99	,	99.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	2	,	55	,	1	,	55.22	,	55.22	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	189	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	318	,	58	,	1	,	99.7	,	99.7	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	239	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	115	,	28	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	94	,	58	,	1	,	99.7	,	99.7	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	466	,	10	,	1	,	79.99	,	79.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	394	,	18	,	1	,	34.99	,	34.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	351	,	44	,	1	,	29.29	,	29.29	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	390	,	17	,	1	,	5.98	,	5.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	92	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	459	,	52	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	95	,	34	,	1	,	23.99	,	23.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	210	,	23	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	196	,	9	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	67	,	41	,	1	,	99.99	,	99.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	109	,	39	,	1	,	16.55	,	16.55	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	537	,	27	,	1	,	22.98	,	22.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	433	,	35	,	1	,	9.97	,	9.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	307	,	33	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	275	,	58	,	1	,	99.7	,	99.7	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	482	,	73	,	2	,	72.99	,	145.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	405	,	31	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	331	,	56	,	1	,	36.99	,	36.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	90	,	30	,	1	,	30.99	,	30.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	103	,	21	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	90	,	45	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	447	,	56	,	1	,	36.99	,	36.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	329	,	9	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	504	,	7	,	1	,	25.99	,	25.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	50	,	66	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	76	,	27	,	1	,	22.98	,	22.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	234	,	8	,	1	,	8.97	,	8.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	184	,	60	,	1	,	7.98	,	7.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	175	,	2	,	1	,	10.99	,	10.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	185	,	49	,	1	,	221.47	,	221.47	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	443	,	6	,	1	,	34.99	,	34.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	312	,	67	,	1	,	19.44	,	19.44	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	451	,	57	,	1	,	34.98	,	34.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	25	,	49	,	1	,	221.47	,	221.47	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	167	,	9	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	272	,	2	,	1	,	10.99	,	10.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	514	,	61	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	216	,	17	,	1	,	5.98	,	5.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	236	,	45	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	308	,	16	,	2	,	27.99	,	55.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	257	,	23	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	236	,	45	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	506	,	42	,	1	,	10.08	,	10.08	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	131	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	504	,	9	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	214	,	22	,	1	,	6.97	,	6.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	31	,	66	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	497	,	26	,	1	,	12.49	,	12.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	503	,	70	,	1	,	69.99	,	69.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	332	,	55	,	1	,	55.22	,	55.22	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	276	,	1	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	352	,	54	,	1	,	167.11	,	167.11	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	83	,	64	,	1	,	15.18	,	15.18	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	336	,	47	,	1	,	31.97	,	31.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	445	,	3	,	1	,	16.99	,	16.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	121	,	60	,	1	,	7.98	,	7.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	244	,	57	,	1	,	34.98	,	34.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	525	,	58	,	1	,	99.7	,	99.7	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	388	,	23	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	385	,	34	,	1	,	23.99	,	23.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	533	,	69	,	1	,	29.29	,	29.29	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	220	,	67	,	1	,	19.44	,	19.44	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	92	,	8	,	1	,	8.97	,	8.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	361	,	42	,	1	,	10.08	,	10.08	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	76	,	40	,	1	,	12.53	,	12.53	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	364	,	49	,	1	,	221.47	,	221.47	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	164	,	52	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	128	,	73	,	1	,	72.99	,	72.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	269	,	19	,	1	,	34.81	,	34.81	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	482	,	37	,	1	,	23.99	,	23.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	96	,	43	,	1	,	18.84	,	18.84	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	138	,	47	,	1	,	31.97	,	31.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	380	,	43	,	1	,	18.84	,	18.84	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	349	,	69	,	1	,	29.29	,	29.29	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	456	,	18	,	1	,	34.99	,	34.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	135	,	53	,	1	,	67.88	,	67.88	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	44	,	24	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	394	,	42	,	1	,	10.08	,	10.08	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	131	,	69	,	2	,	29.29	,	58.58	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	26	,	55	,	1	,	55.22	,	55.22	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	317	,	43	,	1	,	18.84	,	18.84	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	88	,	29	,	1	,	12.99	,	12.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	7	,	37	,	1	,	23.99	,	23.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	327	,	42	,	1	,	10.08	,	10.08	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	160	,	71	,	1	,	139.99	,	139.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	250	,	71	,	1	,	139.99	,	139.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	399	,	32	,	1	,	11.99	,	11.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	430	,	27	,	1	,	22.98	,	22.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	41	,	42	,	1	,	10.08	,	10.08	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	183	,	33	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	346	,	2	,	1	,	10.99	,	10.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	213	,	43	,	1	,	18.84	,	18.84	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	306	,	19	,	1	,	34.81	,	34.81	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	118	,	10	,	1	,	79.99	,	79.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	516	,	19	,	1	,	34.81	,	34.81	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	485	,	29	,	1	,	12.99	,	12.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	44	,	25	,	1	,	55.99	,	55.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	489	,	69	,	1	,	29.29	,	29.29	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	491	,	47	,	1	,	31.97	,	31.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	541	,	14	,	1	,	37.99	,	37.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	225	,	68	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	215	,	23	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	136	,	56	,	1	,	36.99	,	36.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	98	,	41	,	1	,	99.99	,	99.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	353	,	59	,	1	,	34.89	,	34.89	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	148	,	39	,	1	,	16.55	,	16.55	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	81	,	12	,	1	,	8.99	,	8.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	493	,	14	,	1	,	37.99	,	37.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	348	,	43	,	1	,	18.84	,	18.84	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	257	,	58	,	1	,	99.7	,	99.7	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	464	,	65	,	1	,	17.84	,	17.84	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	252	,	27	,	1	,	22.98	,	22.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	58	,	61	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	414	,	54	,	1	,	167.11	,	167.11	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	483	,	61	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	144	,	40	,	1	,	12.53	,	12.53	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	213	,	62	,	1	,	32.99	,	32.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	147	,	36	,	1	,	20.18	,	20.18	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	48	,	61	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	289	,	70	,	1	,	69.99	,	69.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	543	,	5	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	466	,	72	,	1	,	224.99	,	224.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	508	,	20	,	1	,	19.95	,	19.95	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	218	,	69	,	1	,	29.29	,	29.29	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	534	,	60	,	1	,	7.98	,	7.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	199	,	31	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	154	,	31	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	477	,	32	,	1	,	11.99	,	11.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	67	,	73	,	1	,	72.99	,	72.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	504	,	58	,	1	,	99.7	,	99.7	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	91	,	10	,	1	,	79.99	,	79.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	332	,	48	,	1	,	103.29	,	103.29	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	414	,	58	,	1	,	99.7	,	99.7	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	288	,	47	,	1	,	31.97	,	31.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	101	,	1	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	179	,	71	,	1	,	139.99	,	139.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	399	,	14	,	1	,	37.99	,	37.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	331	,	57	,	1	,	34.98	,	34.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	334	,	32	,	1	,	11.99	,	11.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	120	,	30	,	1	,	30.99	,	30.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	208	,	34	,	1	,	23.99	,	23.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	236	,	60	,	1	,	7.98	,	7.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	543	,	35	,	1	,	9.97	,	9.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	60	,	7	,	1	,	25.99	,	25.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	331	,	71	,	1	,	139.99	,	139.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	2	,	1	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	181	,	6	,	1	,	34.99	,	34.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	444	,	31	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	244	,	44	,	1	,	29.29	,	29.29	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	81	,	29	,	1	,	12.99	,	12.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	388	,	23	,	3	,	3.97	,	11.91	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	343	,	18	,	1	,	34.99	,	34.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	46	,	53	,	1	,	67.88	,	67.88	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	500	,	36	,	1	,	20.18	,	20.18	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	371	,	28	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	314	,	18	,	1	,	34.99	,	34.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	4	,	63	,	1	,	28.99	,	28.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	442	,	6	,	1	,	34.99	,	34.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	11	,	71	,	1	,	139.99	,	139.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	438	,	71	,	1	,	139.99	,	139.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	87	,	65	,	1	,	17.84	,	17.84	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	343	,	25	,	1	,	55.99	,	55.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	202	,	59	,	1	,	34.89	,	34.89	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	356	,	46	,	1	,	64.99	,	64.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	455	,	24	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	300	,	7	,	1	,	25.99	,	25.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	122	,	28	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	382	,	14	,	1	,	37.99	,	37.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	366	,	22	,	1	,	6.97	,	6.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	103	,	19	,	1	,	34.81	,	34.81	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	224	,	29	,	1	,	12.99	,	12.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	400	,	49	,	1	,	221.47	,	221.47	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	304	,	63	,	1	,	28.99	,	28.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	521	,	42	,	1	,	10.08	,	10.08	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	104	,	15	,	1	,	69.99	,	69.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	275	,	18	,	1	,	34.99	,	34.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	435	,	33	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	238	,	43	,	1	,	18.84	,	18.84	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	96	,	12	,	1	,	8.99	,	8.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	65	,	60	,	1	,	7.98	,	7.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	380	,	26	,	1	,	12.49	,	12.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	354	,	67	,	1	,	19.44	,	19.44	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	520	,	73	,	1	,	72.99	,	72.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	41	,	70	,	1	,	69.99	,	69.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	72	,	37	,	1	,	23.99	,	23.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	551	,	20	,	1	,	19.95	,	19.95	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	395	,	36	,	1	,	20.18	,	20.18	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	147	,	19	,	1	,	34.81	,	34.81	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	540	,	4	,	1	,	4.59	,	4.59	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	376	,	35	,	1	,	9.97	,	9.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	167	,	49	,	1	,	221.47	,	221.47	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	224	,	10	,	1	,	79.99	,	79.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	353	,	50	,	1	,	26.99	,	26.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	36	,	26	,	1	,	12.49	,	12.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	552	,	29	,	1	,	12.99	,	12.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	54	,	31	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	293	,	32	,	1	,	11.99	,	11.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	529	,	5	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	171	,	16	,	1	,	27.99	,	27.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	26	,	60	,	1	,	7.98	,	7.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	231	,	57	,	1	,	34.98	,	34.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	54	,	40	,	1	,	12.53	,	12.53	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	501	,	43	,	1	,	18.84	,	18.84	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	475	,	37	,	1	,	23.99	,	23.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	88	,	62	,	1	,	32.99	,	32.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	241	,	40	,	1	,	12.53	,	12.53	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	381	,	10	,	1	,	79.99	,	79.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	401	,	49	,	1	,	221.47	,	221.47	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	39	,	41	,	1	,	99.99	,	99.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	217	,	37	,	1	,	23.99	,	23.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	409	,	24	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	515	,	5	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	179	,	62	,	1	,	32.99	,	32.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	198	,	25	,	1	,	55.99	,	55.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	300	,	9	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	193	,	11	,	1	,	89.99	,	89.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	505	,	5	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	311	,	65	,	1	,	17.84	,	17.84	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	149	,	39	,	1	,	16.55	,	16.55	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	517	,	34	,	1	,	23.99	,	23.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	194	,	43	,	1	,	18.84	,	18.84	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	141	,	12	,	1	,	8.99	,	8.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	241	,	14	,	1	,	37.99	,	37.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	46	,	40	,	1	,	12.53	,	12.53	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	99	,	26	,	1	,	12.49	,	12.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	310	,	70	,	1	,	69.99	,	69.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	468	,	28	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	195	,	23	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	47	,	39	,	1	,	16.55	,	16.55	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	499	,	70	,	1	,	69.99	,	69.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	498	,	51	,	1	,	118.98	,	118.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	421	,	36	,	1	,	20.18	,	20.18	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	261	,	2	,	1	,	10.99	,	10.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	29	,	40	,	1	,	12.53	,	12.53	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	88	,	56	,	1	,	36.99	,	36.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	384	,	32	,	1	,	11.99	,	11.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	308	,	71	,	1	,	139.99	,	139.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	27	,	20	,	1	,	19.95	,	19.95	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	176	,	62	,	1	,	32.99	,	32.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	14	,	37	,	1	,	23.99	,	23.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	500	,	35	,	1	,	9.97	,	9.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	277	,	53	,	1	,	67.88	,	67.88	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	295	,	59	,	1	,	34.89	,	34.89	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	384	,	11	,	1	,	89.99	,	89.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	417	,	51	,	1	,	118.98	,	118.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	168	,	59	,	1	,	34.89	,	34.89	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	46	,	64	,	1	,	15.18	,	15.18	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	407	,	5	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	122	,	71	,	1	,	139.99	,	139.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	150	,	5	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	316	,	70	,	1	,	69.99	,	69.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	445	,	8	,	1	,	8.97	,	8.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	198	,	71	,	1	,	139.99	,	139.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	338	,	29	,	1	,	12.99	,	12.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	446	,	60	,	1	,	7.98	,	7.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	245	,	8	,	1	,	8.97	,	8.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	550	,	28	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	374	,	26	,	1	,	12.49	,	12.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	181	,	43	,	1	,	18.84	,	18.84	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	437	,	44	,	1	,	29.29	,	29.29	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	300	,	67	,	1	,	19.44	,	19.44	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	337	,	66	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	122	,	25	,	1	,	55.99	,	55.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	510	,	8	,	1	,	8.97	,	8.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	266	,	40	,	1	,	12.53	,	12.53	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	81	,	44	,	1	,	29.29	,	29.29	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	233	,	35	,	1	,	9.97	,	9.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	163	,	25	,	1	,	55.99	,	55.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	77	,	47	,	1	,	31.97	,	31.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	368	,	31	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	440	,	48	,	1	,	103.29	,	103.29	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	183	,	2	,	1	,	10.99	,	10.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	296	,	62	,	1	,	32.99	,	32.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	505	,	3	,	1	,	16.99	,	16.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	191	,	5	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	514	,	55	,	1	,	55.22	,	55.22	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	542	,	52	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	240	,	70	,	1	,	69.99	,	69.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	523	,	27	,	1	,	22.98	,	22.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	290	,	36	,	1	,	20.18	,	20.18	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	450	,	66	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	106	,	49	,	1	,	221.47	,	221.47	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	215	,	28	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	126	,	73	,	1	,	72.99	,	72.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	144	,	59	,	1	,	34.89	,	34.89	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	57	,	51	,	1	,	118.98	,	118.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	297	,	42	,	1	,	10.08	,	10.08	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	93	,	10	,	1	,	79.99	,	79.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	239	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	544	,	35	,	1	,	9.97	,	9.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	333	,	36	,	1	,	20.18	,	20.18	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	338	,	24	,	1	,	24.99	,	24.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	100	,	71	,	1	,	139.99	,	139.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	341	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	544	,	66	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	412	,	28	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	449	,	47	,	1	,	31.97	,	31.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	445	,	62	,	1	,	32.99	,	32.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	180	,	10	,	1	,	79.99	,	79.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	435	,	5	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	32	,	20	,	1	,	19.95	,	19.95	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	161	,	37	,	1	,	23.99	,	23.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	477	,	18	,	1	,	34.99	,	34.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	81	,	59	,	1	,	34.89	,	34.89	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	254	,	36	,	1	,	20.18	,	20.18	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	495	,	72	,	1	,	224.99	,	224.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	478	,	67	,	1	,	19.44	,	19.44	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	307	,	10	,	1	,	79.99	,	79.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	399	,	57	,	1	,	34.98	,	34.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	524	,	26	,	1	,	12.49	,	12.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	98	,	54	,	1	,	167.11	,	167.11	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	174	,	23	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	391	,	14	,	1	,	37.99	,	37.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	400	,	28	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	43	,	4	,	1	,	4.59	,	4.59	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	5	,	41	,	2	,	99.99	,	199.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	287	,	7	,	1	,	25.99	,	25.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	518	,	35	,	1	,	9.97	,	9.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	156	,	44	,	1	,	29.29	,	29.29	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	171	,	64	,	1	,	15.18	,	15.18	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	220	,	66	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	14	,	25	,	1	,	55.99	,	55.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	370	,	3	,	1	,	16.99	,	16.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	126	,	51	,	1	,	118.98	,	118.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	180	,	71	,	1	,	139.99	,	139.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	453	,	67	,	1	,	19.44	,	19.44	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	41	,	34	,	1	,	23.99	,	23.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	276	,	68	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	498	,	65	,	1	,	17.84	,	17.84	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	23	,	19	,	1	,	34.81	,	34.81	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	516	,	11	,	1	,	89.99	,	89.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	439	,	37	,	1	,	23.99	,	23.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	499	,	66	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	537	,	30	,	1	,	30.99	,	30.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	179	,	27	,	1	,	22.98	,	22.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	365	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	549	,	6	,	3	,	34.99	,	104.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	188	,	17	,	1	,	5.98	,	5.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	415	,	57	,	1	,	34.98	,	34.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	59	,	30	,	1	,	30.99	,	30.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	266	,	46	,	1	,	64.99	,	64.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	468	,	3	,	1	,	16.99	,	16.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	512	,	72	,	1	,	224.99	,	224.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	527	,	4	,	1	,	4.59	,	4.59	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	314	,	64	,	1	,	15.18	,	15.18	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	18	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	320	,	72	,	1	,	224.99	,	224.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	178	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	332	,	52	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	86	,	64	,	1	,	15.18	,	15.18	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	530	,	52	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	172	,	27	,	1	,	22.98	,	22.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	248	,	4	,	1	,	4.59	,	4.59	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	495	,	23	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	356	,	31	,	1	,	19.99	,	19.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	493	,	23	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	30	,	59	,	1	,	34.89	,	34.89	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	49	,	41	,	1	,	99.99	,	99.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	165	,	23	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	132	,	36	,	1	,	20.18	,	20.18	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	45	,	29	,	2	,	12.99	,	25.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	516	,	36	,	1	,	20.18	,	20.18	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	263	,	52	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	39	,	7	,	1	,	25.99	,	25.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	232	,	50	,	1	,	26.99	,	26.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	149	,	51	,	1	,	118.98	,	118.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	33	,	59	,	1	,	34.89	,	34.89	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	294	,	2	,	1	,	10.99	,	10.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	433	,	47	,	1	,	31.97	,	31.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	257	,	32	,	1	,	11.99	,	11.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	552	,	28	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	452	,	41	,	1	,	99.99	,	99.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	173	,	47	,	1	,	31.97	,	31.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	289	,	40	,	1	,	12.53	,	12.53	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	60	,	5	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	467	,	46	,	1	,	64.99	,	64.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	529	,	50	,	1	,	26.99	,	26.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	228	,	7	,	1	,	25.99	,	25.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	514	,	40	,	1	,	12.53	,	12.53	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	30	,	61	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	545	,	45	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	157	,	52	,	1	,	18.99	,	18.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	63	,	40	,	1	,	12.53	,	12.53	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	210	,	29	,	1	,	12.99	,	12.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	542	,	64	,	1	,	15.18	,	15.18	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	522	,	9	,	1	,	19.98	,	19.98	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	104	,	18	,	1	,	34.99	,	34.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	484	,	50	,	1	,	26.99	,	26.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	85	,	64	,	1	,	15.18	,	15.18	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	130	,	4	,	1	,	4.59	,	4.59	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	21	,	34	,	1	,	23.99	,	23.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	342	,	43	,	1	,	18.84	,	18.84	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	211	,	39	,	1	,	16.55	,	16.55	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	86	,	2	,	1	,	10.99	,	10.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	119	,	22	,	1	,	6.97	,	6.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	507	,	56	,	1	,	36.99	,	36.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	248	,	13	,	1	,	13.49	,	13.49	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	249	,	72	,	1	,	224.99	,	224.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	181	,	7	,	1	,	25.99	,	25.99	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	454	,	42	,	1	,	10.08	,	10.08	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	207	,	5	,	1	,	3.97	,	3.97	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	452	,	55	,	1	,	55.22	,	55.22	,	13	);
INSERT INTO PRODUCTORDERDETAIL (productOrderDetailID, orderID, productID, prodQuantity, prodPrice, productTotal, taxrate) VALUES (	productOrderDetailID.NEXTVAL	,	411	,	1	,	1	,	3.97	,	3.97	,	13	);

-----------------------------------
-- Inserts - table SERVICEORDERDETAIL
-----------------------------------
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	1	,	3	,	1	,	50	,	50	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	3	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	6	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	8	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	9	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	16	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	24	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	34	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	35	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	37	,	3	,	10	,	50	,	500	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	38	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	42	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	51	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	56	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	61	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	62	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	66	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	68	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	69	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	70	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	73	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	74	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	75	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	78	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	79	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	82	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	84	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	89	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	97	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	107	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	111	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	112	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	113	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	114	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	116	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	123	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	124	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	125	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	127	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	133	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	134	,	3	,	3	,	50	,	150	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	137	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	139	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	140	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	146	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	153	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	155	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	158	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	166	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	169	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	182	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	186	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	190	,	3	,	3	,	50	,	150	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	192	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	197	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	200	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	201	,	3	,	5	,	50	,	250	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	203	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	205	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	209	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	222	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	223	,	3	,	4	,	50	,	200	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	226	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	227	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	237	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	242	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	243	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	246	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	247	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	251	,	3	,	1	,	50	,	50	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	253	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	255	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	256	,	3	,	1	,	50	,	50	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	259	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	260	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	267	,	3	,	1	,	50	,	50	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	268	,	3	,	1	,	50	,	50	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	273	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	274	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	278	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	279	,	3	,	1	,	50	,	50	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	280	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	282	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	283	,	3	,	1	,	50	,	50	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	286	,	3	,	1	,	50	,	50	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	292	,	3	,	1	,	50	,	50	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	299	,	3	,	1	,	50	,	50	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	301	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	302	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	309	,	3	,	1	,	50	,	50	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	315	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	319	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	323	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	324	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	326	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	328	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	330	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	335	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	340	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	345	,	3	,	1	,	50	,	50	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	347	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	350	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	355	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	357	,	3	,	1	,	50	,	50	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	358	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	362	,	3	,	1	,	50	,	50	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	369	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	373	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	378	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	379	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	386	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	389	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	396	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	404	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	408	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	410	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	413	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	416	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	422	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	424	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	425	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	427	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	429	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	431	,	3	,	3	,	50	,	150	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	432	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	434	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	436	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	448	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	457	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	460	,	3	,	4	,	50	,	200	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	461	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	462	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	463	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	470	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	471	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	472	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	473	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	476	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	480	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	481	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	486	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	492	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	494	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	509	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	511	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	513	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	519	,	3	,	20	,	50	,	1000	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	526	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	528	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	531	,	3	,	2	,	50	,	100	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	532	,	3	,	1	,	50	,	50	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	538	,	1	,	1	,	10	,	10	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	539	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	546	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	547	,	2	,	1	,	15	,	15	,	13	);
INSERT INTO SERVICEORDERDETAIL (serviceOrderDetailID, orderID, serviceID, serviceQuantity, servicePrice, serviceTotal,taxrate) VALUES (	serviceOrderDetailID.NEXTVAL	,	553	,	2	,	1	,	15	,	15	,	13	);


COMMIT;