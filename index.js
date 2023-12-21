var express=require("express");
var app=express();
var connection=require('./database');
var bodyParser=require('body-parser');
const session = require('express-session');
var urlencoderParser=bodyParser.urlencoded({extended:false});
const signupController = require('./signupController');
const loginController = require('./loginController'); 
const addItemController = require('./addItemController'); 
const addSoftController = require('./addSoftController'); 
const addfavController = require('./addfavoriteController'); 
const deletefavController = require('./deletefavoriteController'); 
const createProfileController = require('./createdProfileController');
const updateprofileImageController = require('./insertprofileimageController');
const updateprofileInfoController = require('./editprofileinfoController');
const deleteitemController = require('./deleteitemController'); 
const edititemController = require('./editItemInfoController'); 
const addResvController = require('./addReservedController'); 
const deleteResvController = require('./deleteReservedController'); 
const addDecisionController = require('./addDecisionController'); 
const addReviewController = require('./addReviewController'); 
const addSeeNotificationController = require('./addSeeNotificationController'); 
const updateSaleCounterController = require('./updateSaleCounterController'); 
const addPaymentController = require('./addPaymentController'); 


require('dotenv').config(); // Load the .env file
const sessionSecret = process.env.SESSION_SECRET;

app.set('view engine','ejs');
//app.use('assets',express.static('stuff'));
app.use(
  session({
    secret: sessionSecret,
    resave: false,
    saveUninitialized: true,
  })
);


app.get('/students',function(req,res){
    let sql="SELECT * FROM STUDENTS";
    connection.query(sql,function(err, results){
        if(err) throw err;
        res.send(results);
    })
});
 
app.get('/category',function(req,res){
  let sql="SELECT CategoryName,Icon FROM category";
  connection.query(sql,function(err, results){
      if(err) throw err;
      res.send(results);
  })
});
app.get('/furniturepage/:registerID', function(req, res) {
  const registerID = req.params.registerID;
  let sql = "SELECT iditem, title, image, CategoryName, registerID FROM item i, category c WHERE c.idCategory = i.idCategory AND i.idCategory = 4 AND i.registerID != ?";
  
  connection.query(sql,[registerID], function(err, results) {
    if (err) throw err;
    res.send(results);
  });
});

app.get('/electricalspage/:registerID',function(req,res){
  const registerID = req.params.registerID;
  let sql="SELECT iditem,title,image,CategoryName,registerID FROM item i,category c where c.idCategory=i.idCategory and i.idCategory=3 AND i.registerID != ?";
  connection.query(sql,[registerID], function(err, results){
      if(err) throw err;
      res.send(results);
  })
});
app.get('/electronicpage/:registerID',function(req,res){
  const registerID = req.params.registerID;
  let sql="SELECT iditem,title,image,CategoryName,registerID FROM item i,category c where c.idCategory=i.idCategory and i.idCategory=2 AND i.registerID != ?";
  connection.query(sql,[registerID], function(err, results){
      if(err) throw err;
      res.send(results);
  })
});

app.get('/slidespage/:registerID/:faculty/:major',function(req,res){
  const registerID = req.params.registerID;
  const faculty=req.params.faculty;
  const major=req.params.major;
  let sql="SELECT iditem,title,image,CategoryName,registerID FROM item i,category c where c.idCategory=i.idCategory and i.idCategory=1 AND i.registerID != ? and i.faculty=? and i.major=? and (i.free IS NULL);";
  connection.query(sql,[registerID,faculty,major],function(err, results){
      if(err) throw err;
      res.send(results);
  })
});

app.get('/softslidespage/:registerID/:faculty/:major', function(req, res) {
  const registerID = req.params.registerID;
  const faculty = req.params.faculty;
  const major = req.params.major;

  let sql = "SELECT i.iditem, i.title, i.image, c.CategoryName, i.registerID, s.Fname, s.Lname " +
            "FROM item i " +
            "JOIN category c ON c.idCategory = i.idCategory " +
            "JOIN students s ON s.registerID = i.registerID " +
            "WHERE i.idCategory = 1 AND i.registerID != ? AND i.faculty = ? AND i.major = ? AND (i.free = 0);";

  connection.query(sql, [registerID, faculty, major], function(err, results) {
      if (err) throw err;
      res.send(results);
  });
});


