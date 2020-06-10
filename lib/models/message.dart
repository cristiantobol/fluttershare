import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/pages/home.dart';

class Message {
  final User sender;
  final String
  time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.unread,
  });
}

// YOU - current user
final User currentUser = User(
  id: "1",
  displayName: "James",
  photoUrl: 'assets/images/greg.jpg',
);

// USERS
final User greg = User(
  id: "22",
  displayName: 'Greg',
  photoUrl: 'assets/images/greg.jpg',
);
final User james = User(
  id: "44",
  displayName: 'James',
  photoUrl: 'assets/images/james.jpg',
);
final User john = User(
  id: "3",
  displayName: 'John',
  photoUrl: 'assets/images/john.jpg',
);
final User olivia = User(
  id: "4",
  displayName: 'Olivia',
  photoUrl: 'assets/images/olivia.jpg',
);
final User sam = User(
  id: "5",
  displayName: 'Sam',
  photoUrl: 'assets/images/sam.jpg',
);
final User sophia = User(
  id: "6",
  displayName: 'Sophia',
  photoUrl: 'assets/images/sophia.jpg',
);
final User steven = User(
  id: "7",
  displayName: 'Steven',
  photoUrl: 'assets/images/steven.jpg',
);

// FAVORITE CONTACTS
List<User> favorites = [sam, steven, olivia, john, greg];

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    sender: james,
    time: '20/05/2020 5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: true,
  ),
  Message(
    sender: olivia,
    time: '4:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: true,
  ),
  Message(
    sender: john,
    time: '3:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: false,
  ),
  Message(
    sender: sophia,
    time: '2:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: true,
  ),
  Message(
    sender: steven,
    time: '1:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: false,
  ),
  Message(
    sender: sam,
    time: '12:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: false,
  ),
  Message(
    sender: greg,
    time: '11:30 AM',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: false,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    sender: currentUser,
    time: '20/05/2020 5:30 PM',
    text: 'Hey, how\'s it going? What did you do today? Have you ever seen the rain?',
    unread: true,
  ),
  Message(
    sender: olivia,
    time: '4:30 PM',
    text: 'Just walked my doge. She was super duper cute. The best pupper!!',
    unread: true,
  ),
  Message(
    sender: james,
    time: '3:45 PM',
    text: 'How\'s the doggo?',
    unread: true,
  ),
  Message(
    sender: olivia,
    time: '3:15 PM',
    text: 'All the food',
    unread: true,
  ),
  Message(
    sender: james,
    time: '2:30 PM',
    text: 'Nice! What kind of food did you eat?',
    unread: true,
  ),
  Message(
    sender: olivia,
    time: '2:00 PM',
    text: 'I ate so much food today.',
    unread: true,
  ),
];