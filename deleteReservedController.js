const connection = require('./database'); // Import your database connection
var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});


function handledeleteRsvered(req, res) {
    console.log('********* Request body:', req.body);
    const { iditem,itemRequester } = req.body;
    const parsedIditem = parseInt(iditem, 10);
    const parseditemRequester = parseInt(itemRequester, 10);

    const deleteUserQuery = 'DELETE FROM reserved WHERE iditem = ? and itemRequester=?';
    connection.query(
      deleteUserQuery,
      [parsedIditem,parseditemRequester],
      (err, result) => {
        if (err) {
          console.error(err);
          res.status(500).send('Error deleting data from the database: ' + err.message);
        } else {
          res.status(200).send('Delete reserved successful');
        }
      }
    );
  }
  
  module.exports = { handledeleteRsvered };