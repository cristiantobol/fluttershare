import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/pages/home.dart';
import 'package:fluttershare/widgets/custom_image.dart';
import 'package:fluttershare/widgets/progress.dart';

class Post extends StatefulWidget {
  final String postId;
  final String ownerId;
  final String username;
  final String location;
  final String description;
  final String mediaUrl;
  final dynamic likes;
  final dynamic favourites;

  Post({
    this.postId,
    this.ownerId,
    this.username,
    this.location,
    this.description,
    this.mediaUrl,
    this.likes,
    this.favourites,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      postId: doc['postId'],
      ownerId: doc['ownerId'],
      username: doc['username'],
      location: doc['location'],
      description: doc['description'],
      mediaUrl: doc['mediaUrl'],
      likes: doc['likes'],
      favourites: doc['favourites'],
    );
  }

  int getLikeCount(likes) {
    if (likes == null) {
      return 0;
    }
    int count = 0;

    likes.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });

    return count;
  }

  @override
  _PostState createState() => _PostState(
        postId: this.postId,
        ownerId: this.ownerId,
        username: this.username,
        location: this.location,
        description: this.description,
        mediaUrl: this.mediaUrl,
        likes: this.likes,
        favourites: this.favourites,
        likeCount: getLikeCount(this.likes),
      );
}

class _PostState extends State<Post> {
  final String currentUserId = currentUser?.id;
  final String postId;
  final String ownerId;
  final String username;
  final String location;
  final String description;
  final String mediaUrl;
  int likeCount;
  Map likes;
  Map favourites;
  bool isLiked;
  bool isFavourited;

  _PostState({
    this.postId,
    this.ownerId,
    this.username,
    this.location,
    this.description,
    this.mediaUrl,
    this.likeCount,
    this.likes,
    this.favourites,
  });

  buildPostHeader() {
    return FutureBuilder(
      future: usersRef.document(ownerId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        User user = User.fromDocument(snapshot.data);

        return ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(user.photoUrl),
            backgroundColor: Colors.grey,
          ),
          title: GestureDetector(
            onTap: () => print("showing profile"),
            child: Text(
              user.username,
              style: TextStyle(
                color: Color(0xff0B0F34),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Text(
            location,
            style: TextStyle(
              color: Color(0xffACADC1),
            ),
          ),
          trailing: IconButton(
            onPressed: () => print("deleting post"),
            icon: Icon(Icons.more_vert),
          ),
        );
      },
    );
  }

  handleLikePost() {
    bool _isLiked = likes[currentUserId] == true;
    if (_isLiked) {
      postsRef
          .document(ownerId)
          .collection('userPosts')
          .document(postId)
          .updateData({'likes.$currentUserId': false});
      setState(() {
        likeCount -= 1;
        isLiked = false;
        likes[currentUserId] = false;
      });
    } else if (!_isLiked) {
      postsRef
          .document(ownerId)
          .collection('userPosts')
          .document(postId)
          .updateData({'likes.$currentUserId': true});
      setState(() {
        likeCount += 1;
        isLiked = true;
        likes[currentUserId] = true;
      });
    }
  }

  handleFavouritePost() {
    bool _isFavourited = favourites[currentUserId] == true;
    if (_isFavourited) {
      postsRef
          .document(ownerId)
          .collection('userPosts')
          .document(postId)
          .updateData({'favourites.$currentUserId': false});
      setState(() {
        isFavourited = false;
        favourites[currentUserId] = false;
      });
    } else if (!_isFavourited) {
      postsRef
          .document(ownerId)
          .collection('userPosts')
          .document(postId)
          .updateData({'favourites.$currentUserId': true});
      setState(() {
        isFavourited = true;
        favourites[currentUserId] = true;
      });
    }
  }

  buildPostImage() {
    return GestureDetector(
      onDoubleTap: handleLikePost,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: cachedNetworkImage(mediaUrl)),
          ),
        ],
      ),
    );
  }

  buildPostFooter() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40.0, left: 10.0),
            ),
            GestureDetector(
              onTap: handleLikePost,
              child: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                size: 18.0,
                color: Color(0xff5E36FF),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0, right: 10.0),
              child: Text(
                '$likeCount',
                style: TextStyle(
                  fontFamily: "Ubuntu",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.0, right: 10.0),
            ),
            GestureDetector(
              onTap: () => showComments(
                context,
                postId: postId,
                ownerId: ownerId,
                mediaUrl: mediaUrl,
              ),
              child: Icon(
                Icons.chat_bubble_outline,
                size: 18.0,
                color: Color(0xffFA695E),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0, right: 10.0),
              child: Text(
                "23",
                style: TextStyle(
                  fontFamily: "Ubuntu",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: handleFavouritePost,
              child: Icon(
                isFavourited ? Icons.star : Icons.star_border,
                size: 18.0,
                color: Color(0xff5E36FF),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 10.0),
                child: GestureDetector(
                  onTap: () => print("deleting post"),
                  child: Icon(
                    Icons.more_horiz,
                    size: 18.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
//            Container(
//              margin: EdgeInsets.only(left: 20.0),
//              child: Text(
//                "$likeCount likes",
//                style: TextStyle(
//                  color: Colors.black,
//                  fontWeight: FontWeight.bold,
//                ),
//              ),
//            )
          ],
        ),
//        Row(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Container(
//              margin: EdgeInsets.only(left: 20.0),
//              child: Text(
//                "$username",
//                style: TextStyle(
//                  color: Colors.black,
//                  fontWeight: FontWeight.bold,
//                ),
//              ),
//            ),
//            Expanded(
//              child: Text(description),
//            ),
//          ],
//        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    isLiked = (likes[currentUserId] == true);
    isFavourited = (favourites[currentUserId] == true);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildPostHeader(),
        buildPostImage(),
        buildPostFooter(),
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Divider(
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}

showComments(BuildContext context,
    {String postId, String ownerId, String mediaUrl}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return Comments(
        postId: postId, postOwnerId: ownerId, postMediaUrl: mediaUrl);
  }));
}
