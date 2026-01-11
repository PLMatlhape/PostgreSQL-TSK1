-- ============================================
-- Library Management System - Table Creation
-- Sprint 1: Project Setup
-- ============================================

-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS patrons CASCADE;
DROP TABLE IF EXISTS books CASCADE;
DROP TABLE IF EXISTS authors CASCADE;

-- ============================================
-- Create Authors Table
-- ============================================
CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    nationality VARCHAR(50),
    birth_year INTEGER,
    death_year INTEGER
);

-- ============================================
-- Create Books Table
-- ============================================
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author_id INTEGER NOT NULL,
    genres TEXT[],
    published_year INTEGER,
    available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (author_id) REFERENCES authors(id) ON DELETE CASCADE
);

-- ============================================
-- Create Patrons Table
-- ============================================
CREATE TABLE patrons (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    borrowed_books INTEGER[]
);

-- Verify tables were created
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_type = 'BASE TABLE';