app.get('/paidsoftslidespage/:registerID/:faculty/:major',function(req,res){
  const registerID = req.params.registerID;
  const faculty=req.params.faculty;
  const major=req.params.major;
  let sql = "SELECT i.iditem, i.title, i.image, c.CategoryName, i.registerID,i.price, s.Fname, s.Lname " +
  "FROM item i " +
  "JOIN category c ON c.idCategory = i.idCategory " +
  "JOIN students s ON s.registerID = i.registerID " +
  "WHERE i.idCategory = 1 AND i.registerID != ? AND i.faculty = ? AND i.major = ? AND (i.free = 1);";
  connection.query(sql,[registerID,faculty,major],function(err, results){
      if(err) throw err;
      res.send(results);
  })
});



//***get user items ***//
app.get('/userItems/:registerID',function(req,res){
  const registerID = req.params.registerID;
  let sql="SELECT i.iditem,i.title,i.image, i.price,c.CategoryName,i.date, i.phoneNumber,i.status, i.description, s.Fname, s.Lname FROM item i, category c,students s where c.idCategory = i.idCategory and i.registerID = s.registerID and i.registerID = ? and (i.free IS NULL);";
  connection.query(sql,[registerID], function(err, results){
      if(err) throw err;
     
      results.forEach(item => {
        item.price = item.price.toString();
        
        // Convert the date to a string with the year, month, and day
        item.date = new Date(item.date).toLocaleDateString('en-US', {
          year: 'numeric',
          month: '2-digit',
          day: '2-digit'
        });
      });
      res.send(results);
  })
});

app.get('/userSlides/:registerID',function(req,res){
  const registerID = req.params.registerID;
  let sql="SELECT i.iditem,i.title,i.image, i.price,c.CategoryName,i.date, i.phoneNumber,i.status, i.description, s.Fname, s.Lname FROM item i, category c,students s where c.idCategory = i.idCategory and i.registerID = s.registerID and i.registerID = ? and (i.free IS not NULL);";
  connection.query(sql,[registerID], function(err, results){
      if(err) throw err;
     
      results.forEach(item => {
        item.price = item.price.toString();
        
        // Convert the date to a string with the year, month, and day
        item.date = new Date(item.date).toLocaleDateString('en-US', {
          year: 'numeric',
          month: '2-digit',
          day: '2-digit'
        });
      });
      res.send(results);
  })
});

app.get('/searchItems',function(req,res){
  let sql="SELECT i.iditem, i.title, i.price, i.image, c.CategoryName, i.date, i.phoneNumber,i.status,i.description,s.Fname,s.Lname  FROM item i JOIN category c ON i.idCategory = c.idCategory JOIN students s ON i.registerID = s.registerID and i.free is null";

  connection.query(sql,function(err, results){
      if(err) throw err;
      results.forEach(item => {
        item.price = item.price.toString();
        
        // Convert the date to a string with the year, month, and day
        item.date = new Date(item.date).toLocaleDateString('en-US', {
          year: 'numeric',
          month: '2-digit',
          day: '2-digit'
        });
      });
      res.send(results);
  })
});

app.get('/furniturdetails', function (req, res) {
  let sql = "SELECT i.iditem, i.image, i.title, c.CategoryName, i.date, i.phoneNumber,i.status, i.price, i.description, s.Fname, s.Lname, i.registerID FROM gp_sw.item i, gp_sw.category c, gp_sw.students s where c.idCategory = i.idCategory and s.registerID = i.registerID;";
  connection.query(sql, function (err, results) {
    if (err) throw err;

    // Convert the price to a string
    results.forEach(item => {
      item.price = item.price.toString();
      
      // Convert the date to a string with the year, month, and day
      item.date = new Date(item.date).toLocaleDateString('en-US', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit'
      });
    });

    res.send(results);
  });
});

