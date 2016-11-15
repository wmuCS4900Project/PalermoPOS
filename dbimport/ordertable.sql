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
    
    ,FOREIGN_KEY (CustomerID) REFERENCES(customer(ID)) ON DELETE NO ACTION
    ,FOREIGN_KEY (UserID) REFERENCES(users(ID)) ON DELETE NO ACTION
    ,FOREIGN_KEY (DriverID) REFERENCES(users(ID)) ON DELETE NO ACTION
);