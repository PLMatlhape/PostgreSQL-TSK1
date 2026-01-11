# Library Management System (PostgreSQL)

A comprehensive Library Management System built using PostgreSQL that manages books, authors, and patrons. This system supports full CRUD operations and advanced queries for library management.

## 📋 Table of Contents

- [Overview](#overview)
- [Database Schema](#database-schema)
- [Setup Instructions](#setup-instructions)
- [Sprint Breakdown](#sprint-breakdown)
- [SQL Operations](#sql-operations)
  - [Create Operations](#create-operations)
  - [Insert Operations](#insert-operations)
  - [Read Operations](#read-operations)
  - [Update Operations](#update-operations)
  - [Delete Operations](#delete-operations)
  - [Advanced Queries](#advanced-queries)
- [Quick Reference](#quick-reference)

## Overview

This Library Management System allows librarians to:
- Add new books and authors to the collection
- Track patron borrowing activities
- Query available books, books by specific authors
- Manage book availability (borrow/return)
- Delete outdated records
- Run advanced queries for filtering and searching

## Database Schema

### Authors Table
| Column      | Type         | Constraints       |
|-------------|--------------|-------------------|
| id          | SERIAL       | PRIMARY KEY       |
| name        | VARCHAR(100) | NOT NULL          |
| nationality | VARCHAR(50)  |                   |
| birth_year  | INTEGER      |                   |
| death_year  | INTEGER      |                   |

### Books Table
| Column         | Type         | Constraints                              |
|----------------|--------------|------------------------------------------|
| id             | SERIAL       | PRIMARY KEY                              |
| title          | VARCHAR(200) | NOT NULL                                 |
| author_id      | INTEGER      | NOT NULL, FOREIGN KEY -> authors(id)     |
| genres         | TEXT[]       |                                          |
| published_year | INTEGER      |                                          |
| available      | BOOLEAN      | DEFAULT TRUE                             |

### Patrons Table
| Column         | Type         | Constraints       |
|----------------|--------------|-------------------|
| id             | SERIAL       | PRIMARY KEY       |
| name           | VARCHAR(100) | NOT NULL          |
| email          | VARCHAR(100) | UNIQUE, NOT NULL  |
| borrowed_books | INTEGER[]    |                   |

## Setup Instructions

### Prerequisites
- PostgreSQL installed (version 12+)
- pgAdmin or psql command-line tool

### Step 1: Create the Database

Using **psql**:
```bash
psql -U postgres
```

```sql
CREATE DATABASE LibraryDB;
\c LibraryDB
```

Using **pgAdmin**:
1. Right-click on "Databases"
2. Select "Create" → "Database"
3. Name it `LibraryDB`
4. Click "Save"

### Step 2: Run SQL Files in Order

Execute the SQL files in this order:

```bash
# Using psql
psql -U postgres -d LibraryDB -f sql/01_create_database.sql
psql -U postgres -d LibraryDB -f sql/02_create_tables.sql
psql -U postgres -d LibraryDB -f sql/03_insert_authors.sql
psql -U postgres -d LibraryDB -f sql/04_insert_books.sql
psql -U postgres -d LibraryDB -f sql/05_insert_patrons.sql
```

Or run each file individually in pgAdmin Query Tool.

## Sprint Breakdown

| Sprint | Description | Files |
|--------|-------------|-------|
| Sprint 1 | Project Setup - Create database and tables | `01_create_database.sql`, `02_create_tables.sql` |
| Sprint 2 | Insert Data - Add sample records | `03_insert_authors.sql`, `04_insert_books.sql`, `05_insert_patrons.sql` |
| Sprint 3 | Read Operations - Query data | `06_read_operations.sql` |
| Sprint 4 | Update Operations - Modify records | `07_update_operations.sql` |
| Sprint 5 | Delete Operations - Remove records | `08_delete_operations.sql` |
| Sprint 6 | Advanced Queries - Complex filtering | `09_advanced_queries.sql` |
| Sprint 7 | Documentation | `README.md` |

## SQL Operations

### Create Operations

#### Create Database
```sql
CREATE DATABASE LibraryDB;
```

#### Create Tables
```sql
-- Authors Table
CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    nationality VARCHAR(50),
    birth_year INTEGER,
    death_year INTEGER
);

-- Books Table
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author_id INTEGER NOT NULL,
    genres TEXT[],
    published_year INTEGER,
    available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (author_id) REFERENCES authors(id) ON DELETE CASCADE
);

-- Patrons Table
CREATE TABLE patrons (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    borrowed_books INTEGER[]
);
```

### Insert Operations

#### Insert Authors
```sql
INSERT INTO authors (id, name, nationality, birth_year, death_year) VALUES
(1, 'George Orwell', 'British', 1903, 1950),
(2, 'Harper Lee', 'American', 1926, 2016),
(3, 'F. Scott Fitzgerald', 'American', 1896, 1940),
(4, 'Aldous Huxley', 'British', 1894, 1963),
(5, 'J.D. Salinger', 'American', 1919, 2010),
(6, 'Herman Melville', 'American', 1819, 1891),
(7, 'Jane Austen', 'British', 1775, 1817),
(8, 'Leo Tolstoy', 'Russian', 1828, 1910),
(9, 'Fyodor Dostoevsky', 'Russian', 1821, 1881),
(10, 'J.R.R. Tolkien', 'British', 1892, 1973);
```

#### Insert Books
```sql
INSERT INTO books (id, title, author_id, genres, published_year, available) VALUES
(1, '1984', 1, ARRAY['Dystopian', 'Political Fiction'], 1949, TRUE),
(2, 'To Kill a Mockingbird', 2, ARRAY['Southern Gothic', 'Bildungsroman'], 1960, TRUE),
(3, 'The Great Gatsby', 3, ARRAY['Tragedy'], 1925, TRUE),
(4, 'Brave New World', 4, ARRAY['Dystopian', 'Science Fiction'], 1932, TRUE),
(5, 'The Catcher in the Rye', 5, ARRAY['Realist Novel', 'Bildungsroman'], 1951, TRUE),
(6, 'Moby-Dick', 6, ARRAY['Adventure Fiction'], 1851, TRUE),
(7, 'Pride and Prejudice', 7, ARRAY['Romantic Novel'], 1813, TRUE),
(8, 'War and Peace', 8, ARRAY['Historical Novel'], 1869, TRUE),
(9, 'Crime and Punishment', 9, ARRAY['Philosophical Novel'], 1866, TRUE),
(10, 'The Hobbit', 10, ARRAY['Fantasy'], 1937, TRUE);
```

#### Insert Patrons
```sql
INSERT INTO patrons (id, name, email, borrowed_books) VALUES
(1, 'Alice Johnson', 'alice@example.com', ARRAY[]::INT[]),
(2, 'Bob Smith', 'bob@example.com', ARRAY[1, 2]),
(3, 'Carol White', 'carol@example.com', ARRAY[]::INT[]),
(4, 'David Brown', 'david@example.com', ARRAY[3]),
(5, 'Eve Davis', 'eve@example.com', ARRAY[]::INT[]),
(6, 'Frank Moore', 'frank@example.com', ARRAY[4, 5]),
(7, 'Grace Miller', 'grace@example.com', ARRAY[]::INT[]),
(8, 'Hank Wilson', 'hank@example.com', ARRAY[6]),
(9, 'Ivy Taylor', 'ivy@example.com', ARRAY[]::INT[]),
(10, 'Jack Anderson', 'jack@example.com', ARRAY[7, 8]);
```

### Read Operations

#### Get All Books
```sql
SELECT 
    b.id,
    b.title,
    a.name AS author_name,
    b.genres,
    b.published_year,
    b.available
FROM books b
JOIN authors a ON b.author_id = a.id
ORDER BY b.id;
```

#### Get a Book by Title
```sql
SELECT 
    b.id,
    b.title,
    a.name AS author_name,
    b.genres,
    b.published_year,
    b.available
FROM books b
JOIN authors a ON b.author_id = a.id
WHERE b.title = '1984';
```

#### Get All Books by a Specific Author
```sql
SELECT 
    b.id,
    b.title,
    b.genres,
    b.published_year,
    b.available
FROM books b
JOIN authors a ON b.author_id = a.id
WHERE a.name = 'George Orwell';
```

#### Get All Available Books
```sql
SELECT 
    b.id,
    b.title,
    a.name AS author_name,
    b.genres,
    b.published_year
FROM books b
JOIN authors a ON b.author_id = a.id
WHERE b.available = TRUE
ORDER BY b.title;
```

### Update Operations

#### Mark a Book as Borrowed
```sql
UPDATE books 
SET available = FALSE 
WHERE id = 1;
```

#### Add a New Genre to a Book
```sql
UPDATE books 
SET genres = array_append(genres, 'Classic') 
WHERE id = 1;
```

#### Add a Borrowed Book to Patron's Record
```sql
UPDATE patrons 
SET borrowed_books = array_append(borrowed_books, 1) 
WHERE name = 'Alice Johnson';
```

#### Complete Borrow Transaction
```sql
-- Mark book as unavailable
UPDATE books SET available = FALSE WHERE id = 1;
-- Add to patron's borrowed books
UPDATE patrons SET borrowed_books = array_append(borrowed_books, 1) WHERE name = 'Alice Johnson';
```

#### Return a Book
```sql
-- Mark book as available
UPDATE books SET available = TRUE WHERE id = 1;
-- Remove from patron's borrowed books
UPDATE patrons SET borrowed_books = array_remove(borrowed_books, 1) WHERE name = 'Bob Smith';
```

### Delete Operations

#### Delete a Book by Title
```sql
DELETE FROM books 
WHERE title = 'Moby-Dick';
```

#### Delete an Author by ID
```sql
DELETE FROM authors 
WHERE id = 6;
```
> Note: Due to `ON DELETE CASCADE`, deleting an author will also delete their books.

### Advanced Queries

#### Find Books Published After 1950
```sql
SELECT 
    b.id,
    b.title,
    a.name AS author_name,
    b.published_year
FROM books b
JOIN authors a ON b.author_id = a.id
WHERE b.published_year > 1950
ORDER BY b.published_year;
```

#### Find All American Authors
```sql
SELECT 
    id,
    name,
    nationality,
    birth_year,
    death_year
FROM authors
WHERE nationality = 'American'
ORDER BY name;
```

#### Set All Books as Available
```sql
UPDATE books 
SET available = TRUE;
```

#### Find Books That Are Available AND Published After 1950
```sql
SELECT 
    b.id,
    b.title,
    a.name AS author_name,
    b.published_year,
    b.available
FROM books b
JOIN authors a ON b.author_id = a.id
WHERE b.available = TRUE 
  AND b.published_year > 1950
ORDER BY b.published_year;
```

#### Find Authors Whose Names Contain "George"
```sql
SELECT 
    id,
    name,
    nationality,
    birth_year,
    death_year
FROM authors
WHERE name LIKE '%George%';
```

#### Increment Published Year 1869 by 1
```sql
UPDATE books 
SET published_year = published_year + 1 
WHERE published_year = 1869;
```

## Quick Reference

### Count Records
```sql
SELECT COUNT(*) FROM books;
SELECT COUNT(*) FROM authors;
SELECT COUNT(*) FROM patrons;
```

### View All Tables
```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';
```

### Reset All Books to Available
```sql
UPDATE books SET available = TRUE;
```

### Drop All Tables (Caution!)
```sql
DROP TABLE IF EXISTS books CASCADE;
DROP TABLE IF EXISTS authors CASCADE;
DROP TABLE IF EXISTS patrons CASCADE;
```

### Drop Database (Caution!)
```sql
DROP DATABASE LibraryDB;
```

## File Structure

```
PostgreSQL-TSK1/
├── README.md
└── sql/
    ├── 01_create_database.sql
    ├── 02_create_tables.sql
    ├── 03_insert_authors.sql
    ├── 04_insert_books.sql
    ├── 05_insert_patrons.sql
    ├── 06_read_operations.sql
    ├── 07_update_operations.sql
    ├── 08_delete_operations.sql
    └── 09_advanced_queries.sql
```

## Author

Library Management System - PostgreSQL Assessment

## License

This project is for educational purposes.