app.get('/electronicdetails', function (req, res) {
  let sql = "SELECT i.iditem, i.image, i.title, c.CategoryName, i.date, i.status, i.price, i.description, s.Fname, s.Lname FROM gp_sw.item i, gp_sw.category c, gp_sw.students s where c.idCategory = i.idCategory and s.registerID = i.registerID ";
  connection.query(sql, function (err, results) {
    if (err) throw err;

    // Convert the price to a string
    results.forEach(item => {
      item.price = item.price.toString();
      
      // Convert the date to a string with the year, month, and day
      item.date = new Date(item.date).toLocaleDateString('en-US', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit'
      });
    });

    res.send(results);
  });
});


app.get('/checkFavorite/:iditem/:registerID', (req, res) => {
  const iditem = req.params.iditem;
  const registerID = req.params.registerID;

  // Query to check if the itemID and registerID exist in the favorite table
  const sql = 'SELECT * FROM favorite WHERE iditem = ? AND registerID = ?';

  connection.query(sql, [iditem, registerID], (err, results) => {
    if (err) {
      res.status(500).json({ error: 'Internal Server Error' });
      throw err;
    }

    // If results contain any rows, both itemID and registerID are found in the favorite table
    const isFavorite = results.length > 0;
    console.log(isFavorite);
    res.json({ isFavorite });
  });
});

app.get('/checkReserved/:iditem/:registerID', (req, res) => {
  const iditem = req.params.iditem;
  const itemRequester = req.params.registerID;

  // Query to check if the itemID and registerID exist in the favorite table
  const sql = 'SELECT * FROM reserved WHERE iditem = ? AND itemRequester = ?';

  connection.query(sql, [iditem, itemRequester], (err, results) => {
    if (err) {
      res.status(500).json({ error: 'Internal Server Error' });
      throw err;
    }

    // If results contain any rows, both itemID and registerID are found in the favorite table
    const isReserved = results.length > 0;
    console.log(isReserved);
    res.json({ isReserved });
  });
});



app.get('/getfavorites/:registerID', (req, res) => {
  const registerID = req.params.registerID;

  // Your SQL query
  const sql = `
    SELECT i.title, i.price, i.image,i.iditem,f.softCopy
    FROM gp_sw.favorite f
    JOIN gp_sw.item i ON i.iditem = f.iditem
    WHERE f.registerID = ?;
  `;

  // Execute the query
  connection.query(sql, [registerID], (err, results) => {
    if (err) {
      res.status(500).json({ error: 'Internal Server Error' });
      throw err;
    }

    // Send the results as JSON
    res.json(results);
  });
});

app.get('/getReserved/:itemOwner',(req,res)=>{
  const itemOwner=req.params.itemOwner;

  const sql=`SELECT DISTINCT
  s.fname,
  s.lname,
  p.profileimage,
  r.iditem,
  i.title,
  r.itemRequester
FROM
  gp_sw.item AS i
JOIN
  gp_sw.reserved AS r ON i.iditem = r.iditem
JOIN
  gp_sw.profile AS p ON r.itemRequester = p.registerid
JOIN
  gp_sw.students AS s ON r.itemRequester = s.registerid
WHERE
  r.itemOwner = ? 
  AND r.decision IS NULL;

  `;

  connection.query(sql,[itemOwner],(err,result)=>{
    if(err){
      res.status(500).json({error:'Internal Server Error'});
      throw err;
    }
    res.json(result);

  });
});


