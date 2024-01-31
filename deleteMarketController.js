const connection = require('./database'); // Import your database connection
var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});


function handledeleteMarket(req, res) {
    console.log('********* Request body:', req.body);
    const { idofferNames, } = req.body;
    const parsedidofferNames = parseInt(idofferNames, 10);


    const deleteUserQuery = 'DELETE FROM offernames WHERE idofferNames = ?';
    connection.query(
      deleteUserQuery,
      [parsedidofferNames],
      (err, result) => {
        if (err) {
          console.error(err);
          res.status(500).send('Error deleting data from the database: ' + err.message);
        } else {
          res.status(200).send('Delete market details successful');
        }
      }
    );
  }
  
  module.exports = { handledeleteMarket };