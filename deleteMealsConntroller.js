const connection = require('./database'); // Import your database connection
var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});


function handledeleteMarket(req, res) {
    console.log('********* Request body:', req.body);
    const { idmeals, } = req.body;
    const parsedidmeals = parseInt(idmeals, 10);


    const deleteUserQuery = 'DELETE FROM meals WHERE idmeals = ?';
    connection.query(
      deleteUserQuery,
      [parsedidmeals],
      (err, result) => {
        if (err) {
          console.error(err);
          res.status(500).send('Error deleting data from the database: ' + err.message);
        } else {
          res.status(200).send('Delete meals details successful');
        }
      }
    );
  }
  
  module.exports = { handledeleteMarket };