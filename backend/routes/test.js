const express = require('express');
const router = express.Router();
const User = require('../models/test.model.js');


router.get('/', (req, res) => {
    console.log("retrieved all users from the database")
    User.find()
        .then(users => res.json(users))
        .catch(err => res.status(400).json('Error: ' + err));
});



module.exports = router;