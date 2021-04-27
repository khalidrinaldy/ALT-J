const express = require('express');
const app = express();
const port = process.env.PORT || 4000   ;
const authRoute = require('./routes/auth');
const mongoose = require('mongoose');
const dotenv = require('dotenv');
const test = require('./routes/tests');

dotenv.config();

//Connect to mongoose
mongoose.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true, useNewUrlParser: true },
    () => console.log("Connected to mongoose")
);


//body parser json express
app.use(express.json());

//Use authroute
app.use('/api/user', authRoute);
app.use('/api/test', test);

app.listen(port, () => console.log(`Connected to port ${port}`));