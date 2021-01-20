//SETTING THE ROUTES FOR THE TIPO_MARCA TABLE

const {Router} = require('express');
const {cnn_mysql} = require('../config/database');
const router = Router();


//CHECK THE BRAND_TYPE QUANTITY RECORDS
const reqTotal = 5;
router.get('/tipo_marca',(req,res)=>{
    cnn_mysql.query(`SELECT * FROM tipo_marca`, (error, resulset, fields)=>{
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

//CHECK ONE BRAND_TYPE
router.get('/tipo_marca/:id', async(req,res)=>{
    const id = req.params.id;
    console.log(id);
    const [rows] = await cnn_mysql.promise().query(`SELECT * FROM tipo_marca WHERE id_marca = ?`,[id]);
    if(rows[0]){
        res.json(rows[0]);
    }else{
        res.json({});
    }
});

//INSERT A NEW BRAND_TYPE
router.post('/tipo_marca', async(req,res)=>{
    try{
        const {
            desc_marca,
            activo
        } = req.body;
        const [rows,fields] = await cnn_mysql.promise().execute(`INSERT INTO tipo_marca(desc_marca, activo) VALUES (?,?)`, [desc_marca, activo]);

        if(rows.affectedRows > 0){
            console.log(rows.insertId)
            res.json({
                id: rows.insertId,
                desc_marca: desc_marca,
                activo: activo
            });
        }else{
            res.json({})
        }

    }catch(error){
        res.status(500).json({errorCode: error.errno, message: "Error en la conexión del servidor"})
    }
});

router.put('/tipo_marca/:id',(req,res)=>{
    
});

router.patch('/tipo_marca/:id',(req,res)=>{
    
});

//DELETE THE BRAND_TYPE RECORD
router.delete('/tipo_marca/:id', async(req,res)=>{
    const id = req.params.id;
    console.log(id);
    const [rows] = await cnn_mysql.promise().query(`DELETE FROM tipo_marca WHERE id_marca = ?`,[id]);
    if(rows[0]){
        res.json(rows[0]);
    }else{
        res.json({});
    }
});

module.exports = router;