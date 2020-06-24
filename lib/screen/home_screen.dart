import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import '../style/app_color.dart';
import '../widget/app_text_field.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: screenSize.height,
              width: screenSize.width,
              color: AppColor.wihte,
            ),
            Container(
              height: screenSize.height * 0.3,
              color: AppColor.background,
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: <Widget>[
                    topAppbar(),
                    SizedBox(height: 24),
                    slider(),
                    SizedBox(height: 14),
                    buttonShop(),
                    SizedBox(height: 23),
                    mostPopular(),
                    SizedBox(height: 23),
                    dailyDiscover()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget topAppbar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: AppTextField(
              hintText: 'Search product...',
              icon: Icon(Icons.search),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart),
          color: Colors.white,
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.perm_identity),
          color: Colors.white,
          onPressed: () {},
        )
      ],
    );
  }

  Widget slider() {
    return SizedBox(
        height: 200.0,
        width: 350.0,
        child: Carousel(
          images: [
            ExactAssetImage("assets/images/banner.png"),
            ExactAssetImage("assets/images/banner.png"),
            ExactAssetImage("assets/images/banner.png"),
            ExactAssetImage("assets/images/banner.png"),
            ExactAssetImage("assets/images/banner.png"),
            ExactAssetImage("assets/images/banner.png"),
          ],
          dotSize: 4.0,
          dotSpacing: 15.0,
          dotColor: Colors.white,
          indicatorBgPadding: 30.0,
          dotBgColor: Colors.white.withOpacity(0),
          borderRadius: true,
          dotIncreasedColor: Colors.red,
        ));
  }

  Widget buttonShop() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      circleButton(
        text: 'Clothes',
        icon: Icons.streetview,
        onTap: () {},
      ),
      circleButton(
        text: 'Beauty',
        icon: Icons.wc,
        onTap: () {},
      ),
      circleButton(
        text: 'Shoes',
        icon: Icons.slow_motion_video,
        onTap: () {},
      ),
      circleButton(
        text: 'Electronics',
        icon: Icons.store,
        onTap: () {},
      ),
      circleButton(
        text: 'Furniture',
        icon: Icons.shopping_basket,
        onTap: () {},
      )
    ]);
  }

  Widget mostPopular() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Most Popular',
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 23,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 6,
                      height: 70,
                      color: Colors.red,
                    ),
                    Image.asset(
                      'assets/images/most_popular_1.png',
                      height: 70,
                    ),
                    Positioned(
                      child: Text(
                        'Portable\nCar Seat',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      top: 20,
                      left: 20,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 6,
                      height: 70,
                      color: Colors.blue,
                    ),
                    Image.asset(
                      'assets/images/most_popular_2.png',
                      height: 70,
                    ),
                    Positioned(
                      child: Text(
                        'Himawari',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      top: 20,
                      left: 20,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 6,
                      height: 70,
                      color: Colors.purple,
                    ),
                    Image.asset(
                      'assets/images/most_popular_3.png',
                      height: 70,
                    ),
                    Positioned(
                      child: Text(
                        'J-COMFY UNISEX',
                        style: TextStyle(fontSize: 9),
                      ),
                      top: 20,
                      left: 15,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 6,
                      height: 70,
                      color: Colors.green,
                    ),
                    Image.asset(
                      'assets/images/most_popular_4.png',
                      height: 70,
                    ),
                    Positioned(
                      child: Text(
                        'RAHSIA',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      top: 15,
                      left: 15,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget dailyDiscover() {
    return Column(
      children: <Widget>[
        Text(
          'Daily Discover',
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 23),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/product_1.png',
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Florol Dress',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      'RM49.99',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/product_2.png',
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Pattern Dress',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      'RM20.58',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/product_3.png',
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Cotton Dress',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      'RM11.00',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget circleButton({String text, GestureTapCallback onTap, IconData icon}) {
    double size = 50.0;
    return Column(
      children: <Widget>[
        InkResponse(
          onTap: onTap,
          child: new Container(
            width: size,
            height: size,
            decoration: new BoxDecoration(
              color: AppColor.background,
              shape: BoxShape.circle,
            ),
            child: new Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 10,
          ),
        )
      ],
    );
  }
}
