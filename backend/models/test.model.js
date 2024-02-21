const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const userSchema = new Schema({
    _id: {
        type: mongoose.Schema.Types.ObjectId,
    },
    name: {
        type: String,
    },
    email: {
        type: String,
    },
    age: {
        type: Number,
    },
    hobbies: [{
        type: String
    }]
}, { versionKey: false });

// Export the model, adjusting the names to match your data
module.exports = mongoose.model('User', userSchema, 'Ishant Tester Collection');