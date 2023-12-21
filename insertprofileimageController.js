const connection = require('./database'); // Import your database connection
const bodyParser = require('body-parser');
const urlencoderParser = bodyParser.urlencoded({ extended: false });

function handleInsertProfileImage(req, res) {
  console.log('********* Request body:', req.body);
  const { profileimage, registerID } = req.body;

  // Assuming your table has a unique identifier called `id`
  const updateProfileQuery = 'UPDATE profile SET profileimage = ? WHERE registerID = ?';

  connection.query(updateProfileQuery, [profileimage, registerID], (err, result) => {
    if (err) {
      console.error(err);
      res.status(500).send('Error updating image in the database: ' + err.message);
    } else {
      res.status(200).send('Image updated successfully');
    }
  });
}

module.exports = { handleInsertProfileImage };
