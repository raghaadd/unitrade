const connection = require('./database'); // Import your database connection
var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});


function handledeleteofferDetails(req, res) {
    console.log('********* Request body:', req.body);
    const { idofferdetails, } = req.body;
    const parsedidofferdetails = parseInt(idofferdetails, 10);


    const deleteUserQuery = 'DELETE FROM offerdetails WHERE idofferdetails = ?';
    connection.query(
      deleteUserQuery,
      [parsedidofferdetails],
      (err, result) => {
        if (err) {
          console.error(err);
          res.status(500).send('Error deleting data from the database: ' + err.message);
        } else {
          res.status(200).send('Delete offer details successful');
        }
      }
    );
  }
  
  module.exports = { handledeleteofferDetails };