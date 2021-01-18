//SERVER DEPLOYMENT WITH EXPRESS
const express = require('express');
const morgan = require('morgan');
const path = require('path'); 
const app = express();

//LOADING THE STABLISHED ROUTES
const vehiculos = require('./routes/vehiculos');
const modelo = require('./routes/modelo');
const tipo_linea = require('./routes/tipo_linea');
const tipo_marca = require('./routes/tipo_marca');

//USING dotenv LIBRARY TO SET THE ENV VARIABLES
require('dotenv').config();

//USING MORGAN MIDDLEWARES
app.use(morgan('dev'));

//ROUTES
app.use('/api', vehiculos);

//PAGES AND RENDERING IN DOM
app.get('/',(req, res)=>{
    res.send('<h1>SEMILLERO S.A.S</h1>')
});

app.get('/vehiculos',(req, res)=>{
    let vehiculos = []
    vehiculos.push({num_placa: "ARB456", id_linea: "3", modelo:"2010", fecha_ven_seguro:"2021-05-28", fecha_ven_tecnomecanica:"2021-02-19", fecha_ven_contratodo:"2021-07-12"})
    res.json(vehiculos)
});

//INITIALIZING THE SERVER IN PORT 5000
app.set('port', process.env.PORT || 5000)
app.listen(app.get('port'), ()=>{
    console.log(`Server running at port ${app.get('port')}!!`);
});

