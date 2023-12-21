const connection = require('./database'); // Import your database connection
const bodyParser = require('body-parser');
const urlencoderParser = bodyParser.urlencoded({ extended: false });

function handleeditItemInfo(req, res) {
    console.log('********* Request body:', req.body);
    const {  title, price, status, description,image, iditem } = req.body;
  
    // Assuming your tables have unique identifiers called `id`
    const updateItemQuery = 'UPDATE item SET title = ?, price = ?, status=?, description=?, image=? WHERE iditem = ?';
    
  
    connection.beginTransaction(function (err) {
      if (err) { throw err; }
  
      connection.query(updateItemQuery, [ title, price,status,description,image,iditem], function (error, results, fields) {
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
            res.status(200).send('Profile updated successfully');
          });
        });
      });
  }
  

module.exports = { handleeditItemInfo };
