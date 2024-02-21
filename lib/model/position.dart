class Position {
  String _name;
  int _number;


  Position(this._name, this._number);//constructor

  String get name => _name;

  set name(String value) {
    _name = value;
  }



  int get number => _number;

  set number(int value) {
    _number = value;
  }
}
