

import 'dart:convert';

CommentsModel commentsModelFromJson(String str) => CommentsModel.fromJson(json.decode(str));



class CommentsModel {
  CommentsModel({
     this.docId,
     this.productId,
     this.userId,
     this.comment,
     this.time,
  });

  String ?docId;
  String ?productId;
  String ?userId;
  String ?comment;
  String ?time;

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
    docId: json["docId"],
    productId: json["productId"],
    userId: json["userId"],
    comment: json["comment"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "docId": docId,
    "productId": productId,
    "userId": userId,
    "comment": comment,
    "time": time,
  };
}
