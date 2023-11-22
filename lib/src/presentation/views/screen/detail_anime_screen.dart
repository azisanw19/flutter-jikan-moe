import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DetailAnimeScreen extends StatelessWidget {
  final int malId;

  const DetailAnimeScreen({Key? key, @PathParam('malId') required this.malId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Anime'),
      ),
      body: Center(
        child: Text('Detail Anime'),
      ),
    );
  }
}
