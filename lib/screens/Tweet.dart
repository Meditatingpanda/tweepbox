import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:shoppingapp/components/comment_drawer.dart';
import 'package:shoppingapp/screens/profile_screen.dart';

class Tweet extends StatelessWidget {
  final String avatar;
  final String username;
  final String name;
  final String timeAgo;
  final String text;
  final String comments;
  final String retweets;
  final String favorites;

  const Tweet(
      {Key? key,
      required this.avatar,
      required this.username,
      required this.name,
      required this.timeAgo,
      required this.text,
      required this.comments,
      required this.retweets,
      required this.favorites})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tweetAvatar(context),
          tweetBody(context),
        ],
      ),
    );
  }

  Widget tweetAvatar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: IconButton(
        iconSize: 45,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Profile()));
        },
        icon: CircleAvatar(
          backgroundImage: NetworkImage(avatar),
          radius: 25.0,
        ),
      ),
    );
  }

  Widget tweetBody(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tweetHeader(),
          tweetText(),
          tweetButtons(context),
        ],
      ),
    );
  }

  Widget tweetHeader() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5.0),
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
          child: Text(
            username,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          '@$name · $timeAgo',
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        const Spacer(),
        // IconButton(
        //   icon: const Icon(
        //     FontAwesomeIcons.angleDown,
        //     size: 14.0,
        //     color: Colors.grey,
        //   ),
        //   onPressed: () {},
        // ),
      ],
    );
  }

  Widget tweetText() {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Text(
        text,
        overflow: TextOverflow.clip,
      ),
    );
  }

  Widget tweetButtons(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          tweetIconButton(FontAwesomeIcons.comment, comments, context),
          // tweetIconButton(FontAwesomeIcons.retweet, retweets, context),
          tweetIconButton(FontAwesomeIcons.heart, favorites, context),
          tweetIconButton(FontAwesomeIcons.share, '', context),
        ],
      ),
    );
  }

  Widget tweetIconButton(IconData icon, String text, BuildContext context) {
    return InkWell(
      onTap: () {
        print(icon);
        if (icon == FontAwesomeIcons.heart) {
          print('heart');
        } else if (icon == FontAwesomeIcons.comment) {
          // showModalBottomSheet<void>(
          //   context: context,
          //   shape: const RoundedRectangleBorder(
          //     borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(20.0),
          //         topRight: Radius.circular(20.0)),
          //   ),
          //   builder: (BuildContext context) {
          //     return Container(
          //         height: 500,
          //         decoration: const BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.only(
          //               topLeft: Radius.circular(20.0),
          //               topRight: Radius.circular(20.0)),
          //         ),
          //         child: const Padding(
          //             padding: EdgeInsets.all(20.0), child: CommentDrawer()));
          //   },
          // );
          Navigator.push(
            context,
            CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => const CommentDrawer()),
          );
        } else if (icon == FontAwesomeIcons.retweet) {
          print('retweet');
        } else if (icon == FontAwesomeIcons.share) {
          print('Share');
        }
      },
      child: icon == FontAwesomeIcons.heart
          ? const LikeButton(
              size: 20,
              likeCount: 69,
            )
          : Row(
              children: [
                Icon(
                  icon,
                  size: 16.0,
                  color: Colors.black45,
                ),
                Container(
                  margin: const EdgeInsets.all(6.0),
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
