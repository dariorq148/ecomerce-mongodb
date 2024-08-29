const app = require('./app');
const port = 3000;
const db = require('./config/db');
const UserModel = require('./model/user.model');
const cors = require('cors');
app.use(cors());

app.get('/',
    (req, res) => {
        res.send('conectado');
    }
);
app.listen(port, () => {
    console.log(`Server is running on port http://localhost:${port}`);
});