//SETTING THE ROUTES FOR THE TIPO_MARCA TABLE

const e = require('express');
const {Router} = require('express');
const {cnn_mysql} = require('../config/database');
const router = Router();

router.get('/tipo_marca',(req,res)=>{
    cnn_mysql.query(`SELECT * FROM tipo_marca`, (error, resulset, fields)=>{
        if(error){
            console.log(error)
            return res.status(500).send('On no. Se presentó un error en la base de datos')
        }else{
            return res.json(resulset);
        }
    });
    res.json([{placa: "CHEVROLET"}])
});

router.get('/tipo_marca/:id',(req,res)=>{
    
});

router.post('/tipo_marca',(req,res)=>{
    
});

router.put('/tipo_marca/:id',(req,res)=>{
    
});

router.patch('/tipo_marca/:id',(req,res)=>{
    
});

router.delete('/tipo_marca/:id',(req,res)=>{
    
});

module.exports = router;