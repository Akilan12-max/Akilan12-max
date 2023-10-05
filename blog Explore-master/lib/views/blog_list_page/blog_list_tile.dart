import 'package:blog/models/blog_model.dart';
import 'package:blog/views/blog_detail_page/blog_detail_page.dart';
import 'package:flutter/material.dart';

import '../shared/size_config.dart';

class BlogList extends StatelessWidget {
  final List<Blog> blogList;

  const BlogList({Key key, this.blogList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(
          left: getProportionateScreenWidth(10.5),
          right: getProportionateScreenWidth(10.5)),
      itemCount: blogList.length,
      separatorBuilder: (context, index) {
        return Divider(
          height: getProportionateScreenHeight(1),
          color: Colors.teal,
        );
      },
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    BlogDetailView(selectedBlog: blogList[index].id)));
          },
          child: ListTile(
            title: Text('${blogList[index].title}',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  color: Colors.black,
                )),
            leading: Image.network("${blogList[index].imageUrl}"),
            trailing: Text('${blogList[index].createdAt}',
                style: TextStyle(
                  fontSize: 9,
                  fontFamily: 'Nunito',
                  color: Colors.black,
                )),
          ),
        );
      },
    );
  }
}
