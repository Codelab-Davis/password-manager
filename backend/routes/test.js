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

router.post('/add', async(req, res) => {
    try {
        const user = await User.create(req.body);
        res.status(200).json(user);
    }
    catch (err) {
        console.log(err);
    }
});

router.put('/update/:id', async (req, res) => {
    try {
        const user = await User.findById(req.params.id);
      
        if (user) {
          user.name = req.body.name;
          user.age = req.body.age;
          user.email = req.body.email;
      
          await user.save();
          res.status(200).json('User updated!');
        } 
        else{
            res.status(400).json('User not found');
        }
      } 
      catch (err) {
        console.error(err);
        res.status(500).json('Internal Server Error');
      }
}
);

router.delete('/del/:id', async (req, res) => {
    try {
        const user = await User.findById(req.params.id);

        if (!user) {
            return res.status(400).json('No user found to be deleted.' );
        }

        await User.findByIdAndDelete(req.params.id);
        res.status(200).json('User deleted!' );
    } 
    catch (err) {
        console.error(err);
        res.status(500).json('Internal Server Error');
    }
}
);

router.get('/filter/:field/:value', async (req, res) => {
    try {
        const field = req.params.field;
        const value = req.params.value;
        const user = await User.find({
            [field]: value
        });
        if (!user) {
            return res.status(400).json('No user found.' );
        }
        res.status(200).json(user);
    }
    catch (err) {
        console.error(err);
        res.status(500).json('Internal Server Error');
    }
}
);




module.exports = router;