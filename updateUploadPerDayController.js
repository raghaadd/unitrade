const connection = require('./database');
var bodyParser = require('body-parser');
var urlencoderParser = bodyParser.urlencoded({ extended: false });

function handleUploadPerDay(req, res) {
  console.log('********* Request body handleUpdateSaleCounter:', req.body);
  const { registerID } = req.body;
  const parsedregisterID = parseInt(registerID, 10);

  // Fetch the current value of saleCounter
  const selectSaleCounterQuery = 'SELECT uploadperDay FROM students WHERE registerID = ?';

  connection.query(selectSaleCounterQuery, [parsedregisterID], function (error, results, fields) {
    if (error) {
      throw error;
    }

    if (results.length === 0) {
      // ItemRequester not found
      console.log('parsedregisterID not found.');
      res.status(404).send('parsedregisterID not found');
      return;
    }

    const currentuploadperDay = results[0].uploadperDay;

    // Increment the saleCounter by 1 or set it to 1 if NULL
    const updatedSaleCounter = currentuploadperDay !== null ? currentuploadperDay + 1 : 1;

    // Update the saleCounter in the students table
    const updateItemQuery = 'UPDATE students SET uploadperDay = ? WHERE registerID = ?';

    connection.beginTransaction(function (err) {
      if (err) {
        throw err;
      }

      connection.query(updateItemQuery, [updatedSaleCounter, parsedregisterID], function (error, results, fields) {
        if (error) {
          return connection.rollback(function () {
            throw error;
          });
        }

        // Commit the transaction
        connection.commit(function (err) {
          if (err) {
            return connection.rollback(function () {
              throw err;
            });
          }
          console.log('Transaction Complete.');
          res.status(200).send(`saleCounter updated successfully. Previous value: ${currentuploadperDay}`);
        });
      });
    });
  });
}

module.exports = { handleUploadPerDay };
