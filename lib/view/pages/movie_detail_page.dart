import 'package:flutter/material.dart';
import 'package:me_indik_app/controllers/movie_details_controller.dart';
import 'package:me_indik_app/view/widgets/centered_message.dart';
import 'package:me_indik_app/view/widgets/centered_progress.dart';
import 'package:me_indik_app/view/widgets/chip_date.dart';
import 'package:me_indik_app/view/widgets/rate.dart';
import 'package:flutter_config/flutter_config.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieID;
  MovieDetailPage(this.movieID);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final _controller = MovieDetailController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildMovieDetail(),
    );
  }

  @override
  void initState() {
    super.initState();
    _initialized();
  }

  _initialized() async {
    setState(() {
      _controller.loading = true;
    });
    await _controller.fetchMovieById(widget.movieID);
    setState(() {
      _controller.loading = false;
    });
  }

  _buildAppBar() {
    return AppBar(
      title: Text(_controller?.movieDetail?.title ?? ''),
    );
  }

  _buildMovieDetail() {
    if (_controller.loading) {
      return CenteredProgress();
    }
    if (_controller.movieError != null) {
      return CenteredMessage(message: _controller.movieError.message);
    }
    return ListView(
      children: [
        _buildCover(),
        _buildStatus(),
        _buildOverView(),
      ],
    );
  }

  _buildCover() {
    String imageBaseUrlPath = FlutterConfig.get('BASE_IMAGE_DETAIL_URL');

    return Image.network(
        '$imageBaseUrlPath${_controller.movieDetail.backdropPath}');
  }

  _buildStatus() {
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Rate(_controller.movieDetail.voteAverage),
            ChipDate(
              date: _controller.movieDetail.releaseDate,
            ),
          ],
        ));
  }

  _buildOverView() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
      child: Text(
        _controller.movieDetail.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
