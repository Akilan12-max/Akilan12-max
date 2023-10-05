import 'package:blog/models/blog_model.dart';
import 'package:blog/services/networking/api_base_helper.dart';

class BlogRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  final url = 'blogs';

  Future<List<Blog>> fetchBlogList({token}) async {
    final response = await _helper.get(url: url, token:token);
    return blogFromJson(response);
  }
}