const express = require('express');
const router = express.Router(); 
const avaliationsController = require('../controllers/avaliations.controller');

router.get('/:restaurant', avaliationsController.getAvaliations);
router.post('/:user', avaliationsController);

module.exports = router;