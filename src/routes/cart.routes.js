const express = require('express');
const router = express.Router();
const cartController = require('../controllers/cart.controller');

router.get('/:useremail', cartController.getOrdersInCart);

module.exports = router;