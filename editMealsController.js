const connection = require('./database'); // Import your database connection
const bodyParser = require('body-parser');
const urlencoderParser = bodyParser.urlencoded({ extended: false });

function handleeditMeals(req, res) {
    console.log('********* Request body:', req.body);
    const {  idmeals, mealtitle,count,details,price,image } = req.body;
  
    // Assuming your tables have unique identifiers called `id`
    const updateItemQuery = 'UPDATE meals SET mealtitle = ?, count = ?,details=?, price=?,image=? WHERE idmeals = ?';
    
  
    connection.beginTransaction(function (err) {
      if (err) { throw err; }
  
      connection.query(updateItemQuery, [ mealtitle, count,details,price,image,idmeals], function (error, results, fields) {
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
            res.status(200).send('meals updated successfully');
          });
        });
      });
  }
  

module.exports = { handleeditMeals };
