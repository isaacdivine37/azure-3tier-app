const express = require('express');
const { Pool } = require('pg');
const router = express.Router();

// PostgreSQL connection
const pool = new Pool({
    connectionString: process.env.DATABASE_URL || 'postgresql://localhost:5432/testdb',
    ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false
});

// Test database connection
router.get('/db-test', async (req, res) => {
    try {
        const client = await pool.connect();
        const result = await client.query('SELECT NOW() as current_time');
        client.release();

        res.json({
            message: 'Database connection successful',
            timestamp: result.rows[0].current_time
        });
    } catch (err) {
        console.error('Database connection error:', err);
        res.status(500).json({
            error: 'Database connection failed',
            details: process.env.NODE_ENV === 'development' ? err.message : 'Internal server error'
        });
    }
});

// Sample API endpoints
router.get('/users', async (req, res) => {
    try {
        // In a real app, this would query the database
        const users = [
            { id: 1, name: 'John Doe', email: 'john@example.com' },
            { id: 2, name: 'Jane Smith', email: 'jane@example.com' }
        ];

        res.json({
            users,
            count: users.length,
            timestamp: new Date().toISOString()
        });
    } catch (err) {
        res.status(500).json({ error: 'Failed to fetch users' });
    }
});

router.post('/users', async (req, res) => {
    try {
        const { name, email } = req.body;

        if (!name || !email) {
            return res.status(400).json({ error: 'Name and email are required' });
        }

        // In a real app, this would insert into the database
        const newUser = {
            id: Date.now(),
            name,
            email,
            created_at: new Date().toISOString()
        };

        res.status(201).json({
            message: 'User created successfully',
            user: newUser
        });
    } catch (err) {
        res.status(500).json({ error: 'Failed to create user' });
    }
});

module.exports = router;