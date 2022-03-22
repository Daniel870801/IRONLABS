create database lab_32;
use lab_32;
CREATE TABLE challenge (
    TransactionID INT,
    ClientID INT,
    Profession VARCHAR(50),
    Bank_dep VARCHAR(50),
    Risk VARCHAR(50),
    NumberOfCredits VARCHAR(50),
    Revenue VARCHAR(50)
);
insert into challenge(TransactionID, ClientID, Profession, Bank_dep, Risk, NumberOfCredits, Revenue)
values (1, 231,'Self_employed','009','high',2,30200), (2,765,'students', '005','high',3,12700), (3, 453,'Horeca', '007', 'medium', 5,89400), 
(4, 231, 'self_employed','009','high',2,30200), (5,892,'finance','003','low',3,740000);
SELECT 
    ClientID,
    COUNT(CASE
        WHEN Profession = 'students' THEN 1
    END) AS students,
    COUNT(CASE
        WHEN Profession = 'Self-employed' THEN 1
    END) AS Self_employed,
    COUNT(CASE
        WHEN Profession = 'Horeca' THEN 1
    END) AS Horeca,
    COUNT(CASE
        WHEN Profession = 'Finance' THEN 1
    END) AS Finance
FROM
    challenge
GROUP BY ClientID;
SELECT 
    Profession,
    Revenue,
    NumberOfCredits,
    CASE
        WHEN Profession = 'students' THEN 'High risk'
        WHEN Profession = 'Self_employed' THEN 'High risk'
        WHEN Profession = 'Horeca' THEN 'Medium risk'
        WHEN Profession = 'Finance' THEN 'Low risk'
    END AS NumberOfCredits
FROM
    challenge;