import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:universities/program/dbclass.dart';

class AllUniversities extends StatefulWidget {
  const AllUniversities({Key? key}) : super(key: key);

  @override
  State<AllUniversities> createState() => _AllUniversitiesState();
}

class _AllUniversitiesState extends State<AllUniversities> {
  String ccountry = 'India';
  List universities = [];
  List fid = [];

  fetchUniversity() async {
    final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=India'));
    if (response.statusCode == 200) {
      universities = jsonDecode(response.body);
      setState(() {
        universities;
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  fetchUniversityWithName(String country) async {
    final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$country'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  fetchfavouriteUniversitiesId() async {
    fid = [];
    List funiversities = await DBase.instance.getUnivesity();
    for (var element in funiversities) {
      fid.add(element['id']);
    }
    setState(() {
      fid;
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
                  universities[index]['name'],
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  universities[index]['web_pages'][0],
                  style: Theme.of(context).textTheme.labelSmall,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              if (fid.contains(index)) {
                DBase.instance.deleteUnivesity(index);
              } else {
                await DBase.instance.insertUnivesity(
                  index,
                  universities[index]['name'],
                  universities[index]['web_pages'][0],
                  ccountry,
                );
              }
              fetchfavouriteUniversitiesId();
            },
            icon: fid.contains(index)
                ? const Icon(
                    Icons.star_rounded,
                    size: 35,
                    color: Colors.amber,
                  )
                : const Icon(
                    Icons.star_outline_rounded,
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
    fetchUniversity();
    fetchfavouriteUniversitiesId();
  }

  @override
  Widget build(BuildContext context) {
    return universities.isNotEmpty
        ? ListView.builder(
            itemBuilder: (BuildContext context, int index) => universityWidget(index),
            itemCount: universities.length,
          )
        : Center(
            child: CircularProgressIndicator(color: Theme.of(context).iconTheme.color),
          );
  }
}
