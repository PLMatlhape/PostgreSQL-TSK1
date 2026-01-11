-- ============================================
-- Library Management System - Complete Setup Script
-- Run this file to set up the entire database
-- ============================================

-- Step 1: Connect to PostgreSQL and create the database
-- Run this in psql: CREATE DATABASE LibraryDB;
-- Then connect: \c LibraryDB

-- Step 2: Create all tables
\i sql/02_create_tables.sql

-- Step 3: Insert all data
\i sql/03_insert_authors.sql
\i sql/04_insert_books.sql
\i sql/05_insert_patrons.sql

-- Step 4: Verify setup
SELECT 'Authors:' AS table_name, COUNT(*) AS count FROM authors
UNION ALL
SELECT 'Books:', COUNT(*) FROM books
UNION ALL
SELECT 'Patrons:', COUNT(*) FROM patrons;

-- Display success message
SELECT '✓ Library Management System setup complete!' AS status;
