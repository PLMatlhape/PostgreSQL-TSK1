-- ============================================
-- Library Management System - Advanced Queries
-- Sprint 6: Advanced Queries
-- ============================================

-- ============================================
-- 1. Find Books Published After 1950
-- Successfully fetches books published after 1950
-- ============================================
SELECT 
    b.id,
    b.title,
    a.name AS author_name,
    b.published_year,
    b.genres,
    b.available
FROM books b
JOIN authors a ON b.author_id = a.id
WHERE b.published_year > 1950
ORDER BY b.published_year;

-- Count of books published after 1950
SELECT COUNT(*) AS books_after_1950 
FROM books 
WHERE published_year > 1950;

-- ============================================
-- 2. Find All American Authors
-- Successfully fetches all American authors
-- ============================================
SELECT 
    id,
    name,
    nationality,
    birth_year,
    death_year,
    (death_year - birth_year) AS lifespan
FROM authors
WHERE nationality = 'American'
ORDER BY name;

-- Count of American authors
SELECT COUNT(*) AS american_authors_count 
FROM authors 
WHERE nationality = 'American';

-- ============================================
-- 3. Set All Books as Available
-- Successfully sets all books as available
-- ============================================
UPDATE books 
SET available = TRUE;

-- Verify all books are now available
SELECT id, title, available FROM books ORDER BY id;

-- Count verification
SELECT 
    COUNT(*) AS total_books,
    SUM(CASE WHEN available = TRUE THEN 1 ELSE 0 END) AS available_books
FROM books;

-- ============================================
-- 4. Find All Books That Are Available AND Published After 1950
-- Successfully fetches books that are both available and published after 1950
-- ============================================
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

-- ============================================
-- 5. Find Authors Whose Names Contain "George"
-- Successfully fetches authors whose name contain "George"
-- ============================================
SELECT 
    id,
    name,
    nationality,
    birth_year,
    death_year
FROM authors
WHERE name LIKE '%George%';

-- Case-insensitive search for "George"
SELECT 
    id,
    name,
    nationality,
    birth_year,
    death_year
FROM authors
WHERE name ILIKE '%george%';

-- ============================================
-- 6. Increment the Published Year 1869 by 1
-- Successfully increments
-- ============================================

-- First, check books with published_year = 1869
SELECT id, title, published_year 
FROM books 
WHERE published_year = 1869;

-- Increment published_year from 1869 to 1870
UPDATE books 
SET published_year = published_year + 1 
WHERE published_year = 1869;

-- Verify the update (should now be 1870)
SELECT id, title, published_year 
FROM books 
WHERE published_year = 1870;

-- ============================================
-- Additional Advanced Queries
-- ============================================

-- Find books by nationality of author
SELECT 
    b.title,
    a.name AS author_name,
    a.nationality
FROM books b
JOIN authors a ON b.author_id = a.id
WHERE a.nationality = 'Russian'
ORDER BY b.title;

-- Find books with specific genre
SELECT 
    id,
    title,
    genres
FROM books
WHERE 'Dystopian' = ANY(genres);

-- Get borrowing statistics per patron
SELECT 
    p.name,
    p.email,
    array_length(p.borrowed_books, 1) AS books_borrowed_count,
    p.borrowed_books
FROM patrons p
WHERE array_length(p.borrowed_books, 1) > 0
ORDER BY books_borrowed_count DESC;

-- Find authors with their book count
SELECT 
    a.id,
    a.name,
    COUNT(b.id) AS total_books
FROM authors a
LEFT JOIN books b ON a.id = b.author_id
GROUP BY a.id, a.name
ORDER BY total_books DESC;
