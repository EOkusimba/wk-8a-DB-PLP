-- =============================================================
--  Library Management System Database Schema
-- =============================================================
-- Summary
-- This SQL script creates a relational database for managing 
-- library operations, including books, authors, members, loans, 
-- publishers, and librarians. The schema ensures referential 
-- integrity through primary and foreign keys and efficiently 
-- handles book loans and categorization.
--
-- Features:
-- ✅ Well-structured relational database design.
-- ✅ Many-to-many relationships (Books ↔ Authors, Books ↔ Categories).
-- ✅ One-to-many relationships (Publishers ↔ Books, Members ↔ Loans).
-- ✅ Tracks which librarian processes each loan transaction.
-- ✅ Sample data inserts for testing and validation.
--
-- Usage:
-- 1️. Run this script in a MySQL environment.
-- 2️. It will create tables and insert initial sample records.
-- 3️. You can modify or expand it as needed.
--
-- Note:
-- Ensure your MySQL user has the necessary privileges to create 
-- databases and tables before executing this script.
-- =============================================================

-- Creating the database LibraryDB if it does not exist
CREATE DATABASE IF NOT EXISTS LibraryDB;
USE LibraryDB;

-- Creating the Publishers Table
CREATE TABLE Publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(255) NOT NULL UNIQUE,
    publisher_address VARCHAR(255)
);

-- Inserting Dummy Data into the Publishers table
INSERT INTO Publishers (publisher_name, publisher_address)
VALUES ('Pearson Education', '123 Main Street'),
       ('O\'Reilly Media', '456 Tech Drive'),
       ('Penguin Books', '789 Publishing Lane');

-- Creating the Authors Table and inserting dummy data into it
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    UNIQUE (first_name, last_name, date_of_birth)
);

INSERT INTO Authors (first_name, last_name, date_of_birth)
VALUES ('Chinua', 'Achebe', '1930-11-16'),
       ('Chimamanda', 'Adichie', '1977-09-15'),
       ('Wole', 'Soyinka', '1934-07-13'),
       ('Ngũgĩ', 'wa Thiong\'o', '1938-01-05'),
       ('Trevor', 'Noah', '1984-02-20');

-- Creating the Categories Table and inserting dummy data into it
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO Categories (category_name)
VALUES ('Historical Fiction'),
       ('Memoir'),
       ('Classic Literature'),
       ('African Literature'),
       ('Political Commentary');

-- Creating the Books Table and inserting dummy data into it
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publisher_id INT,
    publication_year YEAR,
    isbn VARCHAR(20) UNIQUE,
    available_copies INT DEFAULT 0,
    CONSTRAINT fk_books_publisher FOREIGN KEY (publisher_id) 
        REFERENCES Publishers(publisher_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

INSERT INTO Books (title, publisher_id, publication_year, isbn, available_copies)
VALUES ('Things Fall Apart', 1, 1958, '9780385474542', 10),
       ('Half of a Yellow Sun', 2, 2006, '9781400044160', 8),
       ('Born a Crime', 3, 2016, '9780399588198', 12),
       ('Season of Crimson Blossoms', 2, 2015, '9781911115433', 6),
       ('The Beautyful Ones Are Not Yet Born', 1, 1968, '9781477316779', 7);

-- -- Creating the BookAuthors Table and inserting dummy data into it 
CREATE TABLE BookAuthors (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    CONSTRAINT fk_ba_book FOREIGN KEY (book_id) 
        REFERENCES Books(book_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_ba_author FOREIGN KEY (author_id) 
        REFERENCES Authors(author_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

INSERT INTO BookAuthors (book_id, author_id)
VALUES (1, 1),
       (2, 2),
       (3, 5),
       (4, 4),
       (5, 3);
       
-- -- Creating the BookCategories Table and inserting dummy data into it 

CREATE TABLE BookCategories (
    book_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (book_id, category_id),
    CONSTRAINT fk_bc_book FOREIGN KEY (book_id) 
        REFERENCES Books(book_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_bc_category FOREIGN KEY (category_id) 
        REFERENCES Categories(category_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

INSERT INTO BookCategories (book_id, category_id)
VALUES (1, 3),
       (2, 1),
       (3, 2),
       (4, 4),
       (5, 5);

-- -- Creating the Members Table and inserting dummy data into it 

CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    join_date DATE NOT NULL,
    membership_status ENUM('Active', 'Inactive') DEFAULT 'Active'
) ENGINE=InnoDB;

INSERT INTO Members (first_name, last_name, email, join_date, membership_status)
VALUES ('Abdullahi', 'Omar', 'abdullahi.omar@example.com', '2023-01-15', 'Active'),
       ('Fatima', 'Mohammed', 'fatima.mohammed@example.com', '2022-10-10', 'Active'),
       ('Samuel', 'Okafor', 'samuel.okafor@example.com', '2023-05-20', 'Inactive'),
       ('Amina', 'Khan', 'amina.khan@example.com', '2021-08-30', 'Active'),
       ('John', 'Mwangi', 'john.mwangi@example.com', '2024-02-12', 'Active');

-- -- Creating the Librarians Table and inserting dummy data into it 

CREATE TABLE Librarians (
    librarian_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
) ENGINE=InnoDB;

INSERT INTO Librarians (first_name, last_name, email)
VALUES ('Miriam', 'Atieno', 'miriam.atieno@example.com'),
       ('Ahmed', 'Saleh', 'ahmed.saleh@example.com'),
       ('Grace', 'Njoroge', 'grace.njoroge@example.com');
  
-- -- Creating the Loans Table and inserting dummy data into it 

CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    librarian_id INT NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    CONSTRAINT fk_loans_book FOREIGN KEY (book_id) 
        REFERENCES Books(book_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_loans_member FOREIGN KEY (member_id) 
        REFERENCES Members(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_loans_librarian FOREIGN KEY (librarian_id) 
        REFERENCES Librarians(librarian_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


INSERT INTO Loans (book_id, member_id, librarian_id, loan_date, due_date, return_date)
VALUES (1, 1, 1, '2024-01-01', '2024-01-14', '2024-01-12'),
       (2, 2, 2, '2024-02-15', '2024-02-28', NULL),
       (3, 3, 3, '2024-03-10', '2024-03-24', '2024-03-23'),
       (4, 4, 1, '2024-04-01', '2024-04-15', NULL),
       (5, 5, 2, '2024-05-05', '2024-05-19', '2024-05-18');


-- =============================================================
--  THE END OF Library Management System Database Schema
-- =============================================================
