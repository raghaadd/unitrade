const connection = require('./database'); // Import your database connection
var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});


function handleaddNewMarket(req, res) {
    console.log('********* Request body:', req.body);
    const {
        idoffers,
        offerDetails,
        discount,
        phoneNumber,
        location,
        details
    } = req.body;
    const parsedidoffers = parseInt(idoffers, 10);
    const parseddiscount=parseInt(discount,10);
    const parsedphoneNumber=parseInt(phoneNumber,10);
    const insertUserQuery = 'INSERT INTO offernames (idoffers,offerDetails,discount,phoneNumber,location,details) VALUES (?, ?, ?, ?,?,?)';
    connection.query(
      insertUserQuery,
      [parsedidoffers, offerDetails,parseddiscount,parsedphoneNumber,location,details],
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
  
  module.exports = { handleaddNewMarket };