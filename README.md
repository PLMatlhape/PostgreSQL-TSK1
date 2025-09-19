# PostgreSQL-TSK1
# Library Management System

## Setup

1. Install PostgreSQL
2. Open pgAdmin or use psql
3. Create database: `LibraryDB`

## Running the Code

Execute the SQL files in this order:

### 1. Create Tables
```sql
CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    nationality VARCHAR(50),
    birth_year INTEGER,
    death_year INTEGER
);

CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author_id INTEGER NOT NULL,
    genres TEXT[],
    published_year INTEGER,
    available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (author_id) REFERENCES authors(id) ON DELETE CASCADE
);

CREATE TABLE patrons (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    borrowed_books INTEGER[]
);
```

### 2. Add Sample Data
Insert authors first, then books, then patrons. Use the provided INSERT statements.

### 3. Test Basic Queries
```sql
-- View all books
SELECT * FROM books;

-- View books with authors
SELECT b.title, a.name FROM books b JOIN authors a ON b.author_id = a.id;
```

## Usage

### Borrow a book
```sql
UPDATE books SET available = FALSE WHERE id = 1;
UPDATE patrons SET borrowed_books = array_append(borrowed_books, 1) WHERE id = 1;
```

### Return a book
```sql
UPDATE books SET available = TRUE WHERE id = 1;
UPDATE patrons SET borrowed_books = array_remove(borrowed_books, 1) WHERE id = 1;
```

### Search books
```sql
-- By author
SELECT b.* FROM books b JOIN authors a ON b.author_id = a.id WHERE a.name = 'George Orwell';

-- Available books only
SELECT * FROM books WHERE available = TRUE;

-- Books after 1950
SELECT * FROM books WHERE published_year > 1950;
```

## Quick Commands

```sql
-- Count records
SELECT COUNT(*) FROM books;
SELECT COUNT(*) FROM authors;

-- Reset availability
UPDATE books SET available = TRUE;

-- Drop everything
DROP TABLE books CASCADE;
DROP TABLE authors CASCADE;
DROP TABLE patrons CASCADE;
```
