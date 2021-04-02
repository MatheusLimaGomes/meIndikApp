import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';

class MovieCard extends StatelessWidget {
  final String posterPath;
  final Function onTap;

  const MovieCard({Key key, this.posterPath, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  Container getContainer() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: getImageByPath(posterPath), fit: BoxFit.cover),
      ),
    );
  }

  NetworkImage getImageByPath(String path) {
    final baseImageUrl = FlutterConfig.get('BASE_IMAGE_URL') + path;
    String imagePath = '$baseImageUrl$path';
    return NetworkImage(imagePath);
  }
}
