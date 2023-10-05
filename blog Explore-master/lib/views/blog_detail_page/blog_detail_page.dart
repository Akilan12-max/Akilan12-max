import 'package:blog/blocs/blog_details_bloc.dart';
import 'package:blog/models/blog_model.dart';
import 'package:blog/models/user_model.dart';
import 'package:blog/services/networking/api_response.dart';
import 'package:blog/views/shared/loading.dart';
import 'package:blog/views/shared/error_message.dart';
import 'package:flutter/material.dart';

import '../shared/size_config.dart';

class BlogDetailView extends StatefulWidget {
  final dynamic selectedBlog;

  const BlogDetailView({Key key, this.selectedBlog}) : super(key: key);
  @override
  _BlogDetailViewState createState() => _BlogDetailViewState();
}

class _BlogDetailViewState extends State<BlogDetailView> {
  BlogDetailsBloc _blogDetailsBloc;

  @override
  void initState() {
    super.initState();
    _blogDetailsBloc =
        BlogDetailsBloc(token: TokenNotifier.token, selectedBlog: widget.selectedBlog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blogs Details"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _blogDetailsBloc.fetchBlogDetailsList(),
          child: StreamBuilder<ApiResponse<Blog>>(
            stream: _blogDetailsBloc.blogDetailsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return Loading(loadingMessage: snapshot.data.message);
                    break;
                  case Status.COMPLETED:
                    return MovieDetails(blogDetails: snapshot.data.data);
                    break;
                  case Status.ERROR:
                    return Error(
                      errorMessage: snapshot.data.message,
                      onRetryPressed: () =>
                          _blogDetailsBloc.fetchBlogDetailsList(),
                    );
                    break;
                }
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _blogDetailsBloc.dispose();
    super.dispose();
  }
}

class MovieDetails extends StatelessWidget {
  final Blog blogDetails;

  const MovieDetails({Key key, this.blogDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          SizedBox(height: getProportionateScreenHeight(30)),
          Text("${blogDetails.title}"),
          SizedBox(height: getProportionateScreenHeight(30)),
          Container(
            height: 70,
            width: 70,
            child: Image.network("${blogDetails.imageUrl}"),
          ),
          Text("${blogDetails.createdAt}"),
          SizedBox(height: getProportionateScreenHeight(30)),
      ],
    ),
        ));
  }
}
