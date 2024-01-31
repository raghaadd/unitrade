const connection = require('./database'); // Import your database connection
const bodyParser = require('body-parser');
const urlencoderParser = bodyParser.urlencoded({ extended: false });

function handlemealpayment(req, res) {
  console.log('********* Request body:', req.body);
  const {
    idmeals,
    price,
    mealscount,
    deliveryTime,
    deliveryAddress,
    phoneNumber,
    notes
  } = req.body;

  const insertUserQuery = 'INSERT INTO mealpayment (idmeals, price, mealscount, deliveryTime, deliveryAddress, phoneNumber, notes) VALUES (?, ?, ?, ?, ?, ?, ?)';

  connection.query(
    insertUserQuery,
    [idmeals, price, mealscount, deliveryTime, deliveryAddress, phoneNumber, notes],
    (err, result) => {
      if (err) {
        console.error(err);
        res.status(500).send('Error inserting data into the database: ' + err.message);
      } else {
        // Update the count and countseller in the meals table
        const updateMealsQuery = 'UPDATE meals SET countseller = COALESCE(countseller, 0) + ? WHERE idmeals = ?';

        connection.query(
          updateMealsQuery,
          [mealscount, idmeals],
          (updateErr, updateResult) => {
            if (updateErr) {
              console.error(updateErr);
              res.status(500).send('Error updating data in the meals table: ' + updateErr.message);
            } else {
              res.status(200).send('mealpayment successful');
            }
          }
        );
      }
    }
  );
}

module.exports = { handlemealpayment };
