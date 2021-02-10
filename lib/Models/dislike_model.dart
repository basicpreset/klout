class Dislike {
  int dislike_id;
  String user_id;
  int post_id;

  Dislike({String user_id, int post_id}) {
    this.dislike_id = 0;
    this.user_id = user_id;
    this.post_id = post_id;
  }

  Dislike.fromJson({dynamic json}) {
    this.dislike_id = json['dislike_id'];
    this.user_id = json['user_id'];
    this.post_id = json['post_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'dislike_id': this.dislike_id,
      'user_id': this.user_id,
      'post_id': this.post_id
    };
  }
}
