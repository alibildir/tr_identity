import 'package:ogrenme2/business/tcvalidate.dart';

class FindAgnate {

  FindAgnate();

firstAgnate(String tcNo) {
  var preFive=tcNo.substring(0,5);
  var middleFour=tcNo.substring(5,9);
  var sayiDizi = tcValidate().parcala(tcNo);
  int newID=0;

  newID=((int.parse(preFive)+3)*10000)+(int.parse(middleFour)-1);
  newID=(newID*10)+((((sayiDizi[0]+sayiDizi[2]+sayiDizi[4]+sayiDizi[6]+sayiDizi[8]) * 7 ) + ((sayiDizi[1]+sayiDizi[3]+sayiDizi[5]+sayiDizi[7]) * 9 ))%10) as int;
  newID=(newID*10)+((sayiDizi[0]+sayiDizi[1]+sayiDizi[2]+sayiDizi[3]+sayiDizi[4]+sayiDizi[5]+sayiDizi[6]+sayiDizi[7]+sayiDizi[8]+sayiDizi[9])%10) as int;
  return newID.toString();
}

  lastAgnate(String tcNo) {
    var preFive=tcNo.substring(0,5);
    var middleFour=tcNo.substring(5,9);
    var sayiDizi = tcValidate().parcala(tcNo);
    int newID=0;

    newID=((int.parse(preFive)-3)*10000)+(int.parse(middleFour)-1);
    newID=(newID*10)+((((sayiDizi[0]+sayiDizi[2]+sayiDizi[4]+sayiDizi[6]+sayiDizi[8]) * 7 ) + ((sayiDizi[1]+sayiDizi[3]+sayiDizi[5]+sayiDizi[7]) * 9 ))%10) as int;
    newID=(newID*10)+((sayiDizi[0]+sayiDizi[1]+sayiDizi[2]+sayiDizi[3]+sayiDizi[4]+sayiDizi[5]+sayiDizi[6]+sayiDizi[7]+sayiDizi[8]+sayiDizi[9])%10) as int;
    return newID.toString();
  }
}