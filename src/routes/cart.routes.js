const express = require('express');
const router = express.Router();
const cartController = require('../controllers/cart.controller');

router.get('/user/:useremail', cartController.getOrdersInCart);
router.post('/', cartController.postOrder);
router.patch('/state/:id', cartController.alterOrderState);

module.exports = router;