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



const User = require('../models/test.model.js');
const mongoose = require('mongoose');

router.post("/", (req, res) => {
    const { name, email, age, hobbies } = req.body;

    if(!name || !email || !age || !hobbies) {
        return res.status(400).json({error: "Not all attributes provided"});
    }

    const user = new User({ _id: new mongoose.Types.ObjectId(), name, email, age, hobbies });

    user.save()
    .then(savedUser => {
      res.status(201).json(savedUser);
    })
    .catch(err => {
      res.status(500).json({error: err});
    });

    return;
});

router.get('/:id', (req, res) => {
    const { id } = req.params;
    User.findById(id)
    .then(user => {
        if(!user){
            return res.status(400).json({error: "Item not found"});
        }
        return res.status(200).json(user);
    })
    .catch(err => {
        return res.status(500).json({error: err});
    });

    return;
});

module.exports = router;