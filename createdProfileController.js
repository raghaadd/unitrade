const connection = require('./database'); // Import your database connection
var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});

function handleCraeteProfile(req, res) {
    console.log('********* Request body:', req.body);
    const {
      registerID,
    } = req.body;
    const insertUserQuery = 'INSERT INTO profile (registerID) VALUES (?)';
    connection.query(
      insertUserQuery,
      [registerID],
      (err, result) => {
        if (err) {
          console.error(err);
          res.status(500).send('Error inserting data into the database: ' + err.message);
        } else {
          res.status(200).send('Profile created successful');
        }
      }
    );
  }
  
  module.exports = {  handleCraeteProfile};