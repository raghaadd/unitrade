const connection = require('./database'); // Import your database connection
var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});

function handleaddSoft(req, res) {
    console.log('********* Request body:', req.body);
    const {
      registerID,
      idCategory,
      title,
      description,
      price,
      available,
      free,
      phoneNumber,
      faculty,
      major,
      image
    } = req.body;
    const parsedPrice = parseInt(price, 10);
    const parsedRegisterID = parseInt(registerID, 10);
    const parsedIdCategory = parseInt(idCategory, 10);
    const parsedAvailable = parseInt(available, 10);
    const parsedFree = parseInt(free, 10);
    const parsedFaculty = parseInt(faculty, 10);
    const parsedMajor = parseInt(major, 10);
    const insertUserQuery = 'INSERT INTO item (registerID, idCategory, title, description, price, available,free,phoneNumber,faculty,major,Date,image) VALUES (?, ?, ?, ?, ?, ?,?,?,?,?, NOW(),?)';
    connection.query(
      insertUserQuery,
      [parsedRegisterID, parsedIdCategory, title, description, parsedPrice, parsedAvailable, parsedFree, phoneNumber,parsedFaculty,parsedMajor,image],
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
  
  module.exports = { handleaddSoft };