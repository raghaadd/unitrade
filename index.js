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

const mealspaymentController = require('./mealspaymentController');
const addfavMealsController = require('./addfavoriteMealsController'); 
const deletefavMealsController = require('./deletefavoriteMealsController'); 
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

const updatereviewDone = require('./updatePaymentController'); 
const updatepasswordController= require('./updatepasswordController'); 
const updateUploadPerDay= require('./updateUploadPerDayController'); 

const addFeedbackController = require('./addFeedbackController'); 
const addReportController = require('./addReportController'); 
const editOfferDetailsController = require('./editOfferDetailsController'); 
const addOfferDetailsController = require('./addOfferDetailsController'); 
const deleteOfferDetailsController = require('./deleteofferDetailsController'); 
const addNewMarketController = require('./addNewMarketController'); 
const editMarketController = require('./editMarketController'); 
const deleteMarketController = require('./deleteMarketController'); 
const addMealsController = require('./addNewMealsController'); 
const deleteMealsController = require('./deleteMealsConntroller'); 
const editMealsController = require('./editMealsController'); 
const updateStudent = require('./update_student');
app.put('/updatestudent', urlencoderParser, updateStudent.handleUpdateStudent);

const deleteStudentController = require('./delete_student'); 
app.delete('/students/:userID', urlencoderParser, deleteStudentController.handleDeleteStudents);

const addStudentController = require('./add_student'); 
app.post('/addstudent', urlencoderParser, addStudentController.handleAddStudent);

const getStudentById = require('./fetchAndLoadStudentData'); 
app.get('/getstudent/:id', urlencoderParser, getStudentById.handlegetStudentById);





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
    let sql="SELECT * FROM STUDENTS where registerID!='11124399'";
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
  let sql = "SELECT iditem, title, image, CategoryName, registerID " +
  "FROM item i " +
  "JOIN category c ON c.idCategory = i.idCategory " +
  "LEFT JOIN payment pay ON pay.itemId = i.iditem " +
  "WHERE i.idCategory = 4 AND i.registerID != ? AND (pay.payDone IS NULL OR pay.payDone != 1)";
  
  connection.query(sql,[registerID], function(err, results) {
    if (err) throw err;
    res.send(results);
  });
});

