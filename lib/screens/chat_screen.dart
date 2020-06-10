import 'package:flutter/material.dart';
import 'package:fluttershare/models/message.dart';
import 'package:fluttershare/models/user.dart';
import 'package:line_icons/line_icons.dart';
import 'package:bubble/bubble.dart';

class ChatScreen extends StatefulWidget {
  final User user;

  ChatScreen({this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  _buildMessage(Message message, bool isMe) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;

    BubbleStyle styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Color(0xffEBECF2),
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, right: 30.0),
      alignment: Alignment.topLeft,
    );
    BubbleStyle styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: Color(0xff5B6473),
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, left: 30.0),
      alignment: Alignment.topRight,
    );

    final Container msg = Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      margin: isMe
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            )
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        children: <Widget>[
          isMe
              ? Bubble(
                  style: styleMe,
                  padding: BubbleEdges.all(15),
                  child: Text(
                    message.text,
                    style: TextStyle(color: Colors.white, fontFamily: "Ubuntu"),
                  ),
                )
              : Bubble(
                  style: styleSomebody,
                  padding: BubbleEdges.all(15),
                  child: Text(
                    message.text,
                    style: TextStyle(
                        fontFamily: "Ubuntu", color: Color(0xff606776)),
                  ),
                ),
          Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 2.0),
              child: Row(
                mainAxisAlignment:
                    isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    message.time,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 10.0,
                    ),
                  ),
                  isMe
                      ? Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Icon(Icons.done_all,
                              size: 13.0, color: Colors.green[300]),
                        )
                      : Padding(
                          padding: EdgeInsets.all(0),
                        )
                ],
              )),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: .5, color: Color(0xffF3F2F6))),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      height: 50.0,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(LineIcons.image),
            iconSize: 25.0,
            color: Color(0xff5B6475),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(LineIcons.paper_plane),
            iconSize: 25.0,
            color: Color(0xff5B6475),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  buildMessagesList() {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;

    BubbleStyle styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Color(0xffEBECF2),
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, right: 50.0),
      alignment: Alignment.topLeft,
    );
    BubbleStyle styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: Color(0xff5B6473),
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );
    List<Bubble> messagesList = [
      Bubble(
        style: styleSomebody,
        padding: BubbleEdges.all(15),
        child: Text(
          'Hi Jason. Sorry to bother you. I have a queston for you.',
          style: TextStyle(fontFamily: "Ubuntu", color: Color(0xff606776)),
        ),
      ),
      Bubble(
        style: styleMe,
        padding: BubbleEdges.all(15),
        child: Text(
          'Whats\'up?',
          style: TextStyle(color: Colors.white, fontFamily: "Ubuntu"),
        ),
      ),
      Bubble(
        style: styleSomebody,
        padding: BubbleEdges.all(15),
        child: Text(
          'I\'ve been having a problem with my computer.',
          style: TextStyle(fontFamily: "Ubuntu"),
        ),
      ),
      Bubble(
        style: styleSomebody,
        margin: BubbleEdges.only(top: 2.0),
        padding: BubbleEdges.all(15),
        nip: BubbleNip.no,
        child: Text(
          'Can you help me?',
          style: TextStyle(fontFamily: "Ubuntu"),
        ),
      ),
      Bubble(
        style: styleMe,
        padding: BubbleEdges.all(15),
        child: Text(
          'Ok',
          style: TextStyle(color: Colors.white, fontFamily: "Ubuntu"),
        ),
      ),
      Bubble(
        style: styleMe,
        padding: BubbleEdges.all(15),
        nip: BubbleNip.no,
        margin: BubbleEdges.only(top: 2.0),
        child: Text(
          'What\'s the problem?',
          style: TextStyle(color: Colors.white, fontFamily: "Ubuntu"),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(LineIcons.angle_left, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage(widget.user.photoUrl),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => print("go to profile"),
                    child: Text(
                      "James",
                      style: TextStyle(
                          color: Color(0xff0B0F34),
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "Online",
                    style: TextStyle(color: Color(0xffACADC1), fontSize: 10.0),
                  ),
                ],
              ),
            ),
          ],
        ),
        elevation: 1.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 20.0,
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ListView.builder(
                  reverse: false,
                  padding: EdgeInsets.only(top: 15.0),
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Message message = messages[index];
                    final bool isMe = message.sender.id == currentUser.id;
                    return _buildMessage(message, isMe);
                  },
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
