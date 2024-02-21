const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const userSchema = new Schema({
    _id: {
        type: mongoose.Schema.Types.ObjectId,
        required: true
    },
    name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true
    },
    age: {
        type: Number,
        required: true
    },
    hobbies: [{
        type: String
    }]
}, { versionKey: false });

// Export the model, adjusting the names to match your data
module.exports = mongoose.model('User', userSchema, 'Ishant Tester Collection');