const connection = require('./database');
const bodyParser = require('body-parser');
const urlencodedParser = bodyParser.urlencoded({ extended: false });

function handlegetStudentById(req, res) {

    const registerID = req.params.id;
    const selectStudentByIdQuery = 'SELECT registerID, fname, lname, phoneNO, password, email FROM students WHERE registerID = ?';

    connection.query(selectStudentByIdQuery, [registerID], (err, results) => {
      if (err) {
        console.error(err);
        res.status(500).send('Error fetching student');
      } else {
        if (results.length > 0) {
          const student = results[0];
          res.status(200).json(student);
        } else {
          res.status(404).send('Student not found');
        }
      }
    });
}

module.exports = { handlegetStudentById };

