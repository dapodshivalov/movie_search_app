import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_app/api/model/movie.dart';
import 'package:movie_search_app/movie_full_info/movie_full_info_page.dart';
import 'package:movie_search_app/search_result/bloc/search_result_bloc.dart';
import 'package:movie_search_app/search_result/bloc/search_result_state.dart';
import 'package:movie_search_app/utils/string_utils.dart';

import 'bloc/search_result_event.dart';

class SearchResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final query = settings['query'];
    return BlocProvider(
      create: (context) => SearchResultBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('$query'),
        ),
        body: BlocConsumer<SearchResultBloc, SearchResultState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is Init) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                print(query);
                BlocProvider.of<SearchResultBloc>(context)
                    .add(GetByQuery(query));
              });
              return _buildLoading();
            }
            if (state is Loading) {
              return _buildLoading();
            }
            if (state is Result) {
              return _buildResultList(context, state.movies);
            }
            return _buildLoading();
          },
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildResultList(BuildContext context, List<Movie> movies) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return _buildListItem(context, movies[index]);
      },
    );
  }

  Widget _buildListItem(BuildContext context, Movie movie) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 16,
        child: InkWell(
          onTap: () {
            print("TAP on " + movie.title);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => MovieFullInfoPage(),
                settings: RouteSettings(
                  name: "full-info-page",
                  arguments: {"kpId": movie.kpId},
                ),
              ),
            );
          },
          child: Container(
            height: 200,
            // color: Colors.black.withOpacity(0.5),
            child: Row(
              children: [
                Container(
                  width: 150,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      topLeft: Radius.circular(8.0),
                    ),
                    child: Image.network(
                      movie.posterUrl,
                      fit: BoxFit.cover,
                      width: 150,
                    ),
                  ),
                ),
                Container(
                  width: 160,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 16, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          longTitleStringToShort(movie.title),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          movie.genres.join(", "),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'год выхода: ' + movie.year.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
