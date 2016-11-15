CREATE TABLE products(
    ID                  INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT
    ,ProductName        VARCHAR(30)
    ,Cost               DECIMAL(7,2)
    ,ProductCategory    INTEGER -- 1 pizza
    ,Generic     BOOL --generic if its a template, ie plain pizza. most will not be
);