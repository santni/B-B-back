const pool = require('../config/database.config');
const { verifyCEP } = require('../models/verify.functions');

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
        const { state, city, neighborhood, number, complement, cep } = req.body;

        if(!state || !city || !neighborhood || !number || !complement || !cep) {
            return res.status(400).send({ message: 'Complete data' });
        } else if(typeof state !== 'string' || typeof city !== 'string' || typeof neighborhood !== 'string' || typeof number !== 'number' || typeof complement !== 'string' || typeof cep !== 'number') {
            return res.state(400).send({ message: 'Invalid types' });
        } else if(!verifyCEP(cep)) {
            return res.state(400).send({ message: 'Invalid CEP' });
        } else {
            await pool.query('INSERT INTO address(state, city, neighborhood, number, complement, cep) VALUES($1, $2, $3, $4, $5, $6)',
        [state, city, neighborhood, number, complement, cep]);
            return res.status(201).send({ message: 'address successfully registered' });
        }
    } catch(e) {
        console.log('Could not POST address, server error', e);
        return res.status(500).send({ message: 'Could not HTTP POST' });
    }
}

const patchAddress = async(req, res) => {
    try {
        const { id } = req.params;
    } catch(e) {
        console.log('Could not PATCH address, server error', e);
        return res.status(500).send({ message: 'Could not HTTP PATCH' });
    }
}

module.exports = { getAlladdress, getAddressById, postAddress, patchAddress };