CREATE TABLE orderline(
    
    ID                  INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT
    ,OrderID            INTEGER
    ,ProductParentID    INTEGER
    ,Options            VARCHAR(50)
    ,ItemTotalCost      DECIMAL(7,2)
    
    ,FOREIGN_KEY (OrderID) REFERENCES(orders(ID)) ON DELETE CASCADE
);