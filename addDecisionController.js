const connection = require('./database');
var bodyParser = require('body-parser');
var urlencoderParser = bodyParser.urlencoded({ extended: false });

function handleaddDecision(req, res) {
  console.log('********* Request body:', req.body);
  const { iditem, decision, itemRequester } = req.body;
  const parsedIditem = parseInt(iditem, 10);
  const parsedItemRequester = parseInt(itemRequester, 10);

  // Check if any row contains decision=1
  let checkDecisionQuery;

  if (decision == 1) {
    checkDecisionQuery = 'SELECT decision FROM reserved WHERE iditem = ? AND decision = 1';

    connection.query(checkDecisionQuery, [parsedIditem], function (error, results, fields) {
      if (error) {
        throw error;
      }

      // If any row contains decision=1, do not update the table
      if (results.length > 0) {
        res.status(400).send('Cannot update. Decision is already 1 for this item.');
      } else {
        // Update the decision in the reserved table
        const updateItemQuery = 'UPDATE reserved SET decision = ? WHERE iditem = ? and itemRequester=?';

        connection.beginTransaction(function (err) {
          if (err) {
            throw err;
          }

          connection.query(updateItemQuery, [decision, parsedIditem, parsedItemRequester], function (error, results, fields) {
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
              res.status(200).send('Reserved updated successfully');
            });
          });
        });
      }
    });
  } else {
    // Update the decision in the reserved table without checking for existing decisions
    const updateItemQuery = 'UPDATE reserved SET decision = ? WHERE iditem = ? and itemRequester=?';

    connection.beginTransaction(function (err) {
      if (err) {
        throw err;
      }

      connection.query(updateItemQuery, [decision, parsedIditem, parsedItemRequester], function (error, results, fields) {
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
          res.status(200).send('Reserved updated successfully');
        });
      });
    });
  }
}

module.exports = { handleaddDecision };
