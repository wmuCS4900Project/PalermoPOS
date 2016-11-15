CREATE TABLE customers(
   ID                   INTEGER  NOT NULL PRIMARY KEY AUTO_INCREMENT --old
  ,Phone                VARCHAR(10)     --old
  ,LastName             VARCHAR(40)     --old
  ,FirstName            VARCHAR(20)     --old
  ,AddressNumber        VARCHAR(10)     --old
  ,StreetName           VARCHAR(30)     --old
  ,City                 VARCHAR(20)     --old
  ,State                VARCHAR(2)      --old
  ,Zip                  INT             --old
  ,Directions           VARCHAR(100)    --old
  ,LastOrderNumber      INTEGER         --old
  ,FirstOrderDate       DATETIME        --old
  ,TotalOrderDollars    DECIMAL(7,2)    --old
  ,TotalOrderCount      INTEGER         --old
  ,BadCkAmt             INTEGER         --old
  ,BadCkCount           DECIMAL(7,2)    --old
  ,LongDelivery         BOOL            --old
  ,LastOrderDate        DATETIME        --old
  ,Notes                VARCHAR(100)    --new
);