import 'dart:convert';

import 'package:blog/models/blog_model.dart';
import 'package:blog/services/networking/api_base_helper.dart';

class BlogDetailsRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<Blog> fetchBlogDetails({token, selectedBlog}) async {
    final url = "blogs/${int.parse(selectedBlog)}";

    final response = await _helper.get(url: url, token:token);
    return Blog.fromJson(jsonDecode(response.toString()));
  }
}
