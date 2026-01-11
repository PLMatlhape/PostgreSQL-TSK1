-- ============================================
-- Library Management System - Update Operations
-- Sprint 4: Update Operations
-- ============================================

-- ============================================
-- 1. Mark a Book as Borrowed (set available = FALSE)
-- Successfully marks a book as borrowed
-- ============================================

-- Mark book with ID 1 as borrowed
UPDATE books 
SET available = FALSE 
WHERE id = 1;

-- Verify the update
SELECT id, title, available FROM books WHERE id = 1;

-- Mark book by title as borrowed
UPDATE books 
SET available = FALSE 
WHERE title = 'The Great Gatsby';

-- Verify the update
SELECT id, title, available FROM books WHERE title = 'The Great Gatsby';

-- ============================================
-- 2. Add a New Genre to an Existing Book
-- Successfully adds a new genre to a book
-- ============================================

-- Add 'Classic' genre to book '1984'
UPDATE books 
SET genres = array_append(genres, 'Classic') 
WHERE id = 1;

-- Verify the genre was added
SELECT id, title, genres FROM books WHERE id = 1;

-- Add multiple genres to a book
UPDATE books 
SET genres = array_cat(genres, ARRAY['Classic', 'Must-Read']) 
WHERE title = 'To Kill a Mockingbird';

-- Verify the genres were added
SELECT id, title, genres FROM books WHERE title = 'To Kill a Mockingbird';

-- ============================================
-- 3. Add a Borrowed Book to a Patron's Record
-- Successfully adds a book to a patron
-- ============================================

-- Add book ID 1 to Alice Johnson's borrowed books
UPDATE patrons 
SET borrowed_books = array_append(borrowed_books, 1) 
WHERE name = 'Alice Johnson';

-- Verify the update
SELECT id, name, borrowed_books FROM patrons WHERE name = 'Alice Johnson';

-- Add book ID 3 to Carol White's borrowed books
UPDATE patrons 
SET borrowed_books = array_append(borrowed_books, 3) 
WHERE email = 'carol@example.com';

-- Verify the update
SELECT id, name, email, borrowed_books FROM patrons WHERE email = 'carol@example.com';

-- ============================================
-- Complete Borrow Transaction Example
-- Marks book as unavailable AND adds to patron's record
-- ============================================

-- Borrow book ID 10 (The Hobbit) for patron Eve Davis
UPDATE books SET available = FALSE WHERE id = 10;
UPDATE patrons SET borrowed_books = array_append(borrowed_books, 10) WHERE name = 'Eve Davis';

-- Verify both updates
SELECT 'Book Status:' AS info, id, title, available FROM books WHERE id = 10;
SELECT 'Patron Record:' AS info, id, name, borrowed_books FROM patrons WHERE name = 'Eve Davis';

-- ============================================
-- Return a Book Example
-- Marks book as available AND removes from patron's record
-- ============================================

-- Return book ID 1 from Bob Smith
UPDATE books SET available = TRUE WHERE id = 1;
UPDATE patrons SET borrowed_books = array_remove(borrowed_books, 1) WHERE name = 'Bob Smith';

-- Verify both updates
SELECT 'Book Status:' AS info, id, title, available FROM books WHERE id = 1;
SELECT 'Patron Record:' AS info, id, name, borrowed_books FROM patrons WHERE name = 'Bob Smith';
