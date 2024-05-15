const express = require('express');
const router = express.Router();
const usersController = require('../controllers/users.controller');

router.get('/', usersController.getAllUsers);
router.get('/:email', usersController.getUserByEmail)
router.post('/', usersController.postUser);
router.patch('/:email', usersController.patchUser);
router.delete('/:email', usersController.deleteUser);

module.exports = router;