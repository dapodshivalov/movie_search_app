import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_app/api/model/movie_full.dart';
import 'package:movie_search_app/api/model/person.dart';
import 'package:movie_search_app/movie_full_info/bloc/movie_full_info_bloc.dart';
import 'package:movie_search_app/movie_full_info/bloc/movie_full_info_event.dart';
import 'package:movie_search_app/movie_full_info/bloc/movie_full_info_state.dart';
import 'package:movie_search_app/utils/string_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieFullInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final kpId = settings['kpId'];
    return BlocProvider(
      create: (context) => MovieFullInfoBloc(),
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("Result"),
        // ),
        body: BlocConsumer<MovieFullInfoBloc, MovieFullInfoState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is Init) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                print("Getting fill info of movie");
                print(kpId);
                BlocProvider.of<MovieFullInfoBloc>(context)
                    .add(GetByKpId(kpId));
              });
              return _buildLoading();
            }
            if (state is Loading) {
              return _buildLoading();
            }
            if (state is Result) {
              // return _buildMovieView(state.movie);
              return _buildMovieViewWithAppBar(context, state);
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

  Widget _buildMovieView(MovieFull movieFull) {
    return ListView(
      children: [
        Image.network(movieFull.posterUrl),
        Text(movieFull.title),
        Text(movieFull.year.toString()),
        Text(movieFull.rating.toString()),
        Text(movieFull.url),
        Text(movieFull.genres.join(", ")),
        Text(movieFull.description),
      ],
    );
  }

  Widget _buildMovieViewWithAppBar(BuildContext context, Result state) {
    List<Widget> content = [
      // _buildInfoCard("", toQuotation(movieFull.slogan)),
      _buildLinkToKP(state.movie.url),
      _buildQuotation(state.movie.slogan),
      _buildInfoCard("Обзор", state.movie.description),
      _buildDividerLine(),
      _buildOneLineInfo("Страны", state.movie.countries.join(", ")),
      _buildDividerLine(),
      _buildOneLineInfo("Год производства", state.movie.year.toString()),
      _buildDividerLine(),
      _buildOneLineInfo("Время", state.movie.filmLength),
    ];

    if (state is ResultWithStaff) {
      content.add(_buildDividerLine());
      content.add(_buildInfoCard(
          "Режиссер", state.directors.map((e) => e.nameRu).join(", ")));
      content.add(_buildDividerLine());
      content.add(_buildListOfStaff(state.actors));
    }

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 600.0,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              // print('constraints=' + constraints.toString());
              var top = constraints.biggest.height;
              return FlexibleSpaceBar(
                // centerTitle: true,
                titlePadding: top <= 100
                    ? EdgeInsetsDirectional.only(start: 72, bottom: 16)
                    : EdgeInsetsDirectional.only(
                        start: 16, bottom: 16, end: 16),
                title: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  // opacity: top == 80.0 ? 0.0 : 1.0,
                  opacity: 1.0,
                  child: _buildTitle(state.movie, top),
                ),
                // title: _buildTitle(movieFull, top),
                background: ShaderMask(
                  child: Image.network(
                    state.movie.posterUrl,
                    fit: BoxFit.cover,
                  ),
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [Colors.white, Colors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },
                ),
              );
            },
          ),
        ),
        SliverList(delegate: SliverChildListDelegate(content))
      ],
    );
  }

  Widget _buildTitle(MovieFull movieFull, double top) {
    if (top <= 120.0) {
      return Text(
        longTitleStringToShort(movieFull.title),
        style: TextStyle(fontSize: 18.0),
      );
    }
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movieFull.title,
                      style: TextStyle(fontSize: 14.0),
                      maxLines: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          movieFull.filmLength,
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.white54,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          movieFull.year.toString(),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      movieFull.genres.join(', '),
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    movieFull.rating.toString(),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 12,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuotation(String text) {
    if (text == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(
          top: 16.0, bottom: 8.0, left: 16.0, right: 16.0),
      child: Container(
        child: Center(
          child: Text(
            toQuotation(text),
            maxLines: 10,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOneLineInfo(String label, String data) {
    if (data == null) {
      return Container();
    }
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: 200,
              alignment: Alignment.centerRight,
              child: Text(
                data,
                maxLines: 3,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDividerLine() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Divider(),
    );
  }

  Widget _buildInfoCard(String label, String data) {
    if (data == null) {
      return Container();
    }
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              data,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkToKP(String url) {
    if (url == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Center(
        child: Container(
          width: 200,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 255, 102, 0),
            ),
            onPressed: () {
              print("TAP");
              print(url);
              _launchURL(url);
            },
            child: Container(
              child: Text("Смотреть на Kinopoisk"),
            ),
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    // if (await canLaunch(url)) {
    await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  _buildListOfStaff(List<Person> staffs) {
    return Container(
      height: 250,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: staffs.length,
          itemBuilder: (context, index) {
            return _buildPersonCard(staffs[index]);
          }),
    );
  }

  _buildPersonCard(Person person) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 80,
        child: Column(
          children: [
            Container(
              width: 80,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  person.posterUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Text(
                person.nameRu,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              person.description,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
