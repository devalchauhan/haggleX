import 'package:flutter/material.dart';
import 'package:hagglex/constants/color.dart';
import 'package:hagglex/feature/dashboard/presantation/widgets/dashboard_widgets.dart';

class Coin {
  final String logo;
  final String name;
  final String price;
  final String difference;
  final String chart;

  Coin({this.logo, this.name, this.price, this.difference, this.chart});
}

class DoMore {
  final String logo;
  final String text;
  final String subText;

  DoMore({this.logo, this.text, this.subText});
}

class News {
  final String logo;
  final String text;
  final String time;
  final String category;

  News({this.logo, this.text, this.time, this.category});
}

class DashboardPage extends StatelessWidget {
  List<Coin> coins = [
    Coin(
        logo: 'assets/images/coin1.png',
        name: 'Haggle (HAG)',
        price: 'NGN 380',
        difference: '',
        chart: 'assets/images/chart1.png'),
    Coin(
        logo: 'assets/images/coin2.png',
        name: 'Bitcoin (BTC)',
        price: 'NGN 4,272,147.00',
        difference: '+2.34%',
        chart: 'assets/images/chart2.png'),
    Coin(
        logo: 'assets/images/coin1.png',
        name: 'Ethereum (ETH)',
        price: 'NGN 4,272,147.00',
        difference: '+2.34%',
        chart: 'assets/images/chart3.png'),
    Coin(
        logo: 'assets/images/coin2.png',
        name: 'Tether (USDT)',
        price: 'NGN 4,272,147.00',
        difference: '+2.34%',
        chart: 'assets/images/chart4.png'),
    Coin(
        logo: 'assets/images/coin1.png',
        name: 'Bitcoin Cash (BCH)',
        price: 'NGN 4,272,147.00',
        difference: '+2.34%',
        chart: 'assets/images/chart5.png'),
    Coin(
        logo: 'assets/images/coin2.png',
        name: 'Dash (DASH)',
        price: 'NGN 4,272,147.00',
        difference: '+2.34%',
        chart: 'assets/images/chart6.png'),
    Coin(
        logo: 'assets/images/coin1.png',
        name: 'Dodgecoin (DOGE)',
        price: 'NGN 4,272,147.00',
        difference: '+2.34%',
        chart: 'assets/images/chart7.png'),
    Coin(
        logo: 'assets/images/coin2.png',
        name: 'Litecoin (LTC)',
        price: 'NGN 4,272,147.00',
        difference: '+2.34%',
        chart: 'assets/images/chart8.png'),
  ];

  List<DoMore> doMores = [
    DoMore(
        logo: 'assets/images/send.png',
        text: 'Send money instantly',
        subText: 'Send crypto to another wallet'),
    DoMore(
        logo: 'assets/images/receive.png',
        text: 'Receive money from anyone',
        subText: 'Receive crypto from another wallet'),
    DoMore(
        logo: 'assets/images/send.png',
        text: 'Virtual Card',
        subText: 'Make faster payments using HaggleX cards'),
    DoMore(
        logo: 'assets/images/receive.png',
        text: 'Global Remittance',
        subText: 'Send money to anyone, anywhere'),
  ];

  List<News> news = [
    News(
        logo: 'assets/images/hagglex_logo.png',
        text:
            'Blockchain Bites: BTC on Ethereum, DeFi’s latest stablecoin, the currency cold wars',
        time: '6hrs ago',
        category: 'Category: DeFi'),
    News(
        logo: 'assets/images/hagglex_logo.png',
        text:
            'Blockchain Bites: BTC on Ethereum, DeFi’s latest stablecoin, the currency cold wars',
        time: '6hrs ago',
        category: 'Category: DeFi'),
    News(
        logo: 'assets/images/hagglex_logo.png',
        text:
            'Blockchain Bites: BTC on Ethereum, DeFi’s latest stablecoin, the currency cold wars',
        time: '6hrs ago',
        category: 'Category: DeFi'),
    News(
        logo: 'assets/images/hagglex_logo.png',
        text:
            'Blockchain Bites: BTC on Ethereum, DeFi’s latest stablecoin, the currency cold wars',
        time: '6hrs ago',
        category: 'Category: DeFi'),
    News(
        logo: 'assets/images/hagglex_logo.png',
        text:
            'Blockchain Bites: BTC on Ethereum, DeFi’s latest stablecoin, the currency cold wars',
        time: '6hrs ago',
        category: 'Category: DeFi'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ListView(
          children: [
            Header(),
            Container(
              color: kColorGray,
              child: _buildCarousel(context, 4),
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            MarketSection(coins: coins),
            DoMoreSection(doMores: doMores),
            TrandingNewsSection(news: news),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel(BuildContext context, int carouselIndex) {
    return SizedBox(
      // you may want to use an aspect ratio here for tablet support
      height: 130.0,
      child: PageView.builder(
        // store this controller in a State to save the carousel scroll position
        itemCount: carouselIndex,
        controller: PageController(viewportFraction: 0.9),
        itemBuilder: (BuildContext context, int itemIndex) {
          return _buildCarouselItem(context, carouselIndex, itemIndex);
        },
      ),
    );
  }

  Widget _buildCarouselItem(
      BuildContext context, int carouselIndex, int itemIndex) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Image.asset('assets/images/banner${itemIndex + 1}.png'),
      ),
    );
  }
}
