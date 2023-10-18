import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String index;
  final String userName;
  final String cell;
  final String imageUrl;
  final bool isLiked;
  final VoidCallback onFavClicked;
  final VoidCallback onNavToUserDetailPage;
  final VoidCallback openDialogBox;

  const UserCard({super.key,
    required this.index,
    required this.userName,
    required this.cell,
    required this.imageUrl,
    required this.onFavClicked,
    required this.onNavToUserDetailPage,
    required this.isLiked,
    required this.openDialogBox});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                SizedBox(
                    width: 40,
                    child: Text(
                      index,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  maxRadius: 30,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          userName,
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          cell,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap:openDialogBox,
                child: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.green,
                ),
              ),
              GestureDetector(
                  onTap: onFavClicked,
                  child: isLiked
                      ? Icon(
                    Icons.favorite,
                    size: 24,
                    color: Colors.redAccent,
                  )
                      : Icon(
                    Icons.favorite_outline,
                    size: 24,
                    color: Colors.black54,
                  )),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: onNavToUserDetailPage,
                child: const Icon(
                  Icons.navigate_next_sharp,
                  color: Colors.black38,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
