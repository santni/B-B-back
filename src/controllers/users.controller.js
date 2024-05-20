const pool = require('../config/database.config');
const { verifyEmail, verifyCpf, verifyPassword } = require('../models/verify.functions');

const getAllUsers = async(req, res) => {
    try {
        const users = await pool.query('SELECT * FROM users;');
        return users.rowCount > 0 ?
            res.status(200).send({ total: users.rowCount, users: users.rows }) :
            res.status(200).send({ message: 'Users not registered' });
    } catch(e) {
        console.log('Could not GET all users, server error', e);
        return res.status(500).send({ message: 'Could not HTTP GET' });
    }
}

const getUserByEmail = async(req, res) => {
    try {
        const { email } = req.params;

        const user = await pool.query('SELECT * FROM users WHERE email=$1', [email]);
        return user.rowCount > 0 ?
            res.status(200).send( user.rows[0] ) :
            res.status(404).send({ message: 'User not found' });
    } catch(e) {
        console.log('Could not GET user by email, server error', e);
        return res.status(500).send({ message: 'Could not HTTP GET' }); 
    }
}

const postUser = async(req, res) => {
    try {
        const { name, email, cpf, telephone, password, address } = req.body;

        if(name.length < 10) {
            return res.status(400).send({ message: 'short_name' });
        } else if(!verifyEmail(email)) {
            return res.status(400).send({ message: 'invalid_email' });
        } else if(!verifyCpf(cpf)) {
            return res.status(400).send({ message: 'invalid_cpf' });
        } else if(telephone.length < 11) {
            return res.status(400).send({ message: 'invalid_telephone' });
        } else if(!verifyPassword(password)) {
            return res.status(400).send({ message: 'invalid_password' });
        } else {
            await pool.query('INSERT INTO users(name, email, cpf, telephone, password, address) VALUES($1, $2, $3, $4, $5, $6);',
        [name, email, cpf, telephone, password, address]);
            return res.status(201).send({ message: 'user successfully registered' });
        }
    } catch(e) {
        console.log('Could not POST user, server error', e);
        return res.status(500).send({ message: 'Could not HTTP POST' });
    }
}

const putUser = async(req, res) => {
    try {
        const { email } = req.params;
        const { name, cpf, telephone, password, address } = req.body;

        const user = getUserByEmail(email);
        
        if(!user) {
            return res.status(404).send({ message: 'User not found' });
        }
        
        if(name.length < 10) {
            return res.status(400).send({ message: 'short_name' });
        } else if(!verifyEmail(email)) {
            return res.status(400).send({ message: 'invalid_email' });
        } else if(!verifyCpf(cpf)) {
            return res.status(400).send({ message: 'invalid_cpf' });
        } else if(telephone.length < 11) {
            return res.status(400).send({ message: 'invalid_telephone' });
        } else if(!verifyPassword(password)) {
            return res.status(400).send({ message: 'invalid_password' });
        } else {
            await pool.query('UPDATE users SET name=$1, email=$2, cpf=$3, telephone=$4, password=$5, address=$6 WHERE email=$2;',
        [name, email, cpf, telephone, password, address]);
            return res.status(200).send({ message: 'user successfully updated' });
        }
    } catch(e) {
        console.log('Could not PUT user, server error', e);
        return res.status(500).send({ message: 'Could not HTTP PUT' });
    }
}

const deleteUser = async(req, res) => {
    try {
        const { email } = req.params;

        const user = getUserByEmail(email);
        if(!user) {
            return res.status(404).send({ message: 'User not found' });
        } else {
            await pool.query('DELETE FROM users WHERE email=$1', [email]);
            return res.status(200).send({ message: 'user successfully deleted' });   
        }
    } catch(e) {
        console.log('Could not DELETE user, server error', e);
        return res.status(500).send({ message: 'Could not HTTP DELETE' });
    }
}

module.exports = { getAllUsers, getUserByEmail, postUser, putUser, deleteUser };