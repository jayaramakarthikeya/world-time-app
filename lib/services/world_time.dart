import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      //get properties of the data
      String datetime = data['datetime'];

      String offsetSymbol = data['utc_offset'].substring(0, 1);
      String offsetNum = data['utc_offset'].substring(1, 3);

      //create datetime object
      DateTime now = DateTime.parse(datetime);

      now = (offsetSymbol == '+')
          ? now.add(Duration(hours: int.parse(offsetNum), minutes: 30))
          : now.subtract(Duration(hours: int.parse(offsetNum), minutes: 30));

      //set time property
      isDayTime = now.hour > 6 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print(e);
      time = 'could not get the time';
      isDayTime = true;
    }
  }
}
