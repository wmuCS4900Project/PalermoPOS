CREATE TABLE options(
    ID                  INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT
    ,Name        VARCHAR(30)
    ,ProductParentID    INTEGER
    ,Cost               DECIMAL(7,2)
    
    ,FOREIGN_KEY (OrderID) REFERENCES(products(ID)) ON DELETE CASCADE
);