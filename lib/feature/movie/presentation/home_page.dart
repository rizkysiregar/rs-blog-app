import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rs_blog_app/core/common/widgets/loader.dart';
import 'package:rs_blog_app/core/utils/show_snackbar.dart';
import 'package:rs_blog_app/feature/movie/presentation/banner_movie_card.dart';
import 'package:rs_blog_app/feature/movie/presentation/bloc/movie_bloc.dart';
import 'package:rs_blog_app/feature/movie/presentation/section_movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(FetchMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              homeHeader(),
              const SizedBox(height: 8),
              playingNow(),
              const SizedBox(height: 8),
              popularSectionMovie()
            ],
          ),
        ),
      ),
    );
  }
}

Widget homeHeader() {
  return Row(
    children: [
      ClipOval(
        child: Image.asset(
          'assets/profile_picture.jpg',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(width: 8),
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello, Rizky Siregar",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("Let's stream your favorite movies!"),
        ],
      ),
    ],
  );
}

Widget playingNow() {
  return BlocConsumer<MovieBloc, MovieState>(
    listener: (context, state) {
      if (state is MovieFailure) {
        showSnackbar(context, state.message);
      }
    },
    builder: (context, state) {
      if (state is MovieLoading) {
        return const Loader();
      } else if (state is MovieSuccess) {
        return SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.nowPlaying.results.length,
            itemBuilder: (context, index) {
              return BannerMovieCard(
                movie: state.nowPlaying.results[index],
              );
            },
          ),
        );
      } else {
        return const Center(
          child: Text('Fail to fetch'),
        );
      }
    },
  );
}

Widget popularSectionMovie() {
  return BlocConsumer<MovieBloc, MovieState>(
    listener: (context, state) {
      if (state is MovieFailure) {
        showSnackbar(context, state.message);
      }
    },
    builder: (context, state) {
      if (state is MovieLoading) {
        return const Loader();
      } else if (state is MovieSuccess) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 290,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.popular.results.length,
                itemBuilder: (context, index) {
                  return SectionMovieCard(
                    movie: state.popular.results[index],
                  );
                },
              ),
            ),
          ],
        );
      } else {
        return const Center(
          child: Text('Fail to fetch'),
        );
      }
    },
  );
}
