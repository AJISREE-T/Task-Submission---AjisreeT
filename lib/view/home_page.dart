import 'package:flutter/material.dart';
import 'package:productapp/api/api_calls.dart';
import 'package:productapp/const/color.dart';
import 'package:productapp/model/category_model.dart';
import 'package:productapp/view/product_detail_page.dart';
import 'package:productapp/view/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Product Category'),
        // ),
        body: FutureBuilder(
          future: ApiCalls().getCategory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              Map data = snapshot.data!;
              if (data['Result'] == 'success') {
                List<CategoryModel> category = snapshot.data?['data'];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text(
                            'Welcome back !',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: AppColor.homepageTitle),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePage()));
                            },
                            child: CircleAvatar(
                              radius: 20,
                              child: Icon(Icons.person),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //     crossAxisCount: 2, childAspectRatio: 1.8),
                          itemCount: category.length,
                          itemBuilder: (BuildContext context, int index) {
                            final current = category[index];
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 80,
                                    // width: ,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailPage()));
                                        //  Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           ProductDetailpage(
                                        //             productDetail: current,
                                        //           ))).then((value) {
                                        // setState(() {});
                                        // });
                                      },
                                      child: Card(
                                        elevation: 5,
                                        color: AppColor.homepageTitle,
                                        child: Center(
                                            child: Text(
                                          current.catName,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        )),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                );
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [

                //   ],
                // );
              } else {
                return Text('Something went wrong');
              }
            } else {
              return Text('Something went wrong...');
            }
          },
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [

          // ],),
        ),
      ),
    );
  }
}
