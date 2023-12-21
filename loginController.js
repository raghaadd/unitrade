const connection = require('./database'); // Import your database connection
var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});

function handleLogin(req, res) {
    console.log('********* Request body:', req.body);
    const { registerID, password } = req.body;
  
    const selectUserQuery = 'SELECT * FROM students WHERE registerID = ?';
  
    connection.query(selectUserQuery, [registerID], (err, results) => {
      if (err) {
        console.error(err);
        res.status(500).send('Error querying the database');
      } else {
        if (results.length > 0) {
          const user = results[0];
          if (password === user.password) {
            req.session.userId = user.registerID; // Example session management
            res.status(200).send('Login successful');
          } else {
            res.status(401).send('Incorrect password');
          }
        } else {
          res.status(404).send('User not found');
        }
      }
    });
  }
  
  module.exports = { handleLogin };