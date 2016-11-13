drop database palermodev;

create database palermodev;
use palermodev;

CREATE TABLE users(
    ID              INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT
    ,UserName       VARCHAR(30)
    ,Password       VARCHAR(30) #todo make me secure
    ,Driver         BOOL
    ,DateAdded      DATETIME
    ,IsManager      BOOL
);

CREATE TABLE customers(
   ID                   INTEGER  NOT NULL PRIMARY KEY AUTO_INCREMENT
  ,Phone                VARCHAR(10)     
  ,LastName             VARCHAR(40)    
  ,FirstName            VARCHAR(20)     
  ,AddressNumber        VARCHAR(10)     
  ,StreetName           VARCHAR(30)     
  ,City                 VARCHAR(20)     
  ,State                VARCHAR(2)      
  ,Zip                  INT             
  ,Directions           VARCHAR(100)    
  ,LastOrderNumber      INTEGER         
  ,FirstOrderDate       DATETIME        
  ,TotalOrderDollars    DECIMAL(7,2)    
  ,TotalOrderCount      INTEGER         
  ,BadCkAmt             INTEGER         
  ,BadCkCount           DECIMAL(7,2)    
  ,LongDelivery         BOOL            
  ,LastOrderDate        DATETIME        
  ,Notes                VARCHAR(100)    
);

CREATE TABLE products(
    ID                  INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT
    ,ProductName        VARCHAR(30)
    ,Cost               DECIMAL(7,2)
    ,ProductCategory    INTEGER 
    ,Generic            BOOL
);

CREATE TABLE orders(
    ID              INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT
    ,CustomerID     INTEGER
    ,UserID         INTEGER
    ,OrderDate      DATE
    ,Ordertime      DATETIME
    ,TotalCost      DECIMAL(7,2)
    ,Paid           BOOL
    ,DriverID       INTEGER
    ,Discounts      DECIMAL(7,2)
    ,AmountPaid     DECIMAL(7,2)
    ,ChangeDue      DECIMAL(7,2)
    ,TIP            DECIMAL(7,2)
    
    ,FOREIGN KEY (CustomerID) REFERENCES customers(ID) ON DELETE NO ACTION
    ,FOREIGN KEY (UserID) REFERENCES users(ID) ON DELETE NO ACTION
    ,FOREIGN KEY (DriverID) REFERENCES users(ID) ON DELETE NO ACTION
);

CREATE TABLE orderline(
    ID                  INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT
    ,OrderID            INTEGER
    ,ProductParentID    INTEGER
    ,Options            VARCHAR(50)
    ,ItemTotalCost      DECIMAL(7,2)
    
    ,FOREIGN KEY (OrderID) REFERENCES orders(ID) ON DELETE CASCADE
);

CREATE TABLE options(
    ID                  INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT
    ,Name        VARCHAR(30)
    ,ProductParentID    INTEGER
    ,Cost               DECIMAL(7,2)
    
    ,FOREIGN KEY (ProductParentID) REFERENCES products(ID) ON DELETE CASCADE
);