const connection = require('./database');
const bodyParser = require('body-parser');
const urlencodedParser = bodyParser.urlencoded({ extended: false });

function handleUpdateStudent(req, res) {
  console.log('********* Request body:', req.body);
  const { newstudentID, fname, lname, phoneNO, password, email, registerID } = req.body;

  // Validate input data
  if (!lname || !fname || !registerID || !phoneNO || !email || !password) {
    res.status(400).send('Invalid or missing student data');
    return;
  }

  // Update the student in the database
  const updateStudentQuery =
  'UPDATE students SET registerID=?, fname=?, lname=?, phoneNO=?, password=?, email=? WHERE registerID=?';

  connection.query(
    updateStudentQuery,
    [newstudentID, fname, lname, phoneNO, password, email, registerID],
    (err, results) => {
      if (err) {
        console.error(err);
        res.status(500).send('Error updating student');
      } else {
        console.log('Updated student:', results.affectedRows);
        res.status(200).send('Student updated successfully');
      }
    }
  );
}

module.exports = { handleUpdateStudent };
