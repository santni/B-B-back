const express = require('express');
const router = express.Router();
const productsControllers = require('../controllers/products.controller');

router.get('/:id', productsControllers.getAllProducts);
router.get('/product/:id', productsControllers.getProductById);

module.exports = { router };