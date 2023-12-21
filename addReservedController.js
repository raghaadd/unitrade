const connection = require('./database'); // Import your database connection
var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});


function handleaddReserved(req, res) {
    console.log('********* Request body:', req.body);
    const {
    itemRequester,
    itemOwner,
    iditem,
    } = req.body;
    const parseditemRequster = parseInt(itemRequester, 10);
    const parseditemOwner=parseInt(itemOwner,10);
    const parsedIditem = parseInt(iditem, 10);
    const insertUserQuery = 'INSERT INTO reserved (itemRequester,itemOwner,iditem ) VALUES (?, ?, ?)';
    connection.query(
      insertUserQuery,
      [parseditemRequster, parseditemOwner,parsedIditem],
      (err, result) => {
        if (err) {
          console.error(err);
          res.status(500).send('Error inserting data into the database: ' + err.message);
        } else {
          res.status(200).send('Reserved successful');
        }
      }
    );
  }
  
  module.exports = { handleaddReserved };