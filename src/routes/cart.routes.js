const express = require('express');
const router = express.Router();
const cartController = require('../controllers/cart.controller');

router.get('/user/:useremail', cartController.getOrdersInCart);
router.get('/:id', cartController.getOrderById);
router.get('/state/:email', cartController.getOrderByState);
router.post('/', cartController.postOrder);
router.patch('/state/:id', cartController.alterOrderState);
router.put('/:id', cartController.updateOrder);
router.delete('/:id', cartController.deleteOrder);

module.exports = router;