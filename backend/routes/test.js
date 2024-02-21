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
        res.status(200).json(User);
    }
    catch (err) {
        console.log(err);
    }
});


module.exports = router;