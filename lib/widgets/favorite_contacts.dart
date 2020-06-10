import 'package:flutter/material.dart';
import 'package:fluttershare/models/message.dart';
import 'package:fluttershare/screens/chat_screen.dart';

class FavoriteContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: .5, color: Color(0xffF3F2F6))),
              color: Colors.white,
            ),
            height: 80.0,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: favorites.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        user: favorites[index],
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 20.0,
                          backgroundImage:
                              AssetImage(favorites[index].photoUrl),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          favorites[index].displayName,
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