app.get('/electricalspage/:registerID',function(req,res){
  const registerID = req.params.registerID;
    let sql = "SELECT iditem, title, image, CategoryName, registerID " +
    "FROM item i " +
    "JOIN category c ON c.idCategory = i.idCategory " +
    "LEFT JOIN payment pay ON pay.itemId = i.iditem " +
    "WHERE i.idCategory = 3 AND i.registerID != ? AND (pay.payDone IS NULL OR pay.payDone != 1)";
  connection.query(sql,[registerID], function(err, results){
      if(err) throw err;
      res.send(results);
  })
});
app.get('/electronicpage/:registerID', function (req, res) {
  const registerID = req.params.registerID;
  let sql = "SELECT iditem, title, image, CategoryName, registerID " +
    "FROM item i " +
    "JOIN category c ON c.idCategory = i.idCategory " +
    "LEFT JOIN payment pay ON pay.itemId = i.iditem " +
    "WHERE i.idCategory = 2 AND i.registerID != ? AND (pay.payDone IS NULL OR pay.payDone != 1) ";
  
  connection.query(sql, [registerID], function (err, results) {
    if (err) throw err;
    res.send(results);
  });
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

app.get('/searchFilter/:idCategory', function(req, res) {
  const idCategory = req.params.idCategory;

  // Updated SQL query with WHERE clause
  let sql = "SELECT i.iditem, i.title, i.price, i.image, c.CategoryName, i.date, i.phoneNumber, i.status, i.description, s.Fname, s.Lname FROM item i JOIN category c ON i.idCategory = c.idCategory JOIN students s ON i.registerID = s.registerID WHERE i.idCategory = ? AND i.free is null";

  connection.query(sql, [idCategory], function(err, results) {
    if (err) {
      res.status(500).send('Error while fetching data: ' + err.message);
      return;
    }

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

app.get('/searchAdmin', function(req, res) {
  const searchKey = req.params.searchKey;

  // Corrected SQL query with WHERE clause
  let sql = "SELECT s.registerID, fname, lname, phoneNo, email, profileimage as image FROM students s JOIN profile p ON s.registerID = p.registerID ";

  connection.query(sql, [searchKey, `%${searchKey}%`], function(err, results) {
    if (err) {
      res.status(500).send('Error while fetching data: ' + err.message);
      return;
    }

    res.send(results);
  });
});

app.get('/searchoffers',function(req,res){
  let sql="SELECT idofferNames, offerDetails, discount, phoneNumber,idoffers FROM offernames";

  connection.query(sql,function(err, results){
      if(err) throw err;
     
      res.send(results);
  })
});

app.get('/searchMeals',function(req,res){
  let sql="SELECT idmeals, mealtitle, price, image,count FROM meals";

  connection.query(sql,function(err, results){
      if(err) throw err;
     
      res.send(results);
  })
});




app.get('/getItems/:idCategory', function(req, res) {
  const idCategory = req.params.idCategory;

  // Updated SQL query with WHERE clause
  let sql = "SELECT i.iditem, i.title, i.price, i.image, i.date, i.phoneNumber, i.status, i.description, s.Fname, s.Lname FROM item i  JOIN students s ON i.registerID = s.registerID WHERE i.idCategory = ? AND i.free is null";

  connection.query(sql, [idCategory], function(err, results) {
    if (err) {
      res.status(500).send('Error while fetching data: ' + err.message);
      return;
    }

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


app.get('/getItemsSoftware/:idCategory', function(req, res) {
  const idCategory = req.params.idCategory;

  // Updated SQL query with WHERE clause
  let sql = "SELECT i.iditem, i.title, i.price, i.image, i.date, i.phoneNumber, i.status, i.description, s.Fname, s.Lname FROM item i  JOIN students s ON i.registerID = s.registerID WHERE i.idCategory = ? AND i.free is not null";

  connection.query(sql, [idCategory], function(err, results) {
    if (err) {
      res.status(500).send('Error while fetching data: ' + err.message);
      return;
    }

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
  const sql = 'SELECT f.*, p.payDone FROM favorite f ' +
              'LEFT JOIN payment p ON f.iditem = p.itemId ' +
              'WHERE f.iditem = ? AND f.registerID = ? AND (p.payDone IS NULL OR p.payDone != 1)';

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

app.get('/checkFavoriteMeals/:idmeals/:registerID', (req, res) => {
  const idmeals = req.params.idmeals;
  const registerID = req.params.registerID;

  // Query to check if the itemID and registerID exist in the favorite table
  const sql = 'SELECT f.* FROM favoritemeals f ' +
              'WHERE f.idmeals = ? AND f.registerID = ?';
  connection.query(sql, [idmeals, registerID], (err, results) => {
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
  SELECT i.title, i.price, i.image, i.iditem, f.softCopy
  FROM gp_sw.favorite f
  JOIN gp_sw.item i ON i.iditem = f.iditem
  LEFT JOIN gp_sw.payment p ON i.iditem = p.itemId
  WHERE f.registerID = ? AND (p.payDone IS NULL OR p.payDone != 1);  
  `;

  // const sql = 'SELECT f.*, p.payDone FROM favorite f ' +
  // 'LEFT JOIN payment p ON f.iditem = p.itemId ' +
  // 'WHERE f.iditem = ? AND f.registerID = ? AND (p.payDone IS NULL OR p.payDone != 1)';

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


app.get('/getfavoritesMeals/:registerID', (req, res) => {
  const registerID = req.params.registerID;

  // Your SQL query
  const sql = `
  SELECT i.mealtitle, i.price, i.image, i.idmeals,i.details,i.count,COALESCE(Count - countseller, 0) AS leftOver
FROM gp_sw.favoritemeals f
JOIN gp_sw.meals i ON i.idmeals = f.idmeals
where f.registerID=?
  `;
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

app.get('/paymentSuccessful/:purchaserId',(req,res)=>{
  const purchaserId=req.params.purchaserId;

  const sql = `
  SELECT 
    s.fname, 
    s.lname, 
    p.profileimage,
    pay.sellerId,
    pay.itemId,
    pay.ismeal,
    CASE 
      WHEN pay.ismeal = 1 THEN m.mealtitle 
      ELSE "" 
    END as mealname
  FROM gp_sw.payment pay
  JOIN gp_sw.profile p ON pay.sellerId = p.registerid
  JOIN gp_sw.students s ON pay.sellerId = s.registerid
  LEFT JOIN gp_sw.meals m ON pay.itemId = m.idmeals AND pay.ismeal = 1
  WHERE pay.purchaserId = ? AND pay.payDone IS NOT NULL AND (pay.reviewDone != 1 OR pay.reviewDone IS NULL);
`;

  connection.query(sql,[purchaserId],(err,result)=>{
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


//*****************************show reviews************************************//
app.get('/showReviewOtherUser/:original_userID', (req, res) => {
  const original_userID = req.params.original_userID;

  // Your SQL query
  const sql = `
  SELECT s.Fname, s.Lname, r.review, r.comment, p.profileimage
  FROM gp_sw.review r
  JOIN gp_sw.students s ON r.review_userID = s.registerID
  JOIN gp_sw.profile p ON p.registerID=r.review_userID
  WHERE r.original_userID = ? AND r.original_userID != r.review_userID;
  `;

  // Execute the query
  connection.query(sql, [original_userID], (err, results) => {
    if (err) {
      res.status(500).json({ error: 'Internal Server Error' });
      throw err;
    }

    // Send the results as JSON
    res.json(results);
  });
});

app.get('/showReviewItem/:idmeal', (req, res) => {
  const idmeal = req.params.idmeal;

  // Your SQL query
  const sql = `
  SELECT s.Fname, s.Lname, r.review, r.comment, p.profileimage
  FROM gp_sw.review r
  JOIN gp_sw.students s ON r.review_userID = s.registerID
  JOIN gp_sw.profile p ON p.registerID = r.review_userID
  WHERE r.idmeal = ? AND r.original_userID = r.review_userID;
`;

  // Execute the query
  connection.query(sql, [idmeal], (err, results) => {
    if (err) {
      res.status(500).json({ error: 'Internal Server Error' });
      throw err;
    }

    // Send the results as JSON
    res.json(results);
  });
});


app.get('/showMYReview/:original_userID', (req, res) => {
  const original_userID = req.params.original_userID;
  const sql = `
  SELECT s.Fname, s.Lname, r.review, r.comment, p.profileimage
  FROM gp_sw.review r
  JOIN gp_sw.students s ON r.review_userID = s.registerID
  JOIN gp_sw.profile p ON p.registerID=r.review_userID
  WHERE r.original_userID = ? and r.original_userID!=r.review_userID;
  `;

  // Execute the query
  connection.query(sql, [original_userID], (err, results) => {
    if (err) {
      res.status(500).json({ error: 'Internal Server Error' });
      throw err;
    }
    // Send the results as JSON
    res.json(results);
  });
});

////////////***************************************************************//

app.get('/getOffers/:idoffers',(req,res)=>{
  const idoffers=req.params.idoffers;

  const sql=`SELECT idofferNames, offerDetails,discount,phoneNumber,location,details FROM gp_sw.offernames where idoffers=?`;

  connection.query(sql,[idoffers],(err,result)=>{
    if(err){
      res.status(500).json({error:'Internal Server Error'});
      throw err;
    }
    res.json(result);

  });
});

app.get('/getOfferDetails/:idofferNames',(req,res)=>{
  const idofferNames=req.params.idofferNames;

  const sql=`SELECT idofferdetails,offerdetailsName,price,image FROM gp_sw.offerdetails where idofferNames=?`;

  connection.query(sql,[idofferNames],(err,result)=>{
    if(err){
      res.status(500).json({error:'Internal Server Error'});
      throw err;
    }
    res.json(result);

  });
});


app.get('/getMeals',(req,res)=>{
 
  const sql=`SELECT COALESCE(Count - countseller, 0) AS leftOver,idmeals, mealtitle, price, count, image, details FROM gp_sw.meals;`;

  connection.query(sql,(err,result)=>{
    if(err){
      res.status(500).json({error:'Internal Server Error'});
      throw err;
    }
    res.json(result);

  });
});

app.get('/bestMeals',(req,res)=>{
 
  const sql=`SELECT (Count-countseller)leftOver,idmeals, mealtitle, price, count, image, details, countseller
  FROM gp_sw.meals
  WHERE countseller = (SELECT MAX(countseller) FROM gp_sw.meals);`;

  connection.query(sql,(err,result)=>{
    if(err){
      res.status(500).json({error:'Internal Server Error'});
      throw err;
    }
    res.json(result);

  });
});

app.get('/getFeedback',(req,res)=>{
 
  const sql=`SELECT f.registerId,feedbackcomment,fname,lname ,feedbacknumber,profileimage FROM gp_sw.feedback f 
  join students s on s.registerID=f.registerId 
  join profile p on s.registerID=p.registerID;`;

  connection.query(sql,(err,result)=>{
    if(err){
      res.status(500).json({error:'Internal Server Error'});
      throw err;
    }
    res.json(result);

  });
});

app.get('/solditems/:registerID', (req, res) => {
  const registerID = req.params.registerID;

  // Your SQL query
  const sql = `
  SELECT saleCounter FROM gp_sw.students where registerID=?;
  `;

  // Execute the query
  connection.query(sql, [registerID], (err, results) => {
    if (err) {
      res.status(500).json({ error: 'Internal Server Error' });
      throw err;
    }

    // Send the results as JSON
    res.json(results[0]);
  });
});


app.get('/getTotalitem',(req,res)=>{
 
  const sql=`SELECT count(iditem) as total_item  FROM gp_sw.item;`;

  connection.query(sql,(err,result)=>{
    if(err){
      res.status(500).json({error:'Internal Server Error'});
      throw err;
    }
    res.json(result[0]);

  });
});

app.get('/getTotalfeedback',(req,res)=>{
 
  const sql=`SELECT COUNT(idfeedback) as total_feedback FROM gp_sw.feedback`;

  connection.query(sql,(err,result)=>{
    if(err){
      res.status(500).json({error:'Internal Server Error'});
      throw err;
    }
    res.json(result[0]);

  });
});

app.get('/getTotalReport',(req,res)=>{
 
  const sql=`SELECT COUNT(idreport) as total_report FROM gp_sw.report;`;

  connection.query(sql,(err,result)=>{
    if(err){
      res.status(500).json({error:'Internal Server Error'});
      throw err;
    }
    res.json(result[0]);

  });
});

app.get('/gettotalUsers',(req,res)=>{
 
  const sql=`SELECT COUNT(registerID) as total_user FROM gp_sw.students where registerID!='11124399';`;

  connection.query(sql,(err,result)=>{
    if(err){
      res.status(500).json({error:'Internal Server Error'});
      throw err;
    }
    res.json(result[0]);

  });
});

app.get('/gettotalMeals',(req,res)=>{
 
  const sql=`SELECT COUNT(idmeals) as total_meal FROM gp_sw.meals;`;

  connection.query(sql,(err,result)=>{
    if(err){
      res.status(500).json({error:'Internal Server Error'});
      throw err;
    }
    res.json(result[0]);

  });
});

app.get('/gettotalSoldItems',(req,res)=>{
 
  const sql=`SELECT sum(saleCounter) as total_sold_item FROM gp_sw.students;`;

  connection.query(sql,(err,result)=>{
    if(err){
      res.status(500).json({error:'Internal Server Error'});
      throw err;
    }
    res.json(result[0]);

  });
});

app.get('/getUploadPerDay/:registerID', (req, res) => {
  const registerID = req.params.registerID;

  const sql = `SELECT COALESCE(uploadperDay, '0') as uploadperDay FROM gp_sw.students WHERE registerID = ?;`;

  connection.query(sql, [registerID], (err, results) => {
    if (err) {
      res.status(500).json({ error: 'Internal Server Error' });
      throw err;
    }

    // Send the results as JSON
    res.json(results[0]);
  });
});



//////////for piechrat///////////////////
app.get('/getItemsCountByCategory', (req, res) => {
  const sql = 'SELECT i.idCategory, COUNT(iditem) AS itemCount,categoryName FROM gp_sw.item i join category c on c.idCategory=i.idCategory GROUP BY idCategory;';

  connection.query(sql, (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).json({ error: 'Internal Server Error' });
      return;
    }

    const itemCountsByCategory = results.map((result) => ({
      idCategory: result.idCategory,
      itemCount: result.itemCount,
      categoryName:result.categoryName,
    }));

    res.json({ itemCountsByCategory: itemCountsByCategory });
  });
});

app.get('/getItemsCountByStatus', (req, res) => {
  const sql = 'SELECT i.idCategory, COUNT(iditem) AS itemCount, status FROM gp_sw.item i where free is null GROUP BY status;';

  connection.query(sql, (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).json({ error: 'Internal Server Error' });
      return;
    }

    const itemCountsByStatus = results.map((result) => ({
      idCategory: result.idCategory,
      itemCount: result.itemCount,
      status:result.status,
    }));

    res.json({ itemCountsByStatus: itemCountsByStatus });
  });
});



app.get('/reportAdmin',(req,res)=>{
 
  const sql=`SELECT reportcomment,idreport,r.itemId,title,image,phoneNumber,s.*,i.*,
  description,price FROM report r join item i on i.iditem=r.itemId join students s where s.registerID=i.registerID;`;

  connection.query(sql,(err,result)=>{
    if(err){
      res.status(500).json({error:'Internal Server Error'});
      throw err;
    }
    res.json(result);

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
app.post('/updateReviewDone', urlencoderParser, updatereviewDone.handleUpdatePaymentReview);
app.post('/addfavoriteMeals', urlencoderParser, addfavMealsController.handleaddfavoriteMeals);
app.post('/deletefavoriteMeals', urlencoderParser, deletefavMealsController.handledeletefavoriteMeals);
app.post('/mealspayment',urlencoderParser, mealspaymentController.handlemealpayment);
app.post('/changepassword',urlencoderParser, updatepasswordController.handleUpdatePassword);
app.post('/addFeedback',urlencoderParser, addFeedbackController.handleaddFeedback);
app.post('/sendreport',urlencoderParser, addReportController.handleaddReport);
app.post('/editofferDetails',urlencoderParser, editOfferDetailsController.handleeditOfferDetailsInfo);
app.post('/addofferDetails',urlencoderParser, addOfferDetailsController.handleaddOfferDetails);
app.post('/deleteofferDetails',urlencoderParser, deleteOfferDetailsController.handledeleteofferDetails);
app.post('/addNewMarket',urlencoderParser, addNewMarketController.handleaddNewMarket);
app.post('/editMraketDetails',urlencoderParser, editMarketController.handleeditMarket);
app.post('/deleteMarketDetails',urlencoderParser, deleteMarketController.handledeleteMarket);
app.post('/addNewMeals',urlencoderParser, addMealsController.handleaddNewMeals);
app.post('/deleteMeals',urlencoderParser, deleteMealsController.handledeleteMarket);
app.post('/editMeals',urlencoderParser, editMealsController.handleeditMeals);
app.post('/updateUploadPerDay', urlencoderParser, updateUploadPerDay.handleUploadPerDay);



const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
    service: 'Gmail', 
    auth: {
        user: 'unitrade926@gmail.com', 
        pass: 'ppbdktbmvughboaw', 
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
  const insertUserQuery = 'UPDATE STUDENTS SET code = ? WHERE email = ?';
    connection.query(
      insertUserQuery,
      [verificationCode,email],
      (err, result) => {
        if (err) {
          console.error(err);
          res.status(500).send('Error inserting data into the database: ' + err.message);
        } else {
          res.status(200).send('Signup successful');
        }
      });
  const mailOptions = {
      from: 'unitrade926@gmail.com',
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
  const { email, code  } = req.body;
  console.log(req.body);
  const parsedcode= parseInt(code, 10);

  // Retrieve the stored code associated with the email and compare it
  const selectCodeQuery = 'SELECT code FROM STUDENTS WHERE email = ?';
  connection.query(selectCodeQuery, email, (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).send('Error querying the database');
    } else {
      if (results.length > 0) {
        const storedCode = results[0].code;

        if (parsedcode === storedCode) {
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
  const { email, password } = req.body;

  // Update the user's password in your database
  const updatePasswordQuery = 'UPDATE gp_sw.students SET password = ? WHERE email = ?';
      connection.query(updatePasswordQuery, [password, email], (updateError) => {
        if (updateError) {
          res.status(500).json({ error: 'Internal Server Error' });
          throw updateError;
        }
        res.status(200).json({ message: 'Password updated successfully' });
      });
});
  
//start server:  
app.listen(3000,function(){
    console.log('App Listening on port 3000');
    connection.connect(function(err){
        if(err) throw err;
        console.log('Database connected!');
    })

});