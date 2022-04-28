import 'package:flutter/material.dart';

import 'list_myreport_screen.dart';

class MyReportScreen extends StatefulWidget {
  const MyReportScreen({Key? key}) : super(key: key);

  @override
  _MyReportScreenState createState() => _MyReportScreenState();
}

class _MyReportScreenState extends State<MyReportScreen> with TickerProviderStateMixin {

  TabController? _controller;
  int _selectedIndex = 0;

  @override
  void initState(){
    _controller = TabController(length: 4, vsync: this);

    _controller!.addListener(() {
      setState(() {
        _selectedIndex = _controller!.index;
      });
      print("SELECT TAB INDEX : ${_controller!.index}");
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return [
              SliverAppBar(
                backgroundColor: Colors.blueGrey,
                title: Text("My Report"),
                pinned: true,
                floating: true,
                elevation: 0.8,
                bottom: TabBar(
                  controller: _controller,
                  isScrollable: true,
                  indicatorColor: Colors.red,
                  tabs: [
                    Container(
                      height: 40,
                      child: Center(
                        child: Text("Ditinjau",
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Center(
                        child: Text("Diproses",
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Center(
                        child: Text("Selesai",
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Center(
                        child: Text("Ditolak",
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            controller: _controller,
            children: [
              Tab(
                child: ListMyReportScreen(
                  idtab: 1,
                ),
              ),
              Tab(
                child: ListMyReportScreen(
                  idtab: 2,
                ),
              ),
              Tab(
                child: ListMyReportScreen(
                  idtab: 3,
                ),
              ),
              Tab(
                child: ListMyReportScreen(
                  idtab: 4,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
