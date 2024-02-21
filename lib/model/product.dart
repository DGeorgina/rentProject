import 'package:rent/model/position.dart';

class Product {
  int _id; //za brisenje i dodavanje na nova aktivnost ke gi prebaruvame spored id
  String _name;
  String _description;
  Position _position;

  Product(this._id, this._name, this._description, this._position);

  Position get position => _position;

  set position(Position value) {
    _position = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}
