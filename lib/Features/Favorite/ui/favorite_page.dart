import 'package:bloc_api_project/Features/Favorite/bloc/favorite_bloc.dart';
import 'package:bloc_api_project/Widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  final FavoriteBloc favBloc = FavoriteBloc();

  @override
  void initState() {
    favBloc.add(FavoriteInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Favorites'),),
        body: BlocConsumer<FavoriteBloc, FavoriteState>(
          bloc: favBloc,
          listenWhen:(previous, current) => current is FavoriteActionState ,
          buildWhen: (previous, current) =>current is !FavoriteActionState ,
          listener: (context, state) {
          },
          builder: (context, state) {
            switch(state.runtimeType){
              case FavoriteInitial:
               const Center(child: CircularProgressIndicator.adaptive(),);
                break;
              case FavoriteSuccessState:
                final successState = state as FavoriteSuccessState;
                return ListView.builder(
                  itemCount: successState.favoriteListData.length,
                    itemBuilder: (context,index){
                    var data=successState.favoriteListData[index];
                      return UserCard(
                          index: (index+1).toString(),
                          isLiked: true,
                          userName: ' ${data.name.first} ${data.name.last}',
                          cell: data.cell,
                          imageUrl: data.picture.thumbnail,
                          onFavClicked: (){
                            favBloc.add(RemoveFromFavoriteEvent(
                              userData: data
                            ));
                            Navigator.pop(context, true);
                          },
                          onNavToUserDetailPage: (){
                             // true indicates that data was updated
                          },
                        openDialogBox: (){},
                      );
                    });
              default:
            }
            return const SizedBox();

          },
        )
    );
  }
}