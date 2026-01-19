CREATE DATABASE airline_db;
USE airline_db;

CREATE TABLE air_passenger_profile (
    profile_id VARCHAR(10) PRIMARY KEY,
    password VARCHAR(10),
    first_name VARCHAR(10),
    last_name VARCHAR(10),
    address VARCHAR(100),
    mobile_number BIGINT,
    email_id VARCHAR(30)
);

CREATE TABLE air_flight (
    flight_id VARCHAR(10) PRIMARY KEY,
    airline_id VARCHAR(10),
    airline_name VARCHAR(30),
    from_location VARCHAR(20),
    to_location VARCHAR(20),
    departure_time TIME,
    arrival_time TIME,
    duration TIME,
    total_seats INT
);


CREATE TABLE air_flight_details (
    flight_id VARCHAR(10),
    flight_departure_date DATE,
    price DECIMAL(8,2),
    available_seats INT,
    FOREIGN KEY (flight_id) REFERENCES air_flight(flight_id)
);

CREATE TABLE air_ticket_info (
    ticket_id VARCHAR(10) PRIMARY KEY,
    profile_id VARCHAR(10),
    flight_id VARCHAR(10),
    flight_departure_date DATE,
    status VARCHAR(10),
    FOREIGN KEY (profile_id) REFERENCES air_passenger_profile(profile_id),
    FOREIGN KEY (flight_id) REFERENCES air_flight(flight_id)
);

CREATE TABLE air_credit_card_details (
    profile_id VARCHAR(10),
    card_number BIGINT,
    card_type VARCHAR(10),
    expiration_month INT,
    expiration_year INT,
    FOREIGN KEY (profile_id) REFERENCES air_passenger_profile(profile_id)
);


INSERT INTO air_passenger_profile VALUES
('P001','pass1','Ajay','Rao','Hyderabad',9876543210,'ajay@gmail.com'),
('P002','pass2','Ravi','Kumar','Chennai',9123456780,'ravi@gmail.com'),
('P003','pass3','Sneha','Patel','Ahmedabad',9988776655,'sneha@gmail.com'),
('P004','pass4','Anita','Shah','Mumbai',9090909090,'anita@gmail.com'),
('P005','pass5','Kiran','Mehta','Delhi',9012345678,'kiran@gmail.com');

INSERT INTO air_flight VALUES
('F101','A001','IndiGo','Mumbai','Delhi','10:00:00','12:00:00','02:00:00',180),
('F102','A002','AirIndia','Delhi','Bangalore','14:00:00','16:30:00','02:30:00',200),
('F103','A003','Vistara','Chennai','Mumbai','09:00:00','11:00:00','02:00:00',160),
('F104','A004','SpiceJet','Hyderabad','Pune','18:00:00','19:30:00','01:30:00',150),
('F105','A005','Akasa','Kolkata','Delhi','06:00:00','08:30:00','02:30:00',170);

INSERT INTO air_flight_details VALUES
('F101','2024-09-10',5500.00,150),
('F102','2024-09-11',6200.00,180),
('F103','2024-09-12',4800.00,140),
('F104','2024-09-13',4500.00,130),
('F105','2024-09-14',7000.00,160);

INSERT INTO air_ticket_info VALUES
('T001','P001','F101','2024-09-10','Booked'),
('T002','P002','F102','2024-09-11','Booked'),
('T003','P003','F103','2024-09-12','Cancelled'),
('T004','P004','F104','2024-09-13','Booked'),
('T005','P005','F105','2024-09-14','Booked');

INSERT INTO air_credit_card_details VALUES
('P001',1111222233334444,'VISA',12,2026),
('P002',2222333344445555,'MASTER',11,2025),
('P003',3333444455556666,'VISA',10,2027),
('P004',4444555566667777,'RUPAY',9,2026),
('P005',5555666677778888,'VISA',8,2028);

SELECT f.flight_id, f.from_location, f.to_location, DATENAME(MONTH, fd.flight_departure_date) AS Month_Name,
AVG(fd.price) AS Average_Price FROM air_flight f
JOIN air_flight_details fd ON f.flight_id = fd.flight_id
WHERE f.airline_name = 'AirIndia'
GROUP BY f.flight_id,f.from_location,f.to_location,DATENAME(MONTH, fd.flight_departure_date),
MONTH(fd.flight_departure_date) ORDER BY f.flight_id ASC,MONTH(fd.flight_departure_date) ASC;

SELECT p.profile_id,p.first_name,p.address,
COUNT(t.ticket_id) AS No_of_Tickets FROM air_passenger_profile p
JOIN air_ticket_info t ON p.profile_id = t.profile_id
JOIN air_flight f ON t.flight_id = f.flight_id
WHERE f.airline_name = 'AirIndia'
GROUP BY p.profile_id, p.first_name, p.address
HAVING COUNT(t.ticket_id) = (SELECT MIN(ticket_count)
FROM (
        SELECT COUNT(ticket_id) AS ticket_count
        FROM air_ticket_info ti
        JOIN air_flight af ON ti.flight_id = af.flight_id
        WHERE af.airline_name = 'AirIndia'
        GROUP BY ti.profile_id
    ) x
)
ORDER BY p.first_name;

