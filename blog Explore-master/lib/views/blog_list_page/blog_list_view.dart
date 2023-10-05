import 'package:blog/blocs/blog_bloc.dart';
import 'package:blog/models/blog_model.dart';
import 'package:blog/models/user_model.dart';
import 'package:blog/services/networking/api_response.dart';
import 'package:blog/views/shared/loading.dart';
import 'package:blog/views/shared/error_message.dart';
import 'package:flutter/material.dart';

import '../shared/size_config.dart';
import 'blog_list_tile.dart';

class BlogListView extends StatefulWidget {
  
  @override
  _BlogListViewState createState() => _BlogListViewState();
}

class _BlogListViewState extends State<BlogListView> {
  BlogBloc _bloc; 


  @override
  void initState() {
    super.initState();
    _bloc = BlogBloc(token: TokenNotifier.token);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Blogs"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchBlogList(),
        child: StreamBuilder<ApiResponse<List<Blog>>>(
          stream: _bloc.blogListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  print(snapshot.data.data);
                  return BlogList(blogList: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchBlogList(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}
