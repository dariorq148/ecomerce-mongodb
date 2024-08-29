const router = require('express').Router();

const UserController = require('../controller/user.controller');
router.post('/registeruser', UserController.register);
router.post('/login', UserController.login);
module.exports = router;