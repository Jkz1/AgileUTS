import 'package:flutter/material.dart';

class dasarProvider extends ChangeNotifier{
  String _txt = "";
  List<String> _fulloperation = [];
  double _hasil = 0;

  String get txt => _txt;
  double get hasil => _hasil;
  List<String> get fulloperation => _fulloperation;

  set settxt(val){
    _txt = val;
    notifyListeners();
  }

  set sethasil(val){
    _hasil = val;
    notifyListeners();
  }

  set setfullop(val){
    _fulloperation = val;
    notifyListeners();

  }

  void hitung(){
    List<double> _angka = [];
    List<String> _operasi = [];
    _angka.clear();
    _operasi.clear();
    for(int i = 0; i < _fulloperation.length; i++){
      if(i % 2 == 0){
        _angka.add(double.parse(_fulloperation[i]));
      }else if(i % 2 == 1){
        _operasi.add(_fulloperation[i]);
      }
    }


    for(int i = 0; i < _operasi.length; i++){
      if(_operasi[i] == "x"){
        _operasi.removeAt(i);
        _angka.insert(i+2, _angka[i]*_angka[i+1]);
        _angka.removeAt(i);
        _angka.removeAt(i);
        i--;
      }
      else if(_operasi[i] == "/"){
        _operasi.removeAt(i);
        _angka.insert(i+2, _angka[i]/_angka[i+1]);
        _angka.removeAt(i);
        _angka.removeAt(i);
        i--;
      }
    }
    for(int i = 0; i < _operasi.length; i++){
      if(_operasi[i] == "+"){
        _operasi.removeAt(i);
        _angka.insert(i+2, _angka[i]+_angka[i+1]);
        _angka.removeAt(i);
        _angka.removeAt(i);
        i--;
      }
      else if(_operasi[i] == "-"){
        _operasi.removeAt(i);
        _angka.insert(i+2, _angka[i]-_angka[i+1]);
        _angka.removeAt(i);
        _angka.removeAt(i);
        i--;
      }
    }

    _hasil = _angka[0];

  
  }

}