SELECT f.from_location,f.to_location,DATENAME(MONTH, d.flight_departure_date) AS Month_Name,
COUNT(d.flight_departure_date) AS No_of_Services
FROM air_flight f JOIN air_flight_details d ON f.flight_id = d.flight_id
GROUP BY f.from_location, f.to_location,DATENAME(MONTH, d.flight_departure_date),MONTH(d.flight_departure_date)
ORDER BY f.from_location,f.to_location, MONTH(d.flight_departure_date);

SELECT p.profile_id,p.first_name,p.address,COUNT(t.ticket_id) AS No_of_Tickets
FROM air_passenger_profile p JOIN air_ticket_info t ON p.profile_id = t.profile_id
JOIN air_flight f ON t.flight_id = f.flight_id WHERE f.airline_name = 'AirIndia'
GROUP BY p.profile_id, p.first_name, p.address
HAVING COUNT(t.ticket_id) = (
    SELECT MAX(ticket_count)
    FROM (
        SELECT COUNT(ticket_id) AS ticket_count
        FROM air_ticket_info ti
        JOIN air_flight af ON ti.flight_id = af.flight_id
        WHERE af.airline_name = 'AirIndia'
        GROUP BY ti.profile_id
    ) x
)
ORDER BY p.first_name;

SELECT p.profile_id, p.first_name,p.last_name,f.flight_id, t.flight_departure_date AS Departure_Date,
COUNT(t.ticket_id) AS No_of_Tickets
FROM air_passenger_profile p
JOIN air_ticket_info t ON p.profile_id = t.profile_id
JOIN air_flight f ON t.flight_id = f.flight_id
WHERE f.from_location = 'Chennai' AND f.to_location = 'Hyderabad'
GROUP BY p.profile_id,p.first_name,p.last_name,f.flight_id,t.flight_departure_date
ORDER BY p.profile_id,f.flight_id,t.flight_departure_date;

SELECT f.flight_id, f.from_location, f.to_location,d.price
FROM air_flight f JOIN air_flight_details d ON f.flight_id = d.flight_id
WHERE MONTH(d.flight_departure_date) = 4;

SELECT  f.flight_id,  f.from_location, f.to_location, AVG(d.price) AS Price
FROM air_flight f JOIN air_flight_details d ON f.flight_id = d.flight_id
GROUP BY f.flight_id, f.from_location, f.to_location
ORDER BY f.flight_id, f.from_location, f.to_location;

SELECT DISTINCT p.profile_id, p.first_name + ',' + p.last_name AS customer_name, p.address FROM air_passenger_profile p JOIN air_ticket_info t ON p.profile_id = t.profile_id
JOIN air_flight f ON t.flight_id = f.flight_id WHERE f.from_location = 'Chennai'
 AND f.to_location = 'Hyderabad' ORDER BY p.profile_id;

 SELECT profile_id FROM air_ticket_info GROUP BY profile_id
HAVING COUNT(ticket_id) = (
    SELECT MAX(ticket_count) FROM ( SELECT COUNT(ticket_id) AS ticket_count
      FROM air_ticket_info GROUP BY profile_id
    ) x
)
ORDER BY profile_id;


SELECT f.flight_id,f.from_location,f.to_location,COUNT(t.ticket_id) AS No_of_Tickets
FROM air_flight f JOIN air_ticket_info t ON f.flight_id = t.flight_id
WHERE f.airline_name = 'AirIndia' GROUP BY f.flight_id, f.from_location,f.to_location
HAVING COUNT(t.ticket_id) >= 1 ORDER BY f.flight_id;


INSERT INTO air_flight
VALUES
('AI201', 'AIR001', 'AirIndia', 'Chennai', 'Hyderabad', '09:00:00', '10:30:00', '01:30', 180),
('AI202', 'AIR001', 'AirIndia', 'Chennai', 'Hyderabad', '18:00:00', '19:30:00', '01:30', 180);

INSERT INTO air_flight_details
VALUES
('AI201', '2024-04-05', 4200, 150),
('AI201', '2024-04-15', 4500, 140),
('AI202', '2024-04-10', 4000, 160),
('AI202', '2024-04-20', 4300, 155);

INSERT INTO air_passenger_profile
VALUES
('P101', 'pass101', 'Rahul', 'Verma', 'Chennai', 9876543211, 'rahul@gmail.com'),
('P102', 'pass102', 'Anita', 'Shah', 'Hyderabad', 9876543212, 'anita@gmail.com'),
('P103', 'pass103', 'Kiran', 'Reddy', 'Bangalore', 9876543213, 'kiran@gmail.com');

INSERT INTO air_ticket_info
VALUES
('T501', 'P101', 'AI201', '2024-04-05', 'CONFIRMED'),
('T502', 'P101', 'AI201', '2024-04-15', 'CONFIRMED'),
('T503', 'P102', 'AI201', '2024-04-05', 'CONFIRMED'),
('T504', 'P102', 'AI202', '2024-04-10', 'CONFIRMED'),
('T505', 'P102', 'AI202', '2024-04-20', 'CONFIRMED'),
('T506', 'P103', 'AI201', '2024-04-15', 'CONFIRMED');

