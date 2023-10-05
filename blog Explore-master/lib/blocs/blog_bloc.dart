import 'dart:async';

import 'package:blog/models/blog_model.dart';
import 'package:blog/services/networking/api_response.dart';
import 'package:blog/services/repository/blog_repository.dart';




class BlogBloc {
  BlogRepository _blogRepository;

  StreamController _blogListController;

  StreamSink<ApiResponse<List<Blog>>> get blogListSink =>
      _blogListController.sink;

  Stream<ApiResponse<List<Blog>>> get blogListStream =>
      _blogListController.stream;

  BlogBloc({token}) {
    _blogListController = StreamController<ApiResponse<List<Blog>>>();
    _blogRepository = BlogRepository();
    fetchBlogList(token: token);
  }

  fetchBlogList({token}) async {
    blogListSink.add(ApiResponse.loading('Fetching Blogs'));
    try {
      List<Blog> blogs = await _blogRepository.fetchBlogList(token: token);
      blogListSink.add(ApiResponse.completed(blogs));
    } catch (e) {
      blogListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _blogListController?.close();
  }
}