app.get('/getReservedResult/:itemRequester',(req,res)=>{
  const itemRequester=req.params.itemRequester;

  const sql=`SELECT DISTINCT s.fname, s.lname, p.profileimage,r.iditem,i.title,r.decision,r.itemOwner,i.price
  FROM gp_sw.item i, gp_sw.profile p
  JOIN gp_sw.reserved r ON r.itemOwner=p.registerid
  JOIN gp_sw.students s ON r.itemOwner = s.registerid
  WHERE r.itemRequester = ? and i.iditem=r.iditem AND r.decision IS not NULL AND (seeNotification!=1 or seeNotification is NULL);
  `;

  connection.query(sql,[itemRequester],(err,result)=>{
    if(err){
      res.status(500).json({error:'Internal Server Error'});
      throw err;
    }
    res.json(result);

  });
});

app.get('/getReserveditem/:iditem',(req,res)=>{
  const iditem=req.params.iditem;

  const sql=`SELECT DISTINCT
  s.fname,
  s.lname,
  p.profileimage,
  r.iditem,
  i.title,
  r.itemRequester
FROM
  gp_sw.item AS i
JOIN
  gp_sw.reserved AS r ON i.iditem = r.iditem
JOIN
  gp_sw.profile AS p ON r.itemRequester = p.registerid
JOIN
  gp_sw.students AS s ON r.itemRequester = s.registerid
WHERE
  r.iditem = ? 
  AND r.decision IS NULL;
  `;

  connection.query(sql,[iditem],(err,result)=>{
    if(err){
      res.status(500).json({error:'Internal Server Error'});
      throw err;
    }
    res.json(result);

  });
});


app.get('/recevierinfo/:iditem', (req, res) => {
  const iditem = req.params.iditem;

  // Query to select registerID, Fname, and Lname from item and students tables
  const sql = `
    SELECT i.registerID, s.Fname, s.Lname
    FROM gp_sw.item i
    JOIN gp_sw.students s ON s.registerID = i.registerID
    WHERE i.iditem = ?
  `;

  connection.query(sql, [iditem], (err, results) => {
    if (err) {
      res.status(500).json({ error: 'Internal Server Error' });
      throw err;
    }

    // Check if any results were returned
    if (results.length > 0) {
      const { registerID, Fname, Lname } = results[0];
      res.json({ registerID: registerID.toString(), Fname, Lname });
    } else {
      res.json({ registerID: '' }); // Send an empty string if no results
    }
  });
});


app.get('/userchat/:registerID', (req, res) => {
  const registerID = req.params.registerID;

  // Your SQL query
  const sql = `
    SELECT registerID,Fname,Lname from students
    WHERE registerID != ?;
  `;

  // Execute the query
  connection.query(sql, [registerID], (err, results) => {
    if (err) {
      res.status(500).json({ error: 'Internal Server Error' });
      throw err;
    }

    // Send the results as JSON
    res.json(results);
  });
});


app.get('/profileInfo/:registerID', (req, res) => {
  const registerID = req.params.registerID;

  // Your SQL query
  const sql = `
  SELECT s.Fname, s.Lname, p.major, p.about, p.profileimage
  FROM gp_sw.profile p
  JOIN gp_sw.students s ON p.registerID = s.registerID
  WHERE s.registerID = ?;
  `;

  // Execute the query
  connection.query(sql, [registerID], (err, results) => {
    if (err) {
      res.status(500).json({ error: 'Internal Server Error' });
      throw err;
    }

    // Send the results as JSON
    res.json(results);
  });
});

app.get('/profileimage/:registerID', (req, res) => {
  const registerID = req.params.registerID;

  // Your SQL query
  const sql = `
  SELECT p.profileimage
  FROM gp_sw.profile p
  JOIN gp_sw.students s ON p.registerID = s.registerID
  WHERE s.registerID = ?;
  `;

  // Execute the query
  connection.query(sql, [registerID], (err, results) => {
    if (err) {
      res.status(500).json({ error: 'Internal Server Error' });
      throw err;
    }

    // Send the results as JSON
    res.json(results);
  });
});




