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

module.exports = router;