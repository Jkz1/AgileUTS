import 'package:flutter/material.dart';

class dasarProvider extends ChangeNotifier{
  String _txt = "";
  List<String> _fulloperation = [];
  double _hasil = 0;
  bool _equalstatus = false;
  bool _status = true;

  List<String> _history =[];

  String get txt => _txt;
  bool get status => _status;
  bool get equalstatus => _equalstatus;
  double get hasil => _hasil;
  List<String> get history => _history;
  List<String> get fulloperation => _fulloperation;

  set seteqstatus(val){
    _equalstatus = val;
    notifyListeners();
  }

  set setstatus(val){
    _status = val;
    notifyListeners();
  }

  set sethistory(val){
    _history = val;
    notifyListeners();
  }

  set addhistory(val){
    _history.add(val);
    notifyListeners();
  }

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