const connection = require('./database'); // Import your database connection
var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});


function handleaddPayment(req, res) {
    console.log('********* Request body:', req.body);
    const {
    sellerId,
    purchaserId,
    payDone,
    itemId,
    ismeal,
    } = req.body;
    const parsedsellerId = parseInt(sellerId, 10);
    const parsedpurchaserId=parseInt(purchaserId,10);
    const parseditemId=parseInt(itemId,10);
    const parsedpay=parseInt(payDone,10);
    const parsedismeal=parseInt(ismeal,10);
    const insertUserQuery = 'INSERT INTO payment (sellerId,purchaserId,payDone,itemId,ismeal) VALUES (?, ?, ?, ?,?)';
    connection.query(
      insertUserQuery,
      [parsedsellerId, parsedpurchaserId,parsedpay,parseditemId,parsedismeal],
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