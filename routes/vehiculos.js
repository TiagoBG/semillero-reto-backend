//SETTING THE ROUTES FOR THE VEHICULOS TABLE

const {Router} = require('express');
const {cnn_mysql} = require('../config/database');
const router = Router();

router.get('/vehiculo',(req,res)=>{
    cnn_mysql.query(`SELECT * FROM vehiculos`, (error, resulset, fields)=>{
        console.log(error);
        console.log(resulset);
        console.log(fields);
    })
    res.json([{placa: "QWE783"}])
});

router.get('/vehiculo/:id',(req,res)=>{
    
});

router.post('/vehiculo',(req,res)=>{
    
});

router.put('/vehiculo/:id',(req,res)=>{
    
});

router.patch('/vehiculo/:id',(req,res)=>{
    
});

router.delete('/vehiculo/:id',(req,res)=>{
    
});

module.exports = router;