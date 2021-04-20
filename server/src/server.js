const express = require('express');
const dotenv = require('dotenv');
const cors = require('cors');
const HttpException = require('./utils/HttpException.utils');
const errorMiddleware = require('./middleware/error.middleware');
const userRouter = require('./routes/user.route');

//Init Express
const app = express();

//Init enviroment
dotenv.config();

//Use Express
app.use(express.json());

//Enable Cors
app.use(cors());

//Enable pre-flight
app.options("*", cors());

//Use Port
const port = Number(process.env.PORT || 3001);

//Use Router
app.use('api/v1/users', userRouter);

//404 Error
app.all('*', (req, res, next) => {
    const err = new HttpException(404, 'Endpoint Not Found');
    next(err);
});

//Error middleware
app.use(errorMiddleware);

//Starting the server
app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});

module.exports = app;