const connection = require('./database');
var bodyParser = require('body-parser');
var urlencoderParser = bodyParser.urlencoded({ extended: false });

function handleDeleteStudents(req, res) {
    const registerID = req.params.userID;

    if (!registerID || isNaN(registerID)) {
        res.status(400).send('Invalid student ID');
        return;
    }

    const deleteStudentsQuery = 'DELETE FROM students WHERE registerID = ? ';

    connection.query(deleteStudentsQuery, [registerID], (err, results) => {
        if (err) {
            console.error(err);
            res.status(500).send('Error deleting students');
        } else {
            console.log('Deleted students:', results.affectedRows);
            res.status(200).send('Students deleted successfully');
        }
    });
}


module.exports = { handleDeleteStudents };
