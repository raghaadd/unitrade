const connection = require('./database'); // Import your database connection
const bodyParser = require('body-parser');
const urlencoderParser = bodyParser.urlencoded({ extended: false });

function handleeditOfferDetailsInfo(req, res) {
    console.log('********* Request body:', req.body);
    const {  offerdetailsName, price,image, idofferdetails } = req.body;
  
    // Assuming your tables have unique identifiers called `id`
    const updateItemQuery = 'UPDATE offerdetails SET offerdetailsName = ?, price = ?,image=? WHERE idofferdetails = ?';
    
  
    connection.beginTransaction(function (err) {
      if (err) { throw err; }
  
      connection.query(updateItemQuery, [ offerdetailsName, price,image,idofferdetails], function (error, results, fields) {
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
            res.status(200).send('offerdetails updated successfully');
          });
        });
      });
  }
  

module.exports = { handleeditOfferDetailsInfo };
