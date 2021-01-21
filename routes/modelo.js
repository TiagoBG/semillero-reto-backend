//SETTING THE ROUTES FOR THE TIPO_LINEA TABLE

const {Router} = require('express');
const {cnn_mysql} = require('../config/database');
const router = Router();

//CHECK THE MAX AND MIN MODELS
router.get('/modelo',(req,res)=>{
    cnn_mysql.query(`SELECT * FROM modelo`, (error, resulset, fields)=>{
        if(error){
            return res.status(500).send('On no. Se presentó un error en la base de datos')
        }else{
            let yearMax = 0;
            let yearMin = resulset[0].year_modelo;
            let firstRecord;
            let lastRecord;
            
            for(let i = 0; i < resulset.length; i++){
                if(parseInt(resulset[i].year_modelo) > yearMax){
                    yearMax = parseInt(resulset[i].year_modelo);
                }else if(yearMin > parseInt(resulset[i].year_modelo)){
                    yearMin = parseInt(resulset[i].year_modelo);
                }           
            }
            
            if(resulset[0].desc_modelo !== null){
                firstRecord = `el ${resulset[0].desc_modelo} del ${resulset[0].year_modelo}`
            }else{
                firstRecord = `un vehículo de ${resulset[0].year_modelo}`
            }

            if(resulset[resulset.length-1].desc_modelo !== null){
                lastRecord = `el ${resulset[resulset.length-1].desc_modelo} del ${resulset[resulset.length-1].year_modelo}`
            }else{
                lastRecord = `un vehículo de ${resulset[resulset.length-1].year_modelo}`
            }
            console.log(yearMax)
            return res.json(`El modelo máximo registrado es del ${yearMax} y el mínimo registrado es del ${yearMin}. Además el primer modelo registrado es ${firstRecord} y el último es ${lastRecord}.`)            
        }
    });
});

//TOTALIZE THE MODELOS
router.get('/modelo_suma',(req,res)=>{
    cnn_mysql.query(`SELECT vehiculos.id_modelo, modelo.desc_modelo, COUNT(modelo.desc_modelo) AS cantidad_modelo FROM vehiculos INNER JOIN modelo USING(id_modelo) GROUP BY modelo.desc_modelo`, (error, resulset, fields)=>{
        if(error){
            console.log(error)
            return res.status(500).send('On no. Se presentó un error en la base de datos')
        }else{
            console.log(resulset.length);
            return res.json(resulset);              
        }
    });      
});


//AVERAGE THE MODELOS
router.get('/modelo_promedio',(req,res)=>{
    cnn_mysql.query(`SELECT AVG(modelo.year_modelo) 'promedio_modelo'FROM modelo`, (error, resulset, fields)=>{
        if(error){
            console.log(error)
            return res.status(500).send('On no. Se presentó un error en la base de datos')
        }else{
            console.log(resulset);
            return res.json(`Los vehiculos en promedio son del año: ${Math.floor(resulset[0].promedio_modelo)}`);              
        }
    });      
});

module.exports = router;