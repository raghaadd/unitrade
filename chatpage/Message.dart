import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final DateTime date;
  final bool isSentByme;

  Message({
    required this.text,
    required this.date,
    required this.isSentByme,
  });

  // Add this fromMap method to convert a Map to a Message instance
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      text: map['text'] ?? '',
      date: map['date'] != null
          ? (map['date'] as Timestamp).toDate()
          : DateTime.now(),
      isSentByme: map['isSentByMe'] ?? true,
    );
  }
}
