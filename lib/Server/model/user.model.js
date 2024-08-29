const mongoose = require('mongoose');
const db = require('../config/db');
const bcrypt = require('bcrypt');
const { Schema } = mongoose;
const UserSchema = new Schema({
    name: {
        type: String,
        lowercase: true,
        required: true,

    },
    lastname: {
        type: String,
        lowercase: true,
        required: true,

    },
    email: {
        type: String,
        lowercase: true,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    }
});
UserSchema.pre('save', async function(next) {
    try {
        const user = this;
        if (!user.isModified('password')) return next();

        const salt = await bcrypt.genSalt(10);
        const hashpass = await bcrypt.hash(user.password, salt);
        user.password = hashpass;
        next();
    } catch (error) {
        next(error);
    }
});
const UserModel = db.model('user', UserSchema);
module.exports = UserModel;