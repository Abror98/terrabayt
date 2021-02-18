import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:terrabayt/model/info_model.dart';
import 'package:terrabayt/net/base_url.dart';

class InfoRepository{
  String url = BaseUrl.BASEURL;

  @override
  Future<List<NewsModel>> getNewsList(int firstUpdate, int lastUpdate, int category, int limit) async{
    http.Response response = await http.get(url + "api.php?action=posts&first_update=$firstUpdate&last_update=$lastUpdate&category=$category&limit=$limit").timeout(Duration(seconds: BaseUrl.TIMEOUT));
    List<NewsModel> info = newsModelFromJson(response.body);
    return info;
  }

}