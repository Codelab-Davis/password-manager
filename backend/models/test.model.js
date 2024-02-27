const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const userSchema = new Schema({
    _id: {
        type: Number,
    },
    name: {
        type: String,
    },
    email: {
        type: String,
    },
    age: {
        type: Number,
    }
}, { versionKey: false });

// Export the model, adjusting the names to match your data
module.exports = mongoose.model('User', userSchema, 'Ishant Tester Collection');