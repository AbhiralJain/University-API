import 'package:flutter/material.dart';
import 'package:universities/program/dbclass.dart';

class FavouriteUniversitiies extends StatefulWidget {
  const FavouriteUniversitiies({Key? key}) : super(key: key);

  @override
  State<FavouriteUniversitiies> createState() => _FavouriteUniversitiiesState();
}

class _FavouriteUniversitiiesState extends State<FavouriteUniversitiies> {
  List favouriteuniversities = [];
  fetchfavouriteUniversities() async {
    favouriteuniversities = await DBase.instance.getUnivesity();
    setState(() {
      favouriteuniversities;
    });
  }

  universityWidget(int index) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  favouriteuniversities[index]['name'],
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  favouriteuniversities[index]['webpage'],
                  style: Theme.of(context).textTheme.labelSmall,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              DBase.instance.deleteUnivesity(favouriteuniversities[index]['id']);
              fetchfavouriteUniversities();
            },
            icon: const Icon(
              Icons.star_rounded,
              size: 35,
              color: Colors.amber,
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchfavouriteUniversities();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => universityWidget(index),
      itemCount: favouriteuniversities.length,
    );
  }
}
