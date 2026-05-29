create database Maxx_online_shopping;
use Maxx_online_shopping;

create table Products(ProductID int auto_increment primary key , product_Name varchar(100), Price int, Stock int, Category varchar(100));
create table Customers (CustomerID int auto_increment primary key, Customer_Nam varchar(100), Email varchar(200), Phone varchar(10));
create table Orders (OrderID int auto_increment primary key, CustomerID int, OrderDate date , TotalAmount int ,foreign key(CustomerID) references Customers(CustomerID));
create table OrderDetails (OrderDetailID int auto_increment primary key, OrderID int, ProductID int, Quantity int,foreign key(OrderID) references Orders (OrderID),foreign key (ProductID) references Products(ProductID));

insert into Products(product_Name, Price, Stock, Category)values('shirt',600,50,'mens'),('pant',400,30,'mens'),('saree',1000,70,'womens'),('kurthi',850,90,'womens'),('juba',750,50,'mens'),('jeens',600,50,'womens');
insert into Customers (CustomerID,Customer_Nam, Email, Phone) values(01,'anu','anu@gmail.com','2345256432'),(02,'vibin','vibin@gmail.com','2345245322'),(03,'sithara','sithara@gmail.com','2245478954'),(04,'vijay','vijay@gmail.com','9876347654'),(05,'devu','devu@gmail.com','9675896534'),(06,'sanu','sanu@gmail.com','8745347658');
insert into Orders(CustomerID,OrderDate, TotalAmount) values (01,'2026-02-02',24000),(02,'2026-02-10',56000),(03,'2026-02-15',48000),(04,'2026-02-17',36000),(05,'2026-02-20',50000),(06,'2026-02-22',38000);
insert into OrderDetails(OrderDetailID, OrderID, ProductID, Quantity)values(101,1,1,3),(102,2,2,20),(103,3,3,8),(104,4,4,12),(105,5,5,28);

SELECT p.ProductID,p.product_Name,SUM(od.Quantity) AS TotalSalesQuantity FROM OrderDetails od JOIN Products p ON od.ProductID = p.ProductID GROUP BY p.ProductID, p.product_Name ORDER BY TotalSalesQuantity asc LIMIT 5;
select *from Orders where OrderDate>=current_date-interval 30 day;
select sum(TotalAmount) as total_sales_revenue from Orders; 