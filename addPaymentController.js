const connection = require('./database'); // Import your database connection
var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});


function handleaddPayment(req, res) {
    console.log('********* Request body:', req.body);
    const {
    sellerId,
    purchaserId,
    payDone
    } = req.body;
    const parsedsellerId = parseInt(sellerId, 10);
    const parsedpurchaserId=parseInt(purchaserId,10);
    const parsedpay=parseInt(payDone,10);
    const insertUserQuery = 'INSERT INTO payment (sellerId,purchaserId,payDone) VALUES (?, ?, ?)';
    connection.query(
      insertUserQuery,
      [parsedsellerId, parsedpurchaserId,parsedpay],
      (err, result) => {
        if (err) {
          console.error(err);
          res.status(500).send('Error inserting data into the database: ' + err.message);
        } else {
          res.status(200).send('payment successful');
        }
      }
    );
  }
  
  module.exports = { handleaddPayment };