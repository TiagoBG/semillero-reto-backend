//SETTING THE ROUTES FOR THE TIPO_LINEA TABLE

const {Router} = require('express');
const {cnn_mysql} = require('../config/database');
const router = Router();

//CHECK THE LINE_TYPE QUANTITY RECORDS
const reqTotal = 20;
router.get('/tipo_linea',(req,res)=>{
    cnn_mysql.query(`SELECT * FROM tipo_linea`, (error, resulset, fields)=>{
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

//CHECK ONE LINE_TYPE
router.get('/tipo_linea/:id', async(req,res)=>{
    const id = req.params.id;
    console.log(id);
    const [rows] = await cnn_mysql.promise().query(`SELECT * FROM tipo_linea WHERE id_linea = ?`,[id]);
    if(rows[0]){
        res.json(rows[0]);
    }else{  
        res.json({});
    }
});

//INSERT A NEW LINE_TYPE
router.post('/tipo_linea', async(req,res)=>{
    try{
        const {
            desc_linea,
            id_marca,
            activo
        } = req.body;
        const [rows,fields] = await cnn_mysql.promise().execute(`INSERT INTO tipo_linea(desc_linea, id_marca, activo) VALUES (?,?,?)`, [desc_linea, id_marca, activo]);

        if(rows.affectedRows > 0){
            console.log(rows.insertId)
            res.json({
                id: rows.insertId,
                desc_linea: desc_linea,
                id_marca: id_marca,
                activo: activo
            });
        }else{
            res.json({})
        }

    }catch(error){
        res.status(500).json({errorCode: error.errno, message: "Error en la conexión del servidor"})
    }
});

//GET DESC_MARCA,DESC_LINEA AND QUANTITY
router.get('/linea_marca', async(req,res)=>{
    try{
        const [rows] = await cnn_mysql.promise().query(`SELECT tipo_linea.id_linea, tipo_linea.desc_linea, tipo_linea.id_marca tipo_linea, tipo_marca.id_marca, tipo_marca.desc_marca tipo_marca, COUNT(tipo_marca.id_marca) AS cantidad FROM tipo_marca INNER JOIN tipo_linea USING(id_marca) GROUP BY tipo_linea.id_marca`)
        console.log(rows)
        res.json(rows)
    }catch(e){
        console.log(e)
    }    
    });   

router.patch('/tipo_linea/:id',(req,res)=>{
    
});

router.delete('/tipo_linea/:id',(req,res)=>{
    
});

module.exports = router;