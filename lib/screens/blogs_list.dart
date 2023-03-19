import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:login/constant/strings.dart';
import 'package:login/constant/styles.dart';
import 'package:login/models/blogs_list_model.dart';
import 'package:login/network/api_service.dart';
import 'package:login/screens/blogs_details.dart';
import 'package:login/utils/commom_functions.dart';
import 'package:login/utils/navigation_util.dart';

class BlogsList extends StatefulWidget {
  const BlogsList({Key? key}) : super(key: key);
  @override
  State<BlogsList> createState() => _BlogsListState();
}

class _BlogsListState extends State<BlogsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            listBlogs(),
          ],
        ),
      ),
    );
  }

  Widget listBlogs() {
    return FutureBuilder<BlogsListModel>(
        future: ApiService().getBlogList(),
        builder:
            (BuildContext context, AsyncSnapshot<BlogsListModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              if (snapshot.error == AstroString.noInternet) {
                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                  CommonFunctions.instance
                      .showSnackBar(context, AstroString.noInternet);
                });
              } else {
                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  CommonFunctions.instance
                      .showSnackBar(context, snapshot.error.toString());
                });
              }
              return Container(
                height: 30.0,
              );
            } else {
              return _blogsData(snapshot.data!);
            }
          }
        });
  }

  Future<void> refrsh() async {
    setState(() {});
  }

  Widget _blogsData(BlogsListModel blogsList) {
    return Expanded(
        child: RefreshIndicator(
      onRefresh: refrsh,
      child: ListView.separated(
        itemCount: blogsList.data!.data!.length,
        itemBuilder: (context, index) {
          return listBlogsData(blogsList.data!.data![index]);
        },
        separatorBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8),
            child: Divider(
              thickness: 1,
            ),
          );
        },
      ),
    ));
  }

  Widget listBlogsData(BlogsLst blogs) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (() {
          NavigationUtil().pushNavigate(
            context,
            BlogDetailsScreen(
              itemID: blogs.id.toString(),
            ),
          );
        }),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                blogs.image.toString(),
                width: 125,
                height: 81,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 155,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    blogs.title.toString(),
                    style: AstroStyles.fontWaight400PrimaryColorViewAll,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    CommonFunctions.instance.parseHtmlString(blogs.content!),
                    maxLines: 3,
                    textAlign: TextAlign.justify,
                    style: AstroStyles.fontWaight400TextColor,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        CommonFunctions.instance.formatTimestamp(blogs.date!),
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
