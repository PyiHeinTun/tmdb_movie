import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tmdb_movie/blocs/home_bloc.dart';
import 'package:flutter_tmdb_movie/domain/entity/genere.dart';
import 'package:flutter_tmdb_movie/domain/entity/movie.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/loading_indicator.dart';
import 'package:flutter_tmdb_movie/utlity/no_glow.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/movie_card.dart';

class GetMovieFromGenere extends StatefulWidget {
  const GetMovieFromGenere({Key? key}) : super(key: key);

  @override
  State<GetMovieFromGenere> createState() => _GetMovieFromGenereState();
}

class _GetMovieFromGenereState extends State<GetMovieFromGenere>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Genere List
        Selector<HomeBloc, List<Genere>?>(
          selector: (context, bloc) => bloc.genereList,
          builder: (context, state, child) {
            if (state != null) {
              _controller = TabController(
                length: state.length,
                vsync: this,
              );
              return Theme(
                data: ThemeData().copyWith(splashColor: Colors.transparent),
                child: TabBar(
                  indicatorColor: Theme.of(context).colorScheme.secondary,
                  indicatorPadding: EdgeInsets.only(left: 10.w),
                  labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
                  isScrollable: true,
                  unselectedLabelColor: Colors.grey.shade600,
                  controller: _controller,
                  tabs: List.generate(
                    state.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(
                        left: 10.w,
                      ),
                      child: Tab(
                        text: state[index].name,
                      ),
                    ),
                  ),
                  onTap: (value) {
                    Provider.of<HomeBloc>(context, listen: false)
                        .getMoviesByTapping(genereId: value);
                  },
                ),
              );
            }
            return const LoadingIndicator();
          },
        ),

        //Movie List By Genere
        Container(
            height: 270.h,
            color: Theme.of(context).colorScheme.background,
            child: Selector<HomeBloc, List<Movie>?>(
              selector: (context, bloc) => bloc.moviesByGenere,
              builder: (context, state, child) {
                if (state != null) {
                  return NoGLow(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 20.w,
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: i == 0 ? 20.w : 0,
                            right: i + 1 == state.length ? 20.w : 0,
                            top: 0.h,
                            bottom: 0.h,
                          ),
                          child: MovieCard(
                            movie: state[i],
                          ),
                        );
                      },
                      itemCount: state.length,
                    ),
                  );
                }
                return const LoadingIndicator();
              },
            )),
      ],
    );
  }
}
