import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class JikanMoeRecommended extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 3,
      itemBuilder: (context, index, realIndex) {
        return _contentCarousel(context);
      },
      options: CarouselOptions(
        aspectRatio: 2 / 1.5,
        viewportFraction: 1,
        enableInfiniteScroll: false,
        initialPage: 0,
        padEnds: true,
      ),
    );
  }

  Widget _contentCarousel(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: _imageAnime(context),
        ),
        _shortDescription(context),
      ],
    );
  }

  Widget _imageAnime(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.network(
        'https://loremflickr.com/2208/1242',
      ),
    );
  }

  Widget _shortDescription(BuildContext context) {
    return ListTile(
      title: Text('Nama Anime'),
      subtitle: Text('Here is a second line'),
      isThreeLine: true,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(
          /* TODO tambahkan loading image */
          "https://loremflickr.com/1200/1200",
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('4.3 ★')],
      ),
    );
  }


}