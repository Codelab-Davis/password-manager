const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const accountSchema = new Schema({
    appName: { type: String }, username: { type: String }, password: { type: String }, notes: { type: String },
}, { versionKey: false });
const userSchema = new Schema({
    _id: {
        type: mongoose.Schema.Types.ObjectId,
        required: false,
        default: function () {
            return new mongoose.Types.ObjectId();
        }
    },
    firstName: {
        type: String,
    },
    lastName: {
        type: String,
    },
    email: {
        type: String,
    },
    phoneNumber: {
        type: String,
    },
    password: {
        type: String,
    },
    accounts: {
        type: [accountSchema],
    }
}, { versionKey: false });
// Export the model, adjusting the names to match your data
module.exports = mongoose.model('User', userSchema, 'Ishant Tester Collection');