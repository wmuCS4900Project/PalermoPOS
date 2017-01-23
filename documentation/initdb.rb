rails generate model Customer Phone:string LastName:string FirstName:string AddressNumber:string StreetName:string City:string State:string Zip:integer Directions:string LastOrderNumber:integer FirstOrderDate:datetime TotalOrderDollars:decimal TotalOrderCount:integer BadCkAmt:integer BadCkCount:decimal LongDelivery:boolean LastOrderDate:datetime Notes:string
rails generate model Product Name:string Cost:decimal FreeOptions:string category:references
rails generate model User Name:string Password:string Driver:boolean IsManager:boolean
rails generate model Option Name:string Cost:decimal category:references
rails generate model Order TimeOrdered:datetime TotalCost:decimal PaidFor:boolean DriverID:integer Discounts:decimal AmountPaid:decimal ChangeDue:decimal Tip:decimal Notes:string user:references customer:references
rails generate model Orderline ItemTotalCost:decimal product:references order:references Split:integer Options1:string Options2:string Options3:string Options4:string Notes:string
rails generate model Category Name:string Splits:boolean