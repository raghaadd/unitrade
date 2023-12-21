const connection = require('./database'); // Import your database connection
var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});


function handleaddreview(req, res) {
    console.log('********* Request body:', req.body);
    const {
        original_userID,
        review_userID,
        review,
        comment,
    } = req.body;
    const parsedoriginalUser= parseInt(original_userID, 10);
    const parsedreviewUser = parseInt(review_userID, 10);
    const parsedreview=parseInt(review,10);
    const insertUserQuery = 'INSERT INTO review (original_userID,review_userID,review,comment) VALUES (?, ?,?,?)';
    connection.query(
      insertUserQuery,
      [parsedoriginalUser, parsedreviewUser,parsedreview,comment],
      (err, result) => {
        if (err) {
          console.error(err);
          res.status(500).send('Error inserting data into the database: ' + err.message);
        } else {
          res.status(200).send('add review successful');
        }
      }
    );
  }
  
  module.exports = { handleaddreview };