const express = require('express');
const router = express.Router();
const User = require('../models/test.model.js');
const mongoose = require('mongoose');

//GET ALL USERS
router.get('/', async (req, res) => {
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

router.post("/add", async (req, res) => {
    try {
        const user = await User.create(req.body);
        res.status(200).json(user);
    }
    catch (err) {
        console.log(err);
    }
});


router.put('/update/:email', async (req, res) => {
    try {
        const email = req.params.email;
        const user = await User.findOne({ email: email });

        if (user) {
            user.twoFAType = req.body.twoFAType;

            await user.save();
            res.status(200).json('User updated!');
        } else {
            res.status(404).json('User not found');
        }
    } catch (err) {
        console.error(err);
        res.status(500).json('Internal Server Error');
    }
});

router.delete('/del/:id', async (req, res) => {
    try {
        const user = await User.findById(req.params.id);

        if (!user) {
            return res.status(400).json('No user found to be deleted.');
        }

        await User.findByIdAndDelete(req.params.id);
        res.status(200).json('User deleted!');
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
            return res.status(400).json('No user found.');
        }
        res.status(200).json(user);
    }
    catch (err) {
        console.error(err);
        res.status(500).json('Internal Server Error');
    }
}
);

router.get('/:id', (req, res) => {
    const { id } = req.params;
    User.findById(id)
        .then(user => {
            if (!user) {
                return res.status(400).json({ error: "Item not found" });
            }
            return res.status(200).json(user);
        })
        .catch(err => {
            return res.status(500).json({ error: err });
        });
    return;
});

// Get by email and password
router.get('/:email/:password', (req, res) => {
    const { email, password } = req.query;
    User.find({ email: email, password: password }).then(
        user => {
            if (!user) {
                return res.status(400).json({ error: "Invalid email or password" });
            }
            return res.status(200).json(user);
        })
        .catch(err => {
            return res.status(500).json({ error: err });
        });
    return;
});

router.put('/updateAccounts/:id', async (req, res) => {
    try {
        const user = await User.findById(req.params.id);

        if (user) {
            _appName = req.body.appName;
            _username = req.body.username;
            _password = req.body.password;
            _notes = req.body.notes;

            user.accounts.push({appName: _appName, username: _username, password: _password, notes: _notes});

            await user.save();
            res.status(200).json('User updated!');
        }
        else {
            res.status(400).json('User not found');
        }
    }
    catch (err) {
        console.error(err);
        res.status(500).json('Internal Server Error');
    }
}
);

module.exports = router;