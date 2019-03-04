import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:questionnaire/src/models/user.dart';
import 'package:questionnaire/src/widgets/compressed_image.dart';

class ProfilePhoto extends StatelessWidget {
  final User user;
  final double radius;

  const ProfilePhoto({Key key, this.user, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (user.photoUrl != null) {
      return CachedNetworkImage(
        imageUrl: user.photoUrl,
        errorWidget: (context, url, e) => Icon(Icons.error),
        placeholder: (context, url) => CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.yellow),
            ),
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
            child: CompressedImage(
              quality: 25,
              imageProvider: imageProvider,
            ),
          );
        },
      );
    }

    final abbreviation = user.name
        .split(' ')
        .take(2)
        .map((word) => word[0].toUpperCase())
        .join();

    var color = Colors.primaries[user.color];
    if (color == Colors.blue) {
      color = Colors.green;
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: Text(
        abbreviation,
        style: TextStyle(
          fontSize: radius,
        ),
      ),
    );
  }
}