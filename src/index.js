require('dotenv').config();
const express = require('express');
const cors = require('cors');
const usersRouter = require('./routes/users.routes');
const addressRouter = require('./routes/address.routes');
const cartRouter = require('./routes/cart.routes');
const restaurantsRouter = require('./routes/restaurants.routes');

const port = process.env.PORT;

const app = express();
app.use(express.json());
app.use(cors());

app.use('/users', usersRouter);
app.use('/address', addressRouter);
app.use('/cart', cartRouter);
app.use('/restaurants', restaurantsRouter);

app.listen(port, () => console.log(`Servidor iniciado em http://localhost:${port}`));