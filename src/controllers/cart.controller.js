const pool = require('../config/database.config');

const getOrdersInCart = async(req, res) => {
    try {
        const { id } = req.params;

        const orders = await pool.query('SELECT * FROM orders WHERE id=$1 AND state=$2 OR state=$3',[id, 'pending', 'delivering']);

        return orders.rowCount > 0 ? 
            res.status(200).send({ total: orders.rowCount, orders: orders.rows }) :
            res.status(200).send({ message: 'There are no pending orders' });
    } catch(e) {
        console.log('Could not GET orders, server error', e);
        return res.status(500).send({ message: 'Could not HTTP GET' });
    }
}

module.exports = { getOrdersInCart };