class CommentModel
{
  String ? name;
  String ? image;
  String ? dateTime;
  String ? text;


  CommentModel({
    this.name,
    this.image ,
    this.dateTime ,
    this.text ,


  });
  CommentModel.fromJson(Map<String,dynamic>?json)
  {
    name = json!['name'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];



  }
  Map<String,dynamic>toMap()
  {
    return {
      'name':name,
      'image':image,
      'dateTime':dateTime,
      'text':text,


    };
  }

}
