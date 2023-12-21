const connection = require('./database');
var bodyParser = require('body-parser');
var urlencoderParser = bodyParser.urlencoded({ extended: false });

function handleaddSeeNotif(req, res) {
  console.log('********* Request body:', req.body);
  const { iditem, seeNotification, itemRequester } = req.body;
  const parsedIditem = parseInt(iditem, 10);
  const parseditemReqester = parseInt(itemRequester, 10);

  // If seeNotification is not equal to 1 for all records, update the reserved table
  const updateItemQuery = 'UPDATE reserved SET seeNotification = ? WHERE iditem = ? and itemRequester=?';
  connection.query(updateItemQuery, [seeNotification, parsedIditem, parseditemReqester], function (error, results, fields) {
    if (error) {
      throw error;
    }

    res.status(200).send('Reserved updated successfully');
    let checkDecisionQuery;
    checkDecisionQuery = 'SELECT decision FROM reserved WHERE iditem = ? AND decision = 1';

    connection.query(checkDecisionQuery, [parsedIditem], function (error, results, fields) {
      if (error) {
        throw error;
      }
      if (results.length > 0) {

        
    // Retrieve all records for the specified iditem from the reserved table
    const selectReservedQuery = 'SELECT * FROM reserved WHERE iditem = ?';
    connection.query(selectReservedQuery, [parsedIditem], function (error, results, fields) {
      if (error) {
        throw error;
      }

      // Check if all records have seeNotification = 1
      const allSeeNotificationOne = results.every(record => record.seeNotification === 1);

      // Start a transaction
      connection.beginTransaction(function (err) {
        if (err) {
          throw err;
        }

        if (allSeeNotificationOne) {
          // Delete all records for the specified iditem in the reserved table
          const deleteReservedQuery = 'DELETE FROM reserved WHERE iditem = ?';
          connection.query(deleteReservedQuery, [parsedIditem], function (error, results, fields) {
            if (error) {
              return connection.rollback(function () {
                throw error;
              });
            }

            // Delete the record from the item table
            const deleteItemQuery = 'DELETE FROM item WHERE iditem = ?';
            connection.query(deleteItemQuery, [parsedIditem], function (error, results, fields) {
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
                // Check if the response has been sent before sending it again
                if (!res.headersSent) {
                  res.status(200).send('Records deleted successfully');
                }
              });
            });
          });
        }
      });
    });

      }

    });

  });
}

module.exports = { handleaddSeeNotif };
