const express = require('express');
const router = express.Router();
const productsControllers = require('../controllers/products.controller');

router.get('/:id', productsControllers.getAllProducts);
router.get('/product/:id', productsControllers.getProductById);
router.post('/', productsControllers.postController);
router.put('/product/:id', productsControllers.putController);
router.delete('/product/:id', productsControllers.deleteController)

module.exports = { router };