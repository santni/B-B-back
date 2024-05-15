const pool = require('../config/database.config');

const getAllUsers = async(req, res) => {
    try {
        const users = await pool.query('SELECT * FROM users;');
        return users.rowCount > 0 ?
            res.status(200).send({ total: users.rowCount, users: users.rows }) :
            res.status(200).send({ message: 'Users not registered' });
    } catch(e) {
        console.log('Could not GET all users, server error', e);
        return res.status(500).send({ message: 'Could not GET all users' });
    }
}

module.exports = { getAllUsers };