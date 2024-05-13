const pool = require('../config/database.config');

async function getAllOrders(req, res) {
    try {
        const orders = await pool.query('SELECT * FROM orders');
        return orders.rowCount > 0 ? res.status(200).send({ total: orders.rowCount, orders: orders }) :
        res.status(200).send({ message: 'Não foi feito nenhum pedido' });
    } catch(e) {
        console.error('Erro ao obter todos os pedidos', e);
        res.status(500).send({ mensagem: 'Erro ao obter todos os pedidos' });
    }
}