app.post('/signup',urlencoderParser, signupController.handleSignup);
app.post('/login', urlencoderParser, loginController.handleLogin);
app.post('/addItem', urlencoderParser, addItemController.handleaddItem);
app.post('/addSoft', urlencoderParser, addSoftController.handleaddSoft);
app.post('/addfavorite', urlencoderParser, addfavController.handleaddfavorite);
app.post('/deletefavorite', urlencoderParser, deletefavController.handledeletefavorite);
app.post('/createprofile',urlencoderParser, createProfileController.handleCraeteProfile);
app.post('/insertprofileimage',urlencoderParser, updateprofileImageController.handleInsertProfileImage);
app.post('/editprofileInfo',urlencoderParser, updateprofileInfoController.handleeditProfileInfo);
app.post('/delteitem',urlencoderParser, deleteitemController.handledeleteitem);
app.post('/edititemInfo',urlencoderParser, edititemController.handleeditItemInfo);
app.post('/addReserved',urlencoderParser, addResvController.handleaddReserved);
app.post('/deleteReserved',urlencoderParser, deleteResvController.handledeleteRsvered);
app.post('/addDecision',urlencoderParser, addDecisionController.handleaddDecision);
app.post('/addReview', urlencoderParser, addReviewController.handleaddreview);
app.post('/addSeeNotif',urlencoderParser, addSeeNotificationController.handleaddSeeNotif);
app.post('/updateSale',urlencoderParser, updateSaleCounterController.handleUpdateSaleCounter);
app.post('/addPayment', urlencoderParser, addPaymentController.handleaddPayment);

const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
    service: 'Gmail', // Use the email service provider you prefer
    auth: {
        user: 'raghadsalameh926@gmail.com', // Your email address
        pass: 'Raghad2001*', // Your email password or an app password
    },
});
 
function generateVerificationCode() {
  return Math.floor(1000 + Math.random() * 9000);
}
app.post('/sendVerificationCode', urlencoderParser,(req, res) => {
  const { email } = req.body;
  console.log('********* Request body:', req.body);
  const verificationCode = generateVerificationCode();

  // Save the verification code and email association in your database
  const insertUserQuery = 'UPDATE STUDENTS SET code = ? WHERE registerID = ?';
    connection.query(
      insertUserQuery,
      [verificationCode,11924399],
      (err, result) => {
        if (err) {
          console.error(err);
          res.status(500).send('Error inserting data into the database: ' + err.message);
        } else {
          res.status(200).send('Signup successful');
        }
      });
  const mailOptions = {
      from: 'raghadsalameh926@gmail.com',
      to: email, // The recipient's email
      subject: 'Verification Code',
      text: `Your verification code is: ${verificationCode}`,
  };

  transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
          console.error('Email sending error:', error);
          res.status(500).json({ message: 'Failed to send verification code email' });
      } else {
          console.log('Email sent: ' + info.response);
          res.status(200).json({ message: 'Verification code sent successfully' });
      }
  });
});

app.post('/verifyCode',urlencoderParser, (req, res) => {
  const { email, verificationCode  } = req.body;

  // Retrieve the stored code associated with the email and compare it
  const selectCodeQuery = 'SELECT code FROM STUDENTS WHERE registerID = ?';
  connection.query(selectCodeQuery, 11924399, (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).send('Error querying the database');
    } else {
      if (results.length > 0) {
        const storedCode = results[0].code;

        if (verificationCode === storedCode) {
          res.status(200).send('Verification successful');
        } else {
          res.status(401).send('Incorrect verification code');
        }
      } else {
        res.status(404).send('User not found');
      }
    }
  });
});
  

app.post('/resetPassword',urlencoderParser, (req, res) => {
  const { email, newPassword } = req.body;

  // Update the user's password in your database

  res.status(200).json({ message: 'Password reset successful' });
});
  
//start server:  
app.listen(3000,function(){
    console.log('App Listening on port 3000');
    connection.connect(function(err){
        if(err) throw err;
        console.log('Database connected!');
    })

});