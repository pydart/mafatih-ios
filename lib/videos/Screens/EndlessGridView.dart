import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../data/utils/style.dart';
import '../Server/server.dart';
import '../Widgets/CustomCircularProgressIndicator.dart';
import '../models/theme_model.dart';
import 'SingleVideoPage.dart';

class EndlessGridView extends StatefulWidget {
  EndlessGridView(this.cat_id, this.pageNum, this.cat_name, {Key? key})
      : super(key: key);
  final String cat_id;
  int pageNum;
  final String cat_name;



  @override
  _EndlessGridViewState createState() => _EndlessGridViewState();
}

class _EndlessGridViewState extends State<EndlessGridView> {
  List<theme_model> data_theme_model = [];
  bool isLoading = false;
  int page = 1;
  ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchData();

  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  void _scrollListener() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final delta = MediaQuery.of(context).size.height * 0.50;

    if (maxScroll - currentScroll <= delta && !isLoading) {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    // Simulate API call delay
    await Future.delayed(Duration(seconds: 2));

    // Fetch data from API
    List<theme_model> newData = await _getDataFromApi(page);
    print("fetchData: $data_theme_model");

    setState(() {
      isLoading = false;
      data_theme_model.addAll(newData);
      print("fetchData data_theme_model.addAll(newData): $data_theme_model");

      page++;
    });
  }



  Future<List<theme_model>> _getDataFromApi(int page) async {
    List all_vid_each_page = [];
    String UrlApi;

    widget.cat_id == "0"
        ? UrlApi = "video/all-videos"
        : UrlApi = "app/category/${widget.cat_id}";

    var response =
    await server().Get("${UrlApi}?page=${page.toString()}", true);
    List all_vid_each_page_1 =
    jsonDecode(response)["data"]["videos"]["data"];
    all_vid_each_page.addAll(all_vid_each_page_1);
    var result = List<theme_model>.from(
        all_vid_each_page.map((x) => theme_model.fromjson(x)));

    print("_getDataFromApi: $result");
    return result;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.green
            : Colors.black,
              pinned: true,
              leading: IconButton(
                icon: Icon(
                  Icons.keyboard_backspace,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                widget.cat_name,
                style: AppStyle.titleup,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // Handle item tap
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Activity_Review(
                                        theme_data:
                                        data_theme_model[index])));
                        print('Item ${data_theme_model[index].id} tapped');
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.network(
                                "https://arbaeentv.com/" +
                                    data_theme_model[index].cover_address!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data_theme_model[index].title!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: data_theme_model.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              ),
            ),
            if (isLoading)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: CustomCircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        )
    );
  }
}