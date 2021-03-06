//SETTING THE ROUTES FOR THE VEHICULOS TABLE

const {Router} = require('express');
const {cnn_mysql} = require('../config/database');
const router = Router();

//CHECK THE VEHICLES QUANTITY RECORDS
const reqTotal = 30;
router.get('/vehiculo',(req,res)=>{
    cnn_mysql.query(`SELECT * FROM vehiculos`, (error, resulset, fields)=>{
        if(error){
            return res.status(500).send('On no. Se presentó un error en la base de datos')
        }else{
            console.log(resulset.length);
            if(resulset.length < reqTotal){
                return res.json(`Se encontraron ${resulset.length} de los ${reqTotal} registros pactados. Favor ingresar los registros faltantes`);
            }else if(resulset.length > reqTotal){
                return res.json(`Se encontraron ${resulset.length} de los ${reqTotal} registros pactados. Favor eliminar los registros sobrantes`);
            }else{
                return res.json(resulset);
            }                
        }
    });      
});

//CHECK THE FECHA_VEN_SEGURO RANGE
router.get('/fecha',(req,res)=>{
    cnn_mysql.query(`SELECT * FROM vehiculos WHERE fecha_ven_seguro BETWEEN '2021-03-01 00:00:00' AND '2021-06-31 23:59:59'`, (error, resulset, fields)=>{
        if(error){
            console.log(error)
            return res.status(500).send('On no. Se presentó un error en la base de datos')
        }else{
            console.log(resulset.length);
            return res.json(resulset);              
        }
    });      
});

//CHECK ONE VEHICLE
router.get('/vehiculo/:id', async(req,res)=>{
    const id = req.params.id;
    console.log(id)
    const [rows] = await cnn_mysql.promise().query(`SELECT * FROM vehiculos WHERE id_vehiculo = ?`,[id]);
    if(rows[0]){
        res.json(rows[0]);
    }else{
        res.json({});
    }
});

//INSERT A NEW VEHICLE
router.post('/vehiculo', async(req,res)=>{
    try{
        const {
            nro_placa,
            id_linea,
            id_modelo,
            fecha_ven_seguro,
            fecha_ven_tecnomecanica,
            fecha_ven_contratodo
        } = req.body;
        const [rows, fields] = await cnn_mysql.promise().execute(`INSERT INTO vehiculos(nro_placa, id_linea, id_modelo, fecha_ven_seguro, fecha_ven_tecnomecanica, fecha_ven_contratodo) VALUES (?, ?, ?, ?, ?, ?)`, [nro_placa,
                id_linea, id_modelo, fecha_ven_seguro, fecha_ven_tecnomecanica, fecha_ven_contratodo]);

        if(rows.affectedRows > 0){
            console.log(rows.insertId)
            res.json({
                id: rows.insertId,
                nro_placa: nro_placa,
                id_linea: id_linea,
                id_modelo: id_modelo,
                fecha_ven_seguro: fecha_ven_seguro,
                fecha_ven_tecnomecanica: fecha_ven_tecnomecanica,
                fecha_ven_contratodo: fecha_ven_contratodo
            });
        }else{
            res.json({})
        }
    } catch(error){
        res.status(500).json({errorCode: error.errno, message: "Error en la conexión del servidor"})
    }
});

//CHECK THE MODELO RANGE
router.get('/range_modelo',(req,res)=>{
    cnn_mysql.query(`SELECT vehiculos.id_vehiculo, vehiculos.nro_placa AS placa, vehiculos.id_modelo, vehiculos.id_linea FROM vehiculos INNER JOIN modelo ON vehiculos.id_modelo = modelo.id_modelo WHERE modelo.year_modelo BETWEEN '2012' AND '2016'`, (error, resulset, fields)=>{
        if(error){
            console.log(error)
            return res.status(500).send('On no. Se presentó un error en la base de datos')
        }else{
            console.log(resulset.length);
            return res.json(resulset);              
        }
    });      
});

//CHECK THE VEHICLE FULL INFO
router.get('/vehiculo_info',(req,res)=>{
    cnn_mysql.query(`SELECT modelo.id_modelo, modelo.year_modelo, modelo.desc_modelo, vehiculos.id_modelo, vehiculos.nro_placa, vehiculos.id_linea, vehiculos.id_vehiculo, tipo_linea.id_marca, tipo_linea.desc_linea, tipo_marca.id_marca, tipo_marca.desc_marca FROM modelo, vehiculos, tipo_linea, tipo_marca GROUP BY vehiculos.id_modelo`, (error, resulset, fields)=>{
        if(error){
            console.log(error)
            return res.status(500).send('On no. Se presentó un error en la base de datos')
        }else{
            console.log(resulset.length);
            return res.json(resulset);              
        }
    });      
});

//CHECK THE VEHICLE FULL INFO JUST ACTIVES
router.get('/vehiculo_activo',(req,res)=>{
    cnn_mysql.query(`SELECT modelo.id_modelo, modelo.year_modelo, modelo.desc_modelo, vehiculos.id_modelo, vehiculos.nro_placa, vehiculos.id_linea, vehiculos.id_vehiculo, tipo_linea.id_marca, tipo_linea.desc_linea, tipo_linea.activo, tipo_marca.id_marca, tipo_marca.desc_marca FROM modelo, vehiculos, tipo_linea, tipo_marca WHERE tipo_linea.activo = 'S' GROUP BY vehiculos.id_modelo`, (error, resulset, fields)=>{
        if(error){
            console.log(error)
            return res.status(500).send('On no. Se presentó un error en la base de datos')
        }else{
            console.log(resulset.length);
            return res.json(resulset);              
        }
    });      
});

router.get('/vehiculo_actualizar',(req,res)=>{
    cnn_mysql.query(`UPDATE vehiculos SET nro_placa = 'ZDX741', fecha_ven_seguro = '2022-03-27 10:00:00', fecha_ven_tecnomecanica = '2022-05-27 15:00:00', fecha_ven_contratodo = '2022-07-27 17:00:00' WHERE id_vehiculo = 15`, (error, resulset, fields)=>{
        if(error){
            console.log(error)
            return res.status(500).send('On no. Se presentó un error en la base de datos')
        }else{
            console.log(resulset);
            return res.json(`Se ha actualizado el vehículo del registro 17`);              
        }
    });      
});

router.patch('/vehiculo/:id',(req,res)=>{
    
});

router.delete('/vehiculo/:id',(req,res)=>{
    
});

module.exports = router;