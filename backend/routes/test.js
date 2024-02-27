const express = require('express');
const router = express.Router();
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