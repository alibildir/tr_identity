import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class NviClient {
  List<dynamic> itemsList = [];
  bool loading = true;
  NviClient();


  Future makeARequest(String queriedID, String queriedName,
      String queriedSurname, String queriedBirthYear) async {
    String requestBody =
        "<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:ws=\"http://tckimlik.nvi.gov.tr/WS\">  <soap:Header/>  <soap:Body>  <ws:TCKimlikNoDogrula>  <ws:TCKimlikNo>${queriedID}</ws:TCKimlikNo>  <!--Optional:-->  <ws:Ad>${queriedName}</ws:Ad>  <!--Optional:-->  <ws:Soyad>${queriedSurname}</ws:Soyad>  <ws:DogumYili>${queriedBirthYear}</ws:DogumYili>  </ws:TCKimlikNoDogrula>  </soap:Body>  </soap:Envelope>";
    var request =
        Uri.parse("https://tckimlik.nvi.gov.tr/Service/KPSPublic.asmx");
    http.Response response = await http.post(request,
        headers: {
          "Content-Type": "text/xml;charset=UTF-8",
          "cache-control": "no-cache"
        },
        body: utf8.encode(requestBody),
        encoding: Encoding.getByName("UTF-8"));

    if(response.statusCode==200) {
      _parsing(response.body);
      itemsList.add(response.statusCode);
    } else {
      itemsList.add(false);
      itemsList.add(response.statusCode);
    }
    print(itemsList[0]);
    print(itemsList[1]);
    loading = false;
    return itemsList;
  }

  _getValue(Iterable<xml.XmlElement> items) {
    var textValue;
    items.map((xml.XmlElement node) {
      textValue = node.text;
    }).toList();
    return textValue;
  }

  Future _parsing(var _response) async {
    var _document = xml.XmlDocument.parse(_response);
    Iterable<xml.XmlElement> items =
        _document.findAllElements('TCKimlikNoDogrulaResponse');
    items.map((xml.XmlElement item) {
      var _addResult = _getValue(item.findElements("TCKimlikNoDogrulaResult"));
      itemsList.add(_addResult);
    }).toList();
  }
}

main() async {
  //for test use this
  // NviClient().makeARequest("12345678901","Ali","Bildir","1979");
}
