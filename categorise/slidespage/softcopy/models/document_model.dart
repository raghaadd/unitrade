class Document {
  String? doc_title;
  String? doc_url;
  String? doc_date;
  int? page_num;

  Document(this.doc_title, this.doc_url, this.doc_date, this.page_num);

  static List<Document> doc_list = [
    Document(
      "Introduction + Cryptography", 
      "assets/Introduction + Cryptography.pdf", 
      "14-11-2023", 
      198
    ),

    Document(
      "Access control", 
      "assets/Ch2_Access control.pdf", 
      "6-12-2023", 
      120
    ),

    Document(
      "Steganography", 
      "assets/ch3_Stegno.pdf", 
      "15-12-2023", 
      40
    ),

    Document(
      "Real-world Security Protocols", 
      "assets/Ch4_Real protocols + Firewall.pdf", 
      "20-12-2023", 
      151
    ),
  ];
}

