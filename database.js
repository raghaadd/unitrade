var mysql=require("mysql2");
var connection =mysql.createConnection({
    host:'localhost',
    database:'gp_sw',
    user:'root',
    password:'123456'
});


connection.connect((err) => {
    if (err) {
      console.error('Error connecting to the database: ' + err.stack);
      return;
    }
    console.log('Connected to the database as id ' + connection.threadId);
  });


module.exports=connection;