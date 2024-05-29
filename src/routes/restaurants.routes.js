const express = require('express');
const router = express.Router();
const restaurantsController = require('../controllers/restaurants.controller')

router.get('/', restaurantsController.getRestaurants);
router.get('/:nome', restaurantsController.getRestaurantsByName);
router.get('/:id', restaurantsController.getRestaurantsById);
router.post('/', restaurantsController.postRestaurants);
router.put('/', restaurantsController.putRestaurants);
router.delete('/:id', restaurantsController.deleteRestaurantsById);

module.exports = router;