import 'dart:developer';

import 'package:shop_app/models/sneakers_model.dart';
import 'package:shop_app/services/helper.dart';
import 'package:shop_app/views/shared/export_files.dart';
import 'package:shop_app/views/shared/export_packages.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifierProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFFE2E2E2),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100.h,
        backgroundColor: Colors.black,
        elevation: 0,
        title: CustomField(
          hintText: "Search for a product",
          controller: searchCtl,
          onEditingComplete: () {
            log("search : ${searchCtl.text}");
            setState(() {});
          },
          prefixIcon: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Icon(Ionicons.camera, color: Colors.black),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Icon(Ionicons.search, color: Colors.black),
          ),
        ),
      ),
      body: searchCtl.text.isEmpty
          ? Container(
              height: 50.sh,
              padding: EdgeInsets.all(20.h),
              margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
              child: Image.asset("assets/images/search.png", fit: BoxFit.cover),
            )
          : FutureBuilder<List<Sneakers>>(
              future: Helper().search(searchCtl.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator.adaptive());
                } else if (snapshot.hasError) {
                  return Center(
                    child: ReusableText(
                      text: "Error Retrieving The Data",
                      style: appstyle(24.sp, FontWeight.bold, Colors.black),
                    ),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return Center(
                    child: ReusableText(
                      text: "Product not found",
                      style: appstyle(24.sp, FontWeight.bold, Colors.black),
                    ),
                  );
                } else {
                  final shoes = snapshot.data;
                  return ListView.builder(
                    itemCount: shoes!.length,
                    itemBuilder: (context, index) {
                      final shoe = shoes[index];
                      return GestureDetector(
                        onTap: () {
                          productNotifier.shoeSizes = shoe.sizes;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductPage(sneakers: shoe),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.h),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              height: 90.h,
                              width: 325.w,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade500,
                                    spreadRadius: 5,
                                    blurRadius: 0.3,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12.h),
                                    child: CachedNetworkImage(
                                      imageUrl: shoe.imageUrl[0],
                                      width: 70.w,
                                      height: 70.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 12.h,
                                      left: 10.w,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ReusableText(text: shoe.name, style: appstyle(16.sp, FontWeight.w600, Colors.black)),
                                        SizedBox(height: 3.h,),
                                        ReusableText(text: shoe.category, style: appstyle(13.sp, FontWeight.w600, Colors.grey.shade600)),
                                        SizedBox(height: 3.h,),
                                        ReusableText(text: " \$${shoe.price}", style: appstyle(13.sp, FontWeight.w600, Colors.grey.shade600)),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
    );
  }
}
