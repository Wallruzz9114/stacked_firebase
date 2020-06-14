import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked_firebase/src/models/post.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    Key key,
    this.post,
    this.onDeleteItem,
  }) : super(key: key);

  final Post post;
  final Function onDeleteItem;

  @override
  Container build(BuildContext context) => Container(
        height: post.imageUrl != null ? null : 60,
        margin: const EdgeInsets.only(top: 20),
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  children: <Widget>[
                    if (post.imageUrl != null)
                      SizedBox(
                        height: 250,
                        child: CachedNetworkImage(
                          imageUrl: post.imageUrl,
                          placeholder: (BuildContext context, String url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (BuildContext context, String url,
                                  dynamic error) =>
                              Icon(Icons.error),
                        ),
                      )
                    else
                      Container(),
                    Text(post.title),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                if (onDeleteItem != null) {
                  onDeleteItem();
                }
              },
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: <BoxShadow>[
            BoxShadow(blurRadius: 8, color: Colors.grey[200], spreadRadius: 3)
          ],
        ),
      );
}
