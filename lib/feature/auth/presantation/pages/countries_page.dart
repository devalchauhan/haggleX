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

class CountriesPage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(URL);
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
    return GraphQLProvider(
      child: Scaffold(
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
                    child: Query(
                      options: QueryOptions(
                        document: gql(query),
                        pollInterval: Duration(seconds: 10),
                      ),
                      // Just like in apollo refetch() could be used to manually trigger a refetch
                      // while fetchMore() can be used for pagination purpose
                      builder: (QueryResult result,
                          {VoidCallback refetch, FetchMore fetchMore}) {
                        print(result);
                        if (result.hasException) {
                          return Text(result.exception.toString());
                        }
                        if (result.isLoading) {
                          return Text('Loading');
                        }
                        List repositories = result.data['getActiveCountries'];

                        return ListView.builder(
                            itemCount: repositories.length,
                            itemBuilder: (context, index) {
                              final repository = repositories[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.pop(
                                      context,
                                      Country(
                                        code: repository['callingCode'],
                                        flag: repository['flag'],
                                        name: repository['name'],
                                        currency: repository['currencyCode'],
                                      ));
                                },
                                child: ListTile(
                                  leading: Container(
                                    height: 30,
                                    width: 30,
                                    child: SvgPicture.network(
                                      repository['flag'],
                                      semanticsLabel: 'Country flag',
                                      /*placeholderBuilder: (BuildContext context) => Container(
                                    child: const CircularProgressIndicator()),*/
                                    ),
                                  ),
                                  title: Text(
                                    '(+${repository['callingCode']}) ${repository['name']}',
                                    style: kTextStyle.copyWith(fontSize: 15),
                                  ),
                                ),
                              );
                              return Text(repository['name']);
                            });
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      client: client,
    );
  }
}
