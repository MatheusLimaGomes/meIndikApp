import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_indik_app/constants/movie_constants.dart';
import 'package:me_indik_app/controllers/movies_controller.dart';
import 'package:me_indik_app/view/widgets/centered_message.dart';
import 'package:me_indik_app/view/widgets/centered_progress.dart';
import 'package:me_indik_app/view/widgets/movie_card.dart';

class MoviePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final _controller = MovieController();
  final _scrollController = ScrollController();
  int lastPage = 1;

  @override
  void initState() {
    super.initState();
    _initScrollListener();
  }

  void _initScrollListener() {
    _scrollController.addListener(() async {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          _controller.currentPage == lastPage) {
        lastPage++;
        await _controller.fetchPopullarMovies(page: lastPage);
        setState(() {});
      }
    });
  }

  _initialize() async {
    setState(() {
      _controller.loading = true;
    });
    await _controller.fetchPopullarMovies(page: lastPage);
    setState(() {
      _controller.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildMovieGrid(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Text(kAppName),
      actions: [
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: _initialize(),
        )
      ],
    );
  }

  _buildMovieGrid() {
    if (_controller.loading) {
      return CenteredProgress();
    }
    if (_controller.movieError != null) {
      return CenteredMessage(message: _controller.movieError.message);
    }
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(2.0),
      itemCount: _controller.moviesCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 0.65,
      ),
      itemBuilder: _buildMovieCard,
    );
  }

  Widget _buildMovieCard(context, index) {
    final movie = _controller.movies[index];
    return MovieCard(
      posterPath: movie.posterPath,
      onTap: () => _openDetailPage(movie.id),
    );
  }

  _openDetailPage(movieId) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MovieDetailPage(movieId)));
  }
}
