import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/shared/listitem.dart';
import 'package:faker/faker.dart' as faker;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: homepage(),
    );
  }
}

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}
//lets extend our app to SingleTickerProviderStateMixin

class _homepageState extends State<homepage> with
    SingleTickerProviderStateMixin {


  

  //creating the list
  List<Tab> _tablist = [
    Tab(
      child: Text("Business"),
    ),
    Tab(
      child: Text("Entertainment"),
    ),
    Tab(
      child: Text("Sports"),
    ),
    Tab(
      child: Text("Health"),
    ),
    Tab(
      child: Text("Technology"),
    ),
  ];
  //lets create tab controller
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length:_tablist.length,vsync: this);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: AppBar(
        toolbarHeight: 80.0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),

        backgroundColor: Colors.white,
        centerTitle :true,
        title: Text(
          "NEWS APP",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          //need to create tab controller and tab list
          child: TabBar(
            indicatorColor: Colors.black,
            tabs: _tablist,
            isScrollable:true,
            labelColor: Colors.black,
            controller: _tabController,
          ),
        ),
      ),
      // now lets start creating the tab bar
      body: TabBarView(
        controller: _tabController,
        children: [
          //now creating the top container
          Padding(padding:EdgeInsets.all(8.0),
            //need to create a list item class......
            child: ListOfNewsItems(category: "business"),
          ),
          Padding(padding:EdgeInsets.all(8.0),
            child:  ListOfNewsItems(category: "entertainment")
          ),
          Padding(padding:EdgeInsets.all(8.0),
            child: ListOfNewsItems(category: "sports"),
          ),
          Padding(padding:EdgeInsets.all(8.0),
            child: ListOfNewsItems(category: "health"),
          ),
          Padding(padding:EdgeInsets.all(8.0),
            child: ListOfNewsItems(category: "technology"),
          ),
        ],
      ) ,
    );
  }
}


