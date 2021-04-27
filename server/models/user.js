const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        max: 255
    },
    email: {
        type: String,
        required: true,
        max: 255
    },
    password: {
        type: String,
        required: true,
        max: 1024
    },
    schedule: [
        {
            course: String,
            lecture: String,
            from: Date,
            to: Date
        }
    ],
    tasks: [
        {
            task_name: String,
            course: String,
            deadline: Date
        }
    ],
    meeting: [
        {
            activity: String,
            ormawa: String,
            schedule: Date
        }
    ]
});

module.exports = mongoose.model('User', userSchema);

/* const User = module.exports = mongoose.model('User', userSchema);

module.exports.get = (callback, limit) => {
    User.find(callback).limit(limit);
} */