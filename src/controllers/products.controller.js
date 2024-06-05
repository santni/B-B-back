const pool = require('../config/database.config');

const getAllProducts = async(req, res) => {
    try {
        const { id } = req.params;

        const products = await pool.query('SELECT * FROM products WHERE restaurantid = $1',
            [id]);

        return products.rowCount > 0 ? 
            res.status(200).send({ total: products.rowCount, products: products.rows }) :
            res.status(200).send({ message: 'this restaurant dont have products' });
        
    } catch(e) {
        console.log('Could not GET HTTP method');
        return res.status(505).send({ message: 'Error in GET' });
    }
}

const getProductById = async(req, res) => {
    try {
        const { id } = req.params;

        const products = await pool.query('SELECT * FROM products WHERE id = $1',
            [id]);

        return products.rowCount > 0 ? 
            res.status(200).send(products.rows[0]) :
            res.status(200).send({ message: 'this product doesnt exist' });
        
    } catch(e) {
        console.log('Could not GET HTTP method');
        return res.status(505).send({ message: 'Error in GET' });
    }
}

const postController = async(req, res) => {
    try {
        const { name, description, price, restaurantid } = req.body;

        if(!name || !description || !price || !restaurantid) {
            res.status(200).send({ message: 'complete all data' });
        } else if(name.length < 3) {
            res.status(200).send({ message: 'short name' });
        } else if(description.length < 10) {
            res.status(200).send({ message: 'short description' });
        } else if(typeof price !== 'number' || typeof restaurantid !== 'number') {
            res.status(200).send({ message: 'type is not a number' });
        } else {
            await pool.query('INSERT INTO products(name, description, price, restaurantid) VALUES($1, $2, $3, $4)',
            [name, description, price, restaurantid]);
        }
        
    } catch(e) {
        console.log('Could not POST HTTP method');
        return res.status(505).send({ message: 'Error in POST' });
    }
}

module.exports = { getAllProducts, getProductById, postController };