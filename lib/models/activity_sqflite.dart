class ActivitySQFLITE {
  String _id;
  String _title;
  String _description;
  String _time;
  String _image;
  String _imagePath;
  bool _isFavorite;

  ActivitySQFLITE(
      this._title, this._description, this._time, this._image, this._imagePath,
      [this._isFavorite]);
  ActivitySQFLITE.withId(this._id, this._title, this._description, this._time,
      this._image, this._imagePath,
      [this._isFavorite]);
  String get id => _id;
  String get title => _title;
  String get description => _description;
  String get time => _time;
  String get image => _image;
  String get imagePath => _imagePath;
  bool get isFavorite => _isFavorite;
  // converting activity object to Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['time'] = _time;
    map['image'] = _image;
    map['imagePath'] = _imagePath;
    map['isFavorite'] = _isFavorite;
    return map;
  }
  // extract activity object from map object

}
