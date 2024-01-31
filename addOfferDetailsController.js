const connection = require('./database'); // Import your database connection
var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});


function handleaddOfferDetails(req, res) {
    console.log('********* Request body:', req.body);
    const {
        idofferNames,
        offerdetailsName,
        price,
        image,
    } = req.body;
    const parsedidofferNames = parseInt(idofferNames, 10);
    const parsedprice=parseInt(price,10);
    const insertUserQuery = 'INSERT INTO offerdetails (idofferNames,offerdetailsName,price,image) VALUES (?, ?, ?, ?)';
    connection.query(
      insertUserQuery,
      [parsedidofferNames, offerdetailsName,parsedprice,image],
      (err, result) => {
        if (err) {
          console.error(err);
          res.status(500).send('Error inserting data into the database: ' + err.message);
        } else {
          res.status(200).send('offer details successful');
        }
      }
    );
  }
  
  module.exports = { handleaddOfferDetails };