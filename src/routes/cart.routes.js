const express = require('express');
const router = express.Router();
const cartController = require('../controllers/cart.controller');

router.get('/user/:useremail', cartController.getOrdersInCart);
router.get('/:id', cartController);
router.post('/', cartController.postOrder);

module.exports = router;