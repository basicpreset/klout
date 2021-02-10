class Like {
  int like_id;
  String user_id;
  int post_id;

  Like({String user_id, int post_id}) {
    this.like_id = 0;
    this.user_id = user_id;
    this.post_id = post_id;
  }

  Like.fromJson({dynamic json}) {
    this.like_id = json['like_id'];
    this.user_id = json['user_id'];
    this.post_id = json['post_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'like_id': this.like_id,
      'user_id': this.user_id,
      'post_id': this.post_id
    };
  }
}
