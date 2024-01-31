const connection = require('./database'); // Import your database connection
var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});


function handleaddReport(req, res) {
    console.log('********* Request body:', req.body);
    const {
    itemId,
    reportcomment,
    } = req.body;
    const parseditemId = parseInt(itemId, 10);
    const insertUserQuery = 'INSERT INTO report (itemId,reportcomment ) VALUES (?, ?)';
    connection.query(
      insertUserQuery,
      [parseditemId, reportcomment],
      (err, result) => {
        if (err) {
          console.error(err);
          res.status(500).send('Error inserting data into the database: ' + err.message);
        } else {
          res.status(200).send('report successful');
        }
      }
    );
  }
  
  module.exports = { handleaddReport };