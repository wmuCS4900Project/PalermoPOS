CREATE TABLE users(
    ID              INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT
    ,UserName       VARCHAR(30)
    ,Password       VARCHAR(30) --TODO make me nice and secure
    ,Driver         BOOL
    ,DateAdded      DATETIME
    ,IsManager      BOOL
);