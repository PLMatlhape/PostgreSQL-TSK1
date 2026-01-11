-- ============================================
-- Library Management System - Delete Operations
-- Sprint 5: Delete Operations
-- ============================================

-- ============================================
-- 1. Delete a Book by Title
-- Successfully deletes a book by title
-- ============================================

-- First, check the book exists
SELECT id, title, author_id FROM books WHERE title = 'Moby-Dick';

-- Delete the book by title
DELETE FROM books 
WHERE title = 'Moby-Dick';

-- Verify the book was deleted
SELECT id, title FROM books WHERE title = 'Moby-Dick';
-- Expected: No rows returned

-- Alternative: Delete with case-insensitive match
DELETE FROM books 
WHERE LOWER(title) = LOWER('The Hobbit');

-- ============================================
-- 2. Delete an Author by ID
-- Successfully deletes an author by ID
-- Note: This will also delete associated books due to CASCADE
-- ============================================

-- First, check the author and their books
SELECT a.id, a.name, b.title 
FROM authors a 
LEFT JOIN books b ON a.id = b.author_id 
WHERE a.id = 6;

-- Delete the author by ID
DELETE FROM authors 
WHERE id = 6;

-- Verify the author was deleted
SELECT id, name FROM authors WHERE id = 6;
-- Expected: No rows returned

-- Verify cascade deleted related books
SELECT id, title FROM books WHERE author_id = 6;
-- Expected: No rows returned (books were cascade deleted)

-- ============================================
-- Safe Delete Example (Check before delete)
-- ============================================

-- Check if author exists before deleting
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM authors WHERE id = 7) THEN
        DELETE FROM authors WHERE id = 7;
        RAISE NOTICE 'Author with ID 7 deleted successfully';
    ELSE
        RAISE NOTICE 'Author with ID 7 does not exist';
    END IF;
END $$;

-- ============================================
-- Delete with Returning (PostgreSQL feature)
-- Returns the deleted row data
-- ============================================

-- Delete and return the deleted book info
DELETE FROM books 
WHERE title = 'Pride and Prejudice' 
RETURNING id, title, author_id;

-- Delete and return the deleted author info
DELETE FROM authors 
WHERE name = 'Jane Austen' 
RETURNING id, name, nationality;
