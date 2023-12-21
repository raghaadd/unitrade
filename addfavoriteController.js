const connection = require('./database'); // Import your database connection
var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});


function handleaddfavorite(req, res) {
    console.log('********* Request body:', req.body);
    const {
      registerID,
      iditem,
      softCopy,
    } = req.body;
    const parsedRegisterID = parseInt(registerID, 10);
    const parsedIditem = parseInt(iditem, 10);
    const parsedsoftCopy=parseInt(softCopy,10);
    const insertUserQuery = 'INSERT INTO favorite (registerID,iditem,softCopy) VALUES (?, ?,?)';
    connection.query(
      insertUserQuery,
      [parsedRegisterID, parsedIditem,parsedsoftCopy],
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
  
  module.exports = { handleaddfavorite };