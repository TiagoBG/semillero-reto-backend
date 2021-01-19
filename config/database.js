//CREATE THE CONNECTION WITH THE DATABASE USIMG MYSQL2 LIBRARY

//GET THE CLIENT
const mysql = require('mysql2');

//LOAD THE ENV CONFIGURATION
require('dotenv').config();

//CREATING THE CONNECTION
const connection_mysql = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_DATABASE,
    port: process.env.DB_PORT
});

module.exports = {
    cnn_mysql: connection_mysql
}