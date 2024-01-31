class Report {
  int idreport;
  String reportcomment;
  int itemId;
  int? registerID;
  String? title;
  String? phoneNumber;
  String? image;
  String? description;
  int? price;
  int? faculty;
  String? major;
  String? fname;
  String? lname;
  String? email;

  String? password;

  Report({
    required this.idreport,
    required this.reportcomment,
    required this.itemId,
    this.registerID,
    this.title,
    this.phoneNumber,
    this.image,
    this.description,
    this.price,
    this.faculty,
    this.major,
    this.fname,
    this.lname,
    this.email,
    this.password,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      idreport: json['idreport'],
      reportcomment: json['reportcomment'],
      itemId: json['itemId'],
      registerID: json['registerID'],
      title: json['title'],
      phoneNumber: json['phoneNumber'],
      image: json['image'],
      description: json['description'],
      price: json['price'],
      faculty: json['faculty'],
      major: json['major'],
      fname: json['fname'],
      lname: json['lname'],
      email: json['email'],
      password: json['password'],
    );
  }

  Report fetchAndLoadStudentData({int? itemID}) {
    return Report(
      // Copy all fields, and update isSelected if provided
      idreport: idreport,
      reportcomment: reportcomment,
      itemId: itemId,
      registerID: registerID,
      title: title,
      phoneNumber: phoneNumber,
      image: image,
      description: description,
      price: price,
      faculty: faculty,
      major: major,
      fname: fname,
      lname: lname,
      email: email,
      password: password,
    );
  }
}
