//SETTING THE ROUTES FOR THE VEHICULOS TABLE

const {Router} = require('express');
const {cnn_mysql} = require('../config/database');
const router = Router();

router.get('/vehiculo',(req,res)=>{
    cnn_mysql.query(`SELECT * FROM vehiculos`, (error, resulset, fields)=>{
        if(error){
            return res.status(500).send('On no. Se presentó un error en la base de datos')
        }else{
            return res.json(resulset);
        }
    });    
});

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
            })
        }else{
            res.json({})
        }
    } catch(error){
        res.status(500).json({errorCode: error.errno, message: "Error en la conexión del servidor"})
    }
});

router.put('/vehiculo/:id',(req,res)=>{
    
});

router.patch('/vehiculo/:id',(req,res)=>{
    
});

router.delete('/vehiculo/:id',(req,res)=>{
    
});

module.exports = router;