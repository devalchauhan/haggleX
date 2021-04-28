import 'package:flutter/material.dart';
import 'package:hagglex/constants/color.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/constants/text_style.dart';
import 'package:hagglex/feature/dashboard/presantation/pages/dashboard_page.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      child: CircleAvatar(
                        radius: 23,
                        backgroundColor: kColorPrimary,
                        child: CircleAvatar(
                            radius: 20,
                            backgroundColor: kColorPink,
                            child: Text('SV')),
                      ),
                      radius: 25,
                      backgroundColor: kColorPink,
                    ),
                    Text(
                      'HaggleX',
                      style: kTextStyle,
                    ),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: kColorSecondary50,
                      child: Icon(
                        Icons.notifications,
                        color: kColorWhite,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, LOGIN_ROUTE);
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: kColorSecondary50,
                  child: Icon(
                    Icons.logout,
                    color: kColorWhite,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Total portfolio balance',
                style: kTextStyle.copyWith(fontSize: 10),
              )),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$****',
                style: kTextStyle.copyWith(fontSize: 30),
              ),
              Container(
                padding: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    color: kColorWhite,
                    border: Border.all(
                      color: kColorWhite,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: kColorTextGolden,
                          border: Border.all(
                            color: kColorTextGolden,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Text(
                        'USD',
                        style: kTextStyle.copyWith(
                            fontSize: 10.0, color: kColorBlack),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'NGN',
                        style: kTextStyle.copyWith(
                            fontSize: 10.0, color: kColorDarkGray),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TrandingNewsSection extends StatelessWidget {
  const TrandingNewsSection({
    Key key,
    @required this.news,
  }) : super(key: key);

  final List<News> news;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColorWhite,
      width: MediaQuery.of(context).size.width,
      height: 500,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text(
              'Trending crypto news',
              style: kTextStyle.copyWith(color: kColorBlack),
            ),
          ),
          Expanded(
            child: Container(
              color: kColorWhite,
              padding: EdgeInsets.all(10.0),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: news.length,
                itemBuilder: (context, index) {
                  News nws = news[index];
                  return NewsCell(
                    news: nws,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DoMoreSection extends StatelessWidget {
  const DoMoreSection({
    Key key,
    @required this.doMores,
  }) : super(key: key);

  final List<DoMore> doMores;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450.0,
      color: kColorWhite,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text(
              'Do more with HaggleX',
              style: kTextStyle.copyWith(color: kColorBlack),
            ),
          ),
          Expanded(
            child: Container(
              color: kColorWhite,
              padding: EdgeInsets.all(10.0),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: doMores.length,
                itemBuilder: (context, index) {
                  DoMore doMore = doMores[index];
                  return DoMoreCell(doMore: doMore);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MarketSection extends StatelessWidget {
  const MarketSection({
    Key key,
    @required this.coins,
  }) : super(key: key);

  final List<Coin> coins;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColorWhite,
      width: MediaQuery.of(context).size.width,
      height: 550,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text(
              'Markets',
              style: kTextStyle.copyWith(color: kColorBlack),
            ),
          ),
          Expanded(
            child: Container(
              color: kColorWhite,
              padding: EdgeInsets.all(10.0),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: coins.length,
                itemBuilder: (context, index) {
                  Coin coin = coins[index];
                  return CoinPriceCell(coin: coin);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CoinPriceCell extends StatelessWidget {
  const CoinPriceCell({
    Key key,
    @required this.coin,
  }) : super(key: key);

  final Coin coin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    child: Image.asset(coin.logo),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coin.name,
                        style: kTextStyleNormal.copyWith(fontSize: 15),
                      ),
                      Row(
                        children: [
                          Text(
                            coin.price,
                            style: kTextStyleNormal.copyWith(fontSize: 10.0),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            coin.difference,
                            style: kTextStyleNormal.copyWith(
                                fontSize: 10.0, color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: kColorGray,
              )
            ],
          ),
          Positioned(
            right: 20.0,
            child: Image.asset(
              coin.chart,
              height: 30.0,
            ),
          )
        ],
      ),
    );
  }
}

class DoMoreCell extends StatelessWidget {
  const DoMoreCell({
    Key key,
    @required this.doMore,
  }) : super(key: key);

  final DoMore doMore;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: kColorWhite,
          boxShadow: [
            BoxShadow(
              spreadRadius: 4,
              color: Colors.black12,
              offset: Offset(2, 2),
              blurRadius: 3,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25.0,
                child: Image.asset(doMore.logo),
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doMore.text,
                    style:
                        kTextStyle.copyWith(fontSize: 15, color: kColorBlack),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    doMore.subText,
                    style: kTextStyleNormal.copyWith(fontSize: 10.0),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NewsCell extends StatelessWidget {
  const NewsCell({
    Key key,
    @required this.news,
  }) : super(key: key);

  final News news;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 50.0,
            height: 60.0,
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                color: kColorTextGolden,
                border: Border.all(
                  color: kColorTextGolden,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news.text,
                  style: kTextStyleNormal.copyWith(fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      news.time,
                      style: kTextStyleNormal.copyWith(fontSize: 10.0),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      news.category,
                      style: kTextStyleNormal.copyWith(
                        fontSize: 10.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
