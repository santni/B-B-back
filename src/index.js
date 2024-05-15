require('dotenv').config();
const express = require('express');
const ordersRouter = require('./routes/orders.routes');
const usersRouter = require('./routes/users.routes');

const port = process.env.PORT;

const app = express();
app.use(express.json());

app.use('/orders', ordersRouter);
app.use('/users', usersRouter);

app.listen(port, () => console.log(`Servidor iniciado em http://localhost:${port}`));
