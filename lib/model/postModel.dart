class PostModel
{
  String ? name;
  String ? uId;
  String ? image;
  String ? dateTime;
  String ? text;
  int ? comment;
  String ? postImage;
  String ? postId;

  PostModel({
    this.name,
    this.uId,
    this.image ,
    this.dateTime ,
    this.text ,
    this.comment ,
    this.postImage ,
    this.postId ,
  });
  PostModel.fromJson(Map<String,dynamic>?json)
  {
    name = json!['name'];
    uId = json['uId'];
    postId = json['postId'];
    image = json['image'];
    dateTime = json['dateTime'];
    comment = json['comment'];
    text = json['text'];
    postImage = json['postImage'];

  }
  Map<String,dynamic>toMap()
  {
    return {
      'name':name,
      'uId':uId,
      'image':image,
      'dateTime':dateTime,
      'dateTime':postId,
      'text':text,
      'comment':comment,
      'postImage':postImage,
    };
  }

}
