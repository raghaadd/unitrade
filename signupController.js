const connection = require('./database'); // Import your database connection
var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});

function handleSignup(req, res) {
    console.log('********* Request body:', req.body);
    const {
      registerID,
      fname,
      lname,
      phoneNO,
      email,
      password,
    } = req.body;
    const insertUserQuery = 'INSERT INTO STUDENTS (registerID, fname, lname, phoneNO, email, password) VALUES (?, ?, ?, ?, ?, ?)';
    connection.query(
      insertUserQuery,
      [registerID, fname, lname, phoneNO, email, password],
      (err, result) => {
        if (err) {
          console.error(err);
          res.status(500).send('Error inserting data into the database: ' + err.message);
        } else {
          res.status(200).send('Signup successful');
        }
      }
    );
  }
  
  module.exports = { handleSignup };