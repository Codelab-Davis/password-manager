const express = require('express');
const router = express.Router();
const User = require('../models/test.model.js');


router.get('/', (req, res) => {
    console.log("retrieved all users from the database")
    User.find()
        .then(users => res.json(users))
        .catch(err => res.status(400).json('Error: ' + err));
});

router.post('/add', async(req, res) => {
    try {
        const user = await User.create(req.body);
        const allUsers = await User.find(); // Retrieve all users after creating a new user
        res.status(200).json(allUsers);
    }
    catch (err) {
        console.log(err);
    }
});


module.exports = router;