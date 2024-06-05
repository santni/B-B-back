const express = require('express');
const router = express.Router();
const cartController = require('../controllers/cart.controller');

router.get('/user/:useremail', cartController.getOrdersInCart);
router.get('/:id');
router.post('/', )

module.exports = router;