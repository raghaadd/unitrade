const connection = require('./database'); // Import your database connection
const bodyParser = require('body-parser');
const urlencoderParser = bodyParser.urlencoded({ extended: false });

function handleeditMarket(req, res) {
    console.log('********* Request body:', req.body);
    const {  idofferNames, offerDetails,discount, phoneNumber,location,details } = req.body;
  
    // Assuming your tables have unique identifiers called `id`
    const updateItemQuery = 'UPDATE offernames SET offerDetails = ?, discount = ?,phoneNumber=?, location=?,details=? WHERE idofferNames = ?';
    
  
    connection.beginTransaction(function (err) {
      if (err) { throw err; }
  
      connection.query(updateItemQuery, [ offerDetails, discount,phoneNumber,location,details,idofferNames], function (error, results, fields) {
        if (error) {
          return connection.rollback(function () {
            throw error;
          });
        }
  
          connection.commit(function (err) {
            if (err) {
              return connection.rollback(function () {
                throw err;
              });
            }
            console.log('Transaction Complete.');
            res.status(200).send('offernames updated successfully');
          });
        });
      });
  }
  

module.exports = { handleeditMarket };
