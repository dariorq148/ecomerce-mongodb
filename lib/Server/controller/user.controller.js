const UserService = require('../services/user.service');

exports.register = async(req, res, next) => {
    try {
        const { name, lastname, email, password } = req.body;
        await UserService.registerUser(name, lastname, email, password);
        res.json({ status: true, success: 'Usuario registrado con éxito' });
    } catch (error) {
        res.status(400).json({ status: false, message: error.message });
    }
}

exports.login = async(req, res, next) => {
    try {
        const { email, password } = req.body;
        const loginres = await UserService.loginUser(email, password);
        res.json({ status: true, success: loginres.message, user: loginres.user });


    } catch (error) {
        res.status(400).json({ status: false, message: error.message });
    }
}