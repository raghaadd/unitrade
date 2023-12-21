const connection = require('./database'); // Import your database connection
const bodyParser = require('body-parser');
const urlencoderParser = bodyParser.urlencoded({ extended: false });

function handleeditProfileInfo(req, res) {
    console.log('********* Request body:', req.body);
    const {  major, about, fname, lname, registerID } = req.body;
  
    // Assuming your tables have unique identifiers called `id`
    const updateProfileQuery = 'UPDATE profile SET major = ?, about = ? WHERE registerID = ?';
    const updateStudentsQuery = 'UPDATE students SET fname = ?, lname = ? WHERE registerID = ?';
  
    connection.beginTransaction(function (err) {
      if (err) { throw err; }
  
      connection.query(updateProfileQuery, [ major, about,registerID], function (error, results, fields) {
        if (error) {
          return connection.rollback(function () {
            throw error;
          });
        }
  
        connection.query(updateStudentsQuery, [fname, lname, registerID], function (error, results, fields) {
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
    });
  }
  

module.exports = { handleeditProfileInfo };
