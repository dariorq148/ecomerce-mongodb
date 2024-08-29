const UserModel = require('../model/user.model');
const bcrypt = require('bcrypt');

class UserService {
    static async registerUser(name, lastname, email, password) {
            try {
                // Verificar si el usuario ya existe
                const existingUser = await UserModel.findOne({ email });
                if (existingUser) {
                    throw new Error('El usuario ya existe');
                }

                // Crear y guardar el nuevo usuario
                const createUser = new UserModel({
                    name,
                    lastname,
                    email,
                    password,
                });

                return await createUser.save();

            } catch (error) {
                throw new Error(error.message);
            }
        }
        //login
    static async loginUser(email, password) {
        try {
            const userExist = await UserModel.findOne({ email });
            if (!userExist) {
                throw new Error('el usuario no existe');
            }
            const isMatch = await bcrypt.compare(password, userExist.password);
            if (!isMatch) {
                throw new Error('contraseña incorrecta');
            }
            return { message: 'Inicio exitoso', user: userExist };
        } catch (error) {
            throw new Error(error.message);
        }
    }
}

module.exports = UserService;