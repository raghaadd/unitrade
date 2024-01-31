const connection = require('./database'); // Import your database connection
var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});


function handledeletefavoriteMeals(req, res) {
    console.log('********* Request body:', req.body);
    const { idmeals,registerID } = req.body;
    const parsedidmeals = parseInt(idmeals, 10);
    const parsedregisterID = parseInt(registerID, 10);

    const deleteUserQuery = 'DELETE FROM favoritemeals WHERE idmeals = ? and registerID=?';
    connection.query(
      deleteUserQuery,
      [parsedidmeals,parsedregisterID],
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
  
  module.exports = { handledeletefavoriteMeals };