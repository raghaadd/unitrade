const connection = require('./database');
var bodyParser = require('body-parser');
var urlencoderParser = bodyParser.urlencoded({ extended: false });

function handleUpdatePaymentReview(req, res) {
  console.log('********* Request body handleUpdatePaymentReview:', req.body);
  const { sellerId, purchaserId, itemId, reviewDone } = req.body;
  const parsedsellerId = parseInt(sellerId, 10);
  const parsedpurchaserId = parseInt(purchaserId, 10);
  const parseditemId = parseInt(itemId, 10);
  const parsedreviewDone = parseInt(reviewDone, 10);

  const updatereviewDone = 'UPDATE payment SET reviewDone = ? WHERE sellerId = ? AND purchaserId = ? AND itemId = ?';

  connection.beginTransaction(function (err) {
    if (err) {
      throw err;
    }

    connection.query(updatereviewDone, [parsedreviewDone, parsedsellerId, parsedpurchaserId, parseditemId], function (error, results, fields) {
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
        res.status(200).send(`reviewDone updated successfully. Previous value: ${parsedreviewDone}`);
      });
    });
  });
}

module.exports = { handleUpdatePaymentReview };
