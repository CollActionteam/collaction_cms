import 'package:collaction_cms/presentation/crowdactions/crowdaction_form/sections/commitments_section/assign_commitments/commitment_template/commitment_template_widgets/dummy_data.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<DummyModel> itemList = dummyData;
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var tag in itemList) {
      if (tag.tags.toString().toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(tag.tags.toString());
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var tag in itemList) {
      if (tag.tags.toString().toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(tag.tags.toString());
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }
}
