const express = require('express');
const bodyParser = require ('body-parser')
const mongoose = require('mongoose');
const cors = require('cors');

require('dotenv').config()

const app = express();
const PORT = process.env.PORT || 5002;

app.use(express.json());
app.use(cors());

const uri = process.env.ATLAS_URI;

mongoose.connect(uri, {
    useNewUrlParser: true,
    useUnifiedTopology: true
});

const connection = mongoose.connection;
connection.once('open', () => {
    console.log("MongoDB database has been connected to successfully")
})

app.get('/', (req, res) => {
  res.send('backend is working');
});

const userRouter = require('./routes/test.js')
app.use('/test', userRouter);

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});