const pool = require('../config/database.config');

const getAlladdress = async(req, res) => {
    try {
        const allAddress = await pool.query('SELECT * FROM address;');
        return allAddress.rowCount > 0 ?
            res.status(200).send({ total: allAddress.rowCount, address: allAddress.rows }) :
            res.status(200).send({ message: 'None address registered' });
    } catch(e) {
        console.log('Could not GET all address, server error', e);
        return res.status(500).send({ message: 'Could not HTTP GET' });
    }
}

const getAddressById = async(req, res) => {
    try {
        const { id } = req.params;

        const address = await pool.query('SELECT * FROM address WHERE id=$1', [id]);
        return address.rowCount > 0 ?
            res.status(200).send(address.rows[0]) :
            res.status(404).send({ message: 'Address not found' });
    } catch(e) {
        console.log('Could not GET address, server error', e);
        return res.status(500).send({ message: 'Could not HTTP GET' });
    }
}

const postAddress = async(req, res) => {
    try {
        const { state, city, neighborhood, number, complement, cep, street, userEmail } = req.body;

        const user = (await pool.query('SELECT * FROM users WHERE email=$1',[userEmail])).rows;

        if(!user) {
            res.status(404).send({ message: 'user not found' });
        }

        if(!state || !city || !neighborhood || !number || !complement || !cep || !street) {
            return res.status(400).send({ message: 'Inomplete data' });
        } else if(typeof state !== 'string' || typeof city !== 'string' || typeof neighborhood !== 'string' || typeof number !== 'number' || typeof complement !== 'string' || typeof cep !== 'number' || typeof street !== 'string') {
            return res.state(400).send({ message: 'Invalid types' });
        } else if(cep.length !== 8) {
            return res.state(400).send({ message: 'Invalid CEP' });
        } else {
            const id = await pool.query('INSERT INTO address(state, city, neighborhood, number, complement, cep, street) VALUES($1, $2, $3, $4, $5, $6, $7) RETURNING id',
        [state, city, neighborhood, number, complement, cep, street]);
            await pool.query('UPDATE users SET address=$1 WHERE email=$2',
                [id, userEmail]);
            return res.status(201).send({ message: 'address successfully registered' });
        }
    } catch(e) {
        console.log('Could not POST address, server error', e);
        return res.status(500).send({ message: 'Could not HTTP POST' });
    }
}

const putAddress = async(req, res) => {
    try {
        const { id } = req.params;
        const { state, city, neighborhood, number, complement, cep, userEmail } = req.body;

        const address = getAddressById(id);
        if(!address) {
            return res.status(404).send({ message: 'address not found' });
        }
    
        const user = (await pool.query('SELECT * FROM users WHERE email=$1',[userEmail])).rows;
        if(!user) {
            res.status(404).send({ message: 'user not found' });
        }

        if(!state || !city || !neighborhood || !number || !complement || !cep) {
            return res.status(400).send({ message: 'Incomplete data' });
        } else if(typeof state !== 'string' || typeof city !== 'string' || typeof neighborhood !== 'string' || typeof number !== 'number' || typeof complement !== 'string' || typeof cep !== 'number') {
            return res.state(400).send({ message: 'Invalid types' });
        } else if(cep.length !== 8) {
            return res.state(400).send({ message: 'Invalid CEP' });
        } else {
            await pool.query('UPDATE address SET state=$1, city=$2, neighborhood=$3, number=$3, complement=$4, cep=$5 WHERE id=$6',
        [state, city, neighborhood, number, complement, cep, id]);
            await pool.query('UPDATE users SET address=$1 WHERE email=$2',
                [id,userEmail]);
            return res.status(201).send({ message: 'address successfully registered' });
        }
    } catch(e) {
        console.log('Could not PUT address, server error', e);
        return res.status(500).send({ message: 'Could not HTTP PUT' });
    }
}

const deleteAddress = async(req, res) => {
    try {
        const { id } = req.params;

        const address = getAddressById(id);
        if(!address) {
            return res.status(404).send({ message: 'address not found' });
        } else {
            await pool.query('DELETE FROM address WHERE id=$1',[id]);
            return res.status(200).send({ message: 'address successfully deleted' });
        }
    } catch(e) {
        console.log('Could not DELETE address, server error', e);
        return res.status(500).send({ message: 'Could not HTTP DELETE' });
    }
}

module.exports = { getAlladdress, getAddressById, postAddress, putAddress, deleteAddress };