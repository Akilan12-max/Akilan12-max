import 'dart:async';

import 'package:blog/models/blog_model.dart';
import 'package:blog/services/networking/api_response.dart';
import 'package:blog/services/repository/blog_detail_repository.dart';

class BlogDetailsBloc {
  BlogDetailsRepository _blogDetailsRepository;

  StreamController _blogDetailsController;

  StreamSink<ApiResponse<Blog>> get blogDetailsSink =>
      _blogDetailsController.sink;

  Stream<ApiResponse<Blog>> get blogDetailsStream =>
      _blogDetailsController.stream;

  BlogDetailsBloc({token, selectedBlog}) {
    _blogDetailsController = StreamController<ApiResponse<Blog>>();
    _blogDetailsRepository = BlogDetailsRepository();
    fetchBlogDetailsList(token: token, selectedBlog: selectedBlog);
  }

  fetchBlogDetailsList({token, selectedBlog}) async {
    blogDetailsSink.add(ApiResponse.loading('Fetching Blog Details'));
    try {
      Blog blogDetails = await _blogDetailsRepository.fetchBlogDetails(
          token: token, selectedBlog: selectedBlog);
      blogDetailsSink.add(ApiResponse.completed(blogDetails));
    } catch (e) {
      blogDetailsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _blogDetailsController?.close();
  }
}
