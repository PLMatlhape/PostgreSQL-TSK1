-- ============================================
-- Library Management System - Read Operations
-- Sprint 3: Read Operations (Queries)
-- ============================================

-- ============================================
-- 1. Get All Books
-- Query to fetch all books and successfully fetches all books
-- ============================================
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

-- ============================================
-- 2. Get a Book by Title
-- Successfully gets a book by title
-- ============================================
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

-- Alternative: Case-insensitive search
SELECT 
    b.id,
    b.title,
    a.name AS author_name,
    b.genres,
    b.published_year,
    b.available
FROM books b
JOIN authors a ON b.author_id = a.id
WHERE LOWER(b.title) = LOWER('The Great Gatsby');

-- ============================================
-- 3. Get All Books by a Specific Author
-- Successfully gets all books by specific author
-- ============================================
SELECT 
    b.id,
    b.title,
    b.genres,
    b.published_year,
    b.available
FROM books b
JOIN authors a ON b.author_id = a.id
WHERE a.name = 'George Orwell';

-- Alternative: Get books by author ID
SELECT 
    b.id,
    b.title,
    b.genres,
    b.published_year,
    b.available
FROM books b
WHERE b.author_id = 1;

-- ============================================
-- 4. Get All Available Books
-- Successfully gets all available books
-- ============================================
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

-- Count of available books
SELECT COUNT(*) AS available_books_count 
FROM books 
WHERE available = TRUE;
