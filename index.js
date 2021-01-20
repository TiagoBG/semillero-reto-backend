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
app.use(express.json());

//ROUTES
app.use('/api', vehiculos);
app.use('/api', tipo_marca);
app.use('/api', tipo_linea);
app.use('/api', modelo);

//PAGES AND RENDERING IN DOM
app.get('/',(req, res)=>{
    res.send('<h1>SEMILLERO S.A.S</h1>')
});

app.get('/vehiculos',(req, res)=>{
    let vehiculos = []
    vehiculos.push({num_placa: "ARB456", id_linea: "3", modelo:"2010", fecha_ven_seguro:"2021-05-28", fecha_ven_tecnomecanica:"2021-02-19", fecha_ven_contratodo:"2021-07-12"})
    res.json(vehiculos);
});

app.get('/tipo_marcas',(req, res)=>{
    let tipo_marca = []
    tipo_marca.push({id_marca: "6", desc_marca: "3", activo:"S"})
    res.json(tipo_marca);
});

app.get('/tipo_lineas',(req, res)=>{
    let tipo_lineas = []
    tipo_lineas.push({id_linea: "1", desc_linea: "DEPORTIVO", id_marca: "4", activo:"S"})
    res.json(tipo_lineas);
});

app.get('/modelos',(req, res)=>{
    let modelos = []
    modelos.push({id_modelo: "6", year_modelo: "2014", desc_modelo:"XL45"})
    res.json(modelos);
});

//INITIALIZING THE SERVER ON THE CLEVER CLOUD PORT 
app.set('port', process.env.DB_PORT || 8083)
app.listen(app.get('port'), ()=>{
    console.log(`Server running at port ${app.get('port')}!!`);
});

