require('dotenv').config();
const express = require('express');
const ordersRouter = require('./routes/orders.routes');
const usersRouter = require('./routes/users.routes');
const addressRouter = require('./routes/address.routes');
const restaurantsRouter = require('./routes/restaurants.routes')

const port = process.env.PORT;

const app = express();
app.use(express.json());

app.use('/orders', ordersRouter);
app.use('/users', usersRouter);
app.use('/address', addressRouter);
app.use('/restaurants', restaurantsRouter);

app.listen(port, () => console.log(`Servidor iniciado em http://localhost:${port}`));