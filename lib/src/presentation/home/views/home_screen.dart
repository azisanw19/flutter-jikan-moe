import 'package:anime_list/src/presentation/home/widget/anime_list_bottom_navigation.dart';
import 'package:anime_list/src/presentation/home/widget/anime_list_sliver_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar:
          phoneWidth < 600 ? AnimeListBottomNavigation() : null,
      body: _bodyCompactSize(context),
    );
  }

  Widget _bodyCompactSize(BuildContext context) {
    return CustomScrollView(
      slivers: [
        AnimeListSliverAppBar(
          title: _titleHome(context, data: 'My Feed'),
        ),
        SliverFillRemaining(
          child: _contentHome(context),
        ),
      ],
    );
  }

  Widget _titleHome(BuildContext context, {required String data}) {
    return Text(data);
  }

  Widget _contentHome(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        /* Anime Recommendation */
        _updatedAnime(context),
        // Flexible(child: ),
        // _updatedAnime(context),
        // _updatedAnime(context),
      ],
    );
  }

  Widget _updatedAnime(BuildContext context) {
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


}
