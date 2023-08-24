CREATE TABLE Address (
    street VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    postalCode INT,
    country VARCHAR(50),
    PRIMARY KEY (street, postalCode)
);

CREATE TABLE Person (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    phoneNumber VARCHAR(15),
    emailAddress VARCHAR(100),
    address_street VARCHAR(100),
    address_postalCode INT,
    FOREIGN KEY (address_street, address_postalCode) REFERENCES Address(street, postalCode)
);

CREATE TABLE Professor (
    id INT,
    name VARCHAR(50),
    phoneNumber VARCHAR(15),
    emailAddress VARCHAR(100),
    staffNumber INT,
    salary INT,
    yearsOfService INT,
    numberOfClasses INT,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES Person(id)
);

CREATE TABLE Student (
    id INT,
    name VARCHAR(50),
    phoneNumber VARCHAR(15),
    emailAddress VARCHAR(100),
    studentNumber INT,
    averageMark INT,
    professor_id INT,
    PRIMARY KEY (id, studentNumber),
    FOREIGN KEY (id) REFERENCES Person(id),
    FOREIGN KEY (professor_id) REFERENCES Professor(id)
);

INSERT INTO Address (street, city, state, postalCode, country) VALUES
('Physics Street', 'New York', 'New York', 12345, 'USA');

INSERT INTO Address (street, city, state, postalCode, country) VALUES
('Atomic Street', 'New York', 'New York', 6789, 'USA');

INSERT INTO Address (street, city, state, postalCode, country) VALUES
('Magic Street', 'New York', 'New York', 5678, 'USA');

INSERT INTO Address (street, city, state, postalCode, country) VALUES
('Dark Street', 'New York', 'New York', 3456, 'USA');

INSERT INTO Person (id, name, phoneNumber, emailAddress, address_street, address_postalCode) VALUES
(1, 'Albert Einstein', '123456789', 'einstein@gmail.com', 'Physics Street', 12345);

INSERT INTO Person (id, name, phoneNumber, emailAddress, address_street, address_postalCode) VALUES
(2, 'J. Robert Oppenheimer', '987654321', 'oppenheimer@gmail.com', 'Atomic Street', 6789);

INSERT INTO Person (id, name, phoneNumber, emailAddress, address_street, address_postalCode) VALUES
(3, 'Harry Potter', '2845285957', 'harry@gmail.com', 'Magic Street', 5678);

INSERT INTO Person (id, name, phoneNumber, emailAddress, address_street, address_postalCode) VALUES
(4, 'Draco Malfoy', '5920671957', 'draco@gmail.com', 'Dark Street', 3456);

INSERT INTO Professor (id, name, phoneNumber, emailAddress, staffNumber, salary, yearsOfService, numberOfClasses) VALUES
(1, 'Albert Einstein', '123456789', 'einstein@gmail.com', 123, 90000, 35, 10);

INSERT INTO Professor (id, name, phoneNumber, emailAddress, staffNumber, salary, yearsOfService, numberOfClasses) VALUES
(2, 'J. Robert Oppenheimer', '987654321', 'oppenheimer@gmail.com', 456, 85000, 20, 5);

INSERT INTO Student (id, name, phoneNumber, emailAddress, studentNumber, averageMark, professor_id) VALUES
(3, 'Harry Potter', '2845285957', 'harry@gmail.com', 234, 10, 2);

INSERT INTO Student (id, name, phoneNumber, emailAddress, studentNumber, averageMark, professor_id) VALUES
(4, 'Draco Malfoy', '5920671957', 'draco@gmail.com', 789, 8, 1);

select * from student;

select * from professor;

-- SELECT STATEMENTS
-- Select professors who have students with an average mark greater than 8
SELECT Professor.name
FROM Professor
WHERE EXISTS (
    SELECT 1 FROM Student
    WHERE Student.professor_id = Professor.id AND Student.averageMark > 8
);

-- Select students with the highest average mark
SELECT * FROM Student
WHERE averageMark = (SELECT MAX(averageMark) FROM Student);

-- UPDATE
UPDATE Student SET averageMark = 9 WHERE id = 3;
UPDATE Professor SET yearsOfService = 40 WHERE id = 1;
select * from professor;

-- INNER JOIN
-- Select students and their professors' names
SELECT Student.name AS StudentName, Professor.name AS ProfessorName
FROM Student
INNER JOIN Professor 
ON Student.professor_id = Professor.id;

-- OUTER JOIN
-- Count the number of students per professor
SELECT Professor.name, COUNT(Student.id) AS NumberOfStudents
FROM Professor
LEFT JOIN Student ON Professor.id = Student.professor_id
GROUP BY Professor.name;

-- DELETE
DELETE FROM Student WHERE id = 3;
DELETE FROM Student WHERE id = 4;
