const connection = require('./database'); // Import your database connection
var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});


function handleaddfavoriteMeals(req, res) {
    console.log('********* Request body:', req.body);
    const {
      registerID,
      idmeals,
    } = req.body;
    const parsedRegisterID = parseInt(registerID, 10);
    const parsedidmeals = parseInt(idmeals, 10);
    const insertUserQuery = 'INSERT INTO favoritemeals (registerID,idmeals) VALUES (?, ?)';
    connection.query(
      insertUserQuery,
      [parsedRegisterID, parsedidmeals],
      (err, result) => {
        if (err) {
          console.error(err);
          res.status(500).send('Error inserting data into the database: ' + err.message);
        } else {
          res.status(200).send('add item successful');
        }
      }
    );
  }
  
  module.exports = { handleaddfavoriteMeals };