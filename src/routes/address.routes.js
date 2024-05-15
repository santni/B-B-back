const express = require('express');
const router = express.Router();
const addressController = require('../controllers/address.controller');

router.get('/', addressController.getAlladdress);
router.get('/:id', addressController.getAddressById);
router.post('/', addressController.postAddress);
router.patch('/:id', addressController.patchAddress)

module.exports = router;