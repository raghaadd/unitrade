const connection = require('./database'); // Import your database connection
var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});


function handleaddNewMeals(req, res) {
    console.log('********* Request body:', req.body);
    const {
        mealtitle,
        price,
        count,
        details,
        image,
    } = req.body;
    const parsedprice = parseInt(price, 10);
    const parsedcount=parseInt(count,10);
    const insertUserQuery = 'INSERT INTO meals (mealtitle,price,count,details,image) VALUES (?, ?, ?, ?,?)';
    connection.query(
      insertUserQuery,
      [mealtitle, parsedprice,parsedcount,details,image],
      (err, result) => {
        if (err) {
          console.error(err);
          res.status(500).send('Error inserting data into the database: ' + err.message);
        } else {
          res.status(200).send('inserted into meals successfully');
        }
      }
    );
  }
  
  module.exports = { handleaddNewMeals };