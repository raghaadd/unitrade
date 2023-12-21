const connection = require('./database'); // Import your database connection
var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});


function handledeletefavorite(req, res) {
    console.log('********* Request body:', req.body);
    const { iditem,registerID } = req.body;
    const parsedIditem = parseInt(iditem, 10);
    const parsedregisterID = parseInt(registerID, 10);

    const deleteUserQuery = 'DELETE FROM favorite WHERE iditem = ? and registerID=?';
    connection.query(
      deleteUserQuery,
      [parsedIditem,parsedregisterID],
      (err, result) => {
        if (err) {
          console.error(err);
          res.status(500).send('Error deleting data from the database: ' + err.message);
        } else {
          res.status(200).send('Delete item successful');
        }
      }
    );
  }
  
  module.exports = { handledeletefavorite };