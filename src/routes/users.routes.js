const express = require('express');
const router = express.Router();
const usersController = require('../controllers/users.controller');

router.get('/', usersController.getAllUsers);
router.get('/:email', usersController.getUserByEmail);
router.get('/cpf/:cpf', usersController.getUserByCPF);
router.post('/', usersController.postUser);
router.put('/:email', usersController.putUser);
router.delete('/:email', usersController.deleteUser);

module.exports = router;