const connection = require('./database');
const bodyParser = require('body-parser');
const urlencoderParser = bodyParser.urlencoded({ extended: false });

function handleAddStudent(req, res) {
    console.log('********* Request body:', req.body);
    const { registerID, fname, lname, phoneNO, password, email } = req.body;

  //Validate input data
  if (!lname || !fname || !registerID || !phoneNO || !email || !password) {
    res.status(400).send('Invalid or missing student data');
    return;
  }

  // Insert the new student into the database
  const addStudentQuery =
    'INSERT INTO students (registerID, fname, lname, phoneNO, password, email ) VALUES (?, ?, ?, ?, ?, ?)';

  connection.query(
    addStudentQuery,
    [registerID, fname, lname, phoneNO, password, email],
    (err, results) => {
      if (err) {
        console.error(err);
        res.status(500).send('Error adding student');
      } else {
        console.log('Added new student:', results.insertId);
        res.status(200).send('Student added successfully');
      }
    }
  );
}

module.exports = { handleAddStudent };
