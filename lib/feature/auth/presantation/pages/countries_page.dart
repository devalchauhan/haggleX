import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/constants/color.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/constants/text_style.dart';
import 'package:hagglex/core/presentation/widget/background.dart';
import 'package:hagglex/feature/auth/data/model/country.dart';
import 'package:hagglex/feature/auth/presantation/pages/registartion_page.dart';
import 'package:hagglex/feature/auth/presantation/widgets/registration_widgets.dart';

class CountriesPage extends StatefulWidget {
  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  List<Country> countries = [];
  List<Country> countriesCopy = [];

  final String query = r"""
                    query GetContinent{
                      getActiveCountries{
                        name
                        flag
                        callingCode
                        currencyCode
                      }
                    }
                  """;

  final searchController = TextEditingController();

  onItemChanged(String value) {
    setState(() {
      countries = countriesCopy
          .where((country) =>
              country.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  Future<void> getCountries() async {
    const String readCountries = r'''
      query ReadCountries() {
         getActiveCountries{
            name
            flag
            callingCode
            currencyCode
         }
      }
''';

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: HttpLink(
        URL,
      ),
    );
    final QueryOptions options = QueryOptions(
      document: gql(readCountries),
      variables: <String, dynamic>{},
    );
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
    }

    print('========' + result.data.toString());

    var countriesObjsJson = result.data['getActiveCountries'] as List;

    List<Country> countriesFromQuery =
        countriesObjsJson.map((e) => Country.fromJson(e)).toList();

    setState(() {
      countries = countriesFromQuery;
      countriesCopy = countriesFromQuery;
    });
  }

  @override
  void initState() {
    super.initState();
    getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                SearchTextField(
                  onTextChange: onItemChanged,
                  controller: searchController,
                  hintText: 'Search for country',
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  height: 2,
                  width: MediaQuery.of(context).size.width,
                  color: kColorWhite20,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: countries.length,
                      itemBuilder: (context, index) {
                        Country country = countries[index];
                        return InkWell(
                          onTap: () {
                            Navigator.pop(context, country);
                          },
                          child: ListTile(
                            leading: Container(
                              height: 30,
                              width: 30,
                              child: SvgPicture.network(
                                country.flag,
                                semanticsLabel: 'Country flag',
                                /*placeholderBuilder: (BuildContext context) => Container(
                                  child: const CircularProgressIndicator()),*/
                              ),
                            ),
                            title: Text(
                              '(+${country.code}) ${country.name}',
                              style: kTextStyle.copyWith(fontSize: 15),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
