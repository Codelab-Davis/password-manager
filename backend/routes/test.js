const express = require('express');
const router = express.Router();
const User = require('../models/test.model.js'); //hEllo

//GET ALL USERS
router.get('/', async(req, res) => {    
    try {
        console.log("retrieved all users from the database")
        User.find()
            .then(users => res.json(users))
            .catch(err => res.status(400).json('Error: ' + err));
    }
    catch (err) {
        console.log(err)
    }
});
/*
router.getUser('/', async(req, res) => {    
    try {
        console.log("retrieved all users from the database")
        User.find()
            .then(users => res.json(users))
            .catch(err => res.status(400).json('Error: ' + err));
    }
    catch (err) {
        console.log(err)
    }
});
*/

router.post("/add", async(req, res) => {
    try {
        const user = await User.create(req.body);
        res.status(200).json(user);
    }
    catch (err) {
        console.log(err);
    }
});






module.exports = router;