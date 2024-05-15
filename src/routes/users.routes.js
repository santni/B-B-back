const express = require('express');
const router = express.Router();
const usersController = require('../controllers/users.controller');

router.get('/', usersController.getAllUsers);
router.post('/', usersController.postUser);
router.patch('/:id', usersController.patchUser);
router.delete('/:id', usersController.deleteUser);

module.exports = router;