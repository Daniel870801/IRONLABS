create database cars;
use cars;
CREATE TABLE cars (
    id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    vin VARCHAR(20)  NOT NULL,
    manufacturer VARCHAR(20),
    model VARCHAR(20),
    year SMALLINT,
    color VARCHAR(10)
);
CREATE TABLE customers (
    id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Customer_id INTEGER NOT NULL,
    Name VARCHAR(30),
    Phone INT,
    Email VARCHAR(30),
    Address VARCHAR(30),
    City VARCHAR(15),
    State_Province VARCHAR(20),
    Country VARCHAR(20),
    Postal INT
);
CREATE TABLE salespersons (
    id INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Staff_ID INT NOT NULL,
    Name VARCHAR(20),
    Store VARCHAR(20)
);

CREATE TABLE invoices (
    id INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Invoice_Number INTEGER,
    Date DATE,
    Car INTEGER,
    Customer INTEGER,
    Sales_Person INTEGER
);

