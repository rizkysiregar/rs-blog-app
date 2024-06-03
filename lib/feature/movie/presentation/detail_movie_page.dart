import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rs_blog_app/core/common/constants/constants.dart';
import 'package:rs_blog_app/core/common/widgets/loader.dart';
import 'package:rs_blog_app/core/utils/show_snackbar.dart';
import 'package:rs_blog_app/feature/movie/presentation/bloc/movie_bloc.dart';

class DetailMoviePage extends StatefulWidget {
  final int id;
  const DetailMoviePage({super.key, required this.id});

  @override
  State<DetailMoviePage> createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(FetchDetailMovie(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Center(
          child: BlocConsumer<MovieBloc, MovieState>(
            listener: (context, state) {
              if (state is DetailMovieFailure) {
                showSnackbar(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is MovieLoading) {
                return const Loader();
              } else if (state is DetailMovieSuccess) {
                return Column(
                  children: [
                    // header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.arrow_back_ios),
                        Text(state.detailMovie.originalTitle),
                        const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    // image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        Constants.baseImageUrl + state.detailMovie.posterPath,
                        width: 205,
                        height: 287,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // list property
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.date_range_outlined,
                              size: 12,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              state.detailMovie.releaseDate,
                              style: const TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                        const Text("|"),
                        Row(
                          children: [
                            const Icon(
                              Icons.attach_money_outlined,
                              size: 12,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              state.detailMovie.budget.toString(),
                              style: const TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                        const Text("|"),
                        Row(
                          children: [
                            const Icon(
                              Icons.language,
                              size: 12,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              state.detailMovie.originalLanguage,
                              style: const TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          state.detailMovie.voteAverage.toString(),
                          style: const TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 95,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(16)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.play_arrow),
                              Text('Play'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 61, 56, 56),
                              borderRadius: BorderRadius.circular(25)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.download,
                                color: Colors.orange,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 61, 56, 56),
                              borderRadius: BorderRadius.circular(25)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.share,
                                color: Colors.lightBlue,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Overview',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.detailMovie.overview,
                          textAlign: TextAlign.justify,
                        )
                      ],
                    )
                  ],
                );
              } else {
                return const Center(
                  child: Text("Failed to load Detail Movie }"),
                );
              }
            },
          ),
        ),
      ),
    ));
  }
}
