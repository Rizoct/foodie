class RestaurantModel {
  String? rid;
  String? email_resto;
  String? nama_resto;
  String? desc_resto;
  String? img;

  RestaurantModel({this.rid, this.email_resto, this.nama_resto, this.desc_resto, this.img});

  // receiving data from server
  factory RestaurantModel.fromMap(map) {
    return RestaurantModel(
      rid: map['rid'],
      email_resto: map['email_resto'],
      nama_resto: map['nama_resto'],
      desc_resto: map['desc_resto'],
      img: map['img']
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'rid': rid,
      'email_resto': email_resto,
      'nama_resto': nama_resto,
      'desc_resto': desc_resto,
      'img' : img
    };
  }
}

