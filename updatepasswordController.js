const connection = require('./database');
var bodyParser = require('body-parser');
var urlencoderParser = bodyParser.urlencoded({ extended: false });

function handleUpdatePassword(req, res) {
  console.log('********* Request body handleUpdadePassword:', req.body);
  const { registerID, password, newPassword } = req.body;
  const parsedregisterID = parseInt(registerID, 10);

  const checkPasswordQuery = 'SELECT * FROM gp_sw.students WHERE registerID = ? and password=?';

  connection.query(checkPasswordQuery, [parsedregisterID,password], (error, results) => {
    if (error) {
      res.status(500).json({ error: 'Internal Server Error' });
      throw error;
    }

    // If the password is correct, update the password
    console.log(results.length);
    if (results.length > 0) {
      const updatePasswordQuery = 'UPDATE gp_sw.students SET password = ? WHERE registerID = ?';
      connection.query(updatePasswordQuery, [newPassword, registerID], (updateError) => {
        if (updateError) {
          res.status(500).json({ error: 'Internal Server Error' });
          throw updateError;
        }
        res.status(200).json({ message: 'Password updated successfully' });
      });
    } else {
      // Incorrect current password
      res.status(401).json({ error: 'Incorrect current password' });
    }
  });
};

module.exports = { handleUpdatePassword };
