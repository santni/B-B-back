const pool = require('../config/database.config');

const getOrdersInCart = async(req, res) => {
    try {
        const { useremail } = req.params;

        const orders = await pool.query(`SELECT 
        orders.id AS order_id,
        orders.dateandhour AS order_date,
        orders.state AS order_state,
        restaurants.name AS restaurant_name,
        STRING_AGG(products.name || ' (Quantity: ' || itensorders.quantity || ', Price: ' || products.price || ')', ', ') AS products_details,
        SUM(itensorders.quantity * products.price) AS total_price
    FROM 
        orders
    INNER JOIN 
        itensorders ON orders.id = itensorders.orderid
    INNER JOIN 
        products ON itensorders.productid = products.id
    INNER JOIN 
        restaurants ON orders.restaurantid = restaurants.id
    WHERE 
        orders.userEmail = $1
    GROUP BY 
        orders.id, orders.dateandhour, orders.state, restaurants.name;
    `,[useremail]);
        return orders.rowCount > 0 ? 
            res.status(200).send({ total: orders.rowCount, orders: orders.rows }) :
            res.status(200).send({ message: 'There are no pending orders' });
    } catch(e) {
        console.log('Could not GET orders, server error', e);
        return res.status(500).send({ message: 'Could not HTTP GET' });
    }
}

const getOrderById = async(req, res) => {
    try {
        const { id } = req.params;
        const order = await pool.query('SELECT * FROM orders WHERE id=$1',[id]);
        return order.rowCount > 0 ? 
        res.status(200).send(order.rows[0]) :
        res.status(200).send({ message: 'order not found' });
    } catch(e) {
        console.log('Could not GET orders, server error', e);
        return res.status(500).send({ message: 'Could not HTTP GET' });
    }
}

const postOrder = async (req, res) => {
    try {
        const { userEmail, restaurantID, dateandhour, state, itens } = req.body;
        const abstractDate = new Date(dateandhour);

        const newDate = `${abstractDate.getDate()}-${abstractDate.getMonth()}-${abstractDate.getFullYear()} ${abstractDate.getHours()}-${abstractDate.getMinutes()}`;

        const orderReq = await pool.query(
            'INSERT INTO orders (userEmail, restaurantID, dateandhour, state) VALUES ($1, $2, $3, $4) RETURNING id',
            [userEmail, restaurantID, newDate, state]
        );
        const orderId = orderReq.rows[0].id;

        for (const item of itens) {
            await pool.query(
                'INSERT INTO itensorders (orderid, productid, quantity) VALUES ($1, $2, $3)',
                [orderId, item.productid, item.quantity]
            );
        }
        return res.status(201).send({ message: 'posted order', order: orderId });
    } catch (error) {
        console.log('Could not POST HTTP', error);
        return res.status(500).send({ message: 'Erro interno' });
    }
};

const updateOrder = async (req, res) => {
    try {
        const { id } = req.params;
        const { userEmail, restaurantID, dateandhour, state, itens } = req.body;
        const abstractDate = new Date(dateandhour);

        const newDate = `${String(abstractDate.getDate()).padStart(2, '0')}-${String(abstractDate.getMonth() + 1).padStart(2, '0')}-${abstractDate.getFullYear()} ${String(abstractDate.getHours()).padStart(2, '0')}:${String(abstractDate.getMinutes()).padStart(2, '0')}`;

        const order = (await pool.query('SELECT * FROM orders WHERE id=$1', [id])).rows[0];

        if (!order) {
            return res.status(404).send({ message: 'This order does not exist' });
        }

        await pool.query('UPDATE orders SET useremail=$1, restaurantid=$2, dateandhour=$3, state=$4 WHERE id=$5',
            [userEmail, restaurantID, newDate, state, id]);

        for (const item of itens) {
            if (item.quantity > 0) {
                const existingItem = (await pool.query('SELECT * FROM itensorders WHERE orderid=$1 AND productid=$2', [id, item.productid])).rows[0];
                if (existingItem) {
                    await pool.query('UPDATE itensorders SET quantity=$1 WHERE orderid=$2 AND productid=$3',
                        [item.quantity, id, item.productid]);
                } else {
                    await pool.query('UPDATE itensorders SET productid=$2 quantity=$3 WHERE id=$1;',
                        [id, item.productid, item.quantity]);
                }
            } else {
                await pool.query('DELETE FROM itensorders WHERE orderid=$1 AND productid=$2',
                    [id, item.productid]);
            }
        }

        return res.status(200).send({ message: 'Updated order' });

    } catch (e) {
        console.error('Could not PUT HTTP', e);
        return res.status(500).send({ message: 'Internal error' });
    }
};


const alterOrderState = async(req, res) => {
    try {
        const { id } = req.params;
        const { state } = req.body;
    
        const order = (await pool.query('SELECT * FROM orders WHERE id=$1', [id])).rows;
    
        if(!order) {
            return res.status(404).send({ message: 'Order not found' });
        }
    
        await pool.query('UPDATE orders SET state=$1 WHERE id=$2',[state, id]);
        return res.status(200).send({ message: 'order state updated', state });
    } catch(e) {
        console.log('Could not POST HTTP', e);
        return res.status(500).send({ message: 'Erro interno' });
    }
}

const deleteOrder = async(req, res) => {
    try { 
        const { id } = req.params;

        const order = (await pool.query('SELECT * FROM orders WHERE id=$1', [id])).rows;
    
        if(!order) {
            return res.status(404).send({ message: 'Order not found' });
        }

        await pool.query('DELETE FROM orders WHERE id=$1',[id]);
        await pool.query('DELETE FROM itensorders WHERE orderid=$1', [id]);

    } catch(e) {
        console.log('Could not DELETE HTTP', e);
        return res.status(500).send({ message: 'Erro interno' });
    }
}

module.exports = { getOrdersInCart, postOrder, alterOrderState, updateOrder, getOrderById, deleteOrder };