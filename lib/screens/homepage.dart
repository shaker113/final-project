import 'package:fina/screens/water_reminder.dart';
import 'package:fina/widgets/widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../data/data.dart';
import '../models/models.dart';
import 'screens.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var fireMessging = FirebaseMessaging.instance;

  get theCollectionReference => null;
  intialMessage() async {
    var message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      return AlertDialog(
        content: Text("welcome"),
      );
      // it is work when the app closed
    }
  }

  @override
  void initState() {
    userId = authInstance.currentUser?.uid;
    checkRole();
    getAccountInfo();
    calculateUsercal() {
      setState(() {
        DailyNeedsCalcState().plussMethod(
            double.parse(userWeight!.toString()),
            double.parse(userHeight!.toString()),
            true,
            userGoalIndex);
        BodyFatCalcState().testmethod(
            double.parse(userWeight!.toString()),
            double.parse(userHeight!.toString()),
            userGender!,
            userAge!,
            true);
      });
    }

    intialMessage();

    fireMessging.getToken().then((value) {
      // print("@@@@@@@@@@@@@@@@@@@");
      // print(value);
      // print("@@@@@@@@@@@@@@@@@@@@@");

      //  to print the token
      // the message will not show on forground, it will appear on background
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Water_Reminder();
        },
      ));
    });
    FirebaseMessaging.onMessage.listen((event) {
      // print("====================================");
      // print("${event.notification}");
      // print("====================================");

      // to send notification on forground.
    });

    print(isAdmin);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeigth = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgrounColor,
        actions: [
          isAdmin ?? false ? const AddButton() : const SizedBox(),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "water reminder");
            },
            icon: const Icon(Icons.water_drop_outlined),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "cartpage");
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Water_Reminder();
                  },
                ));
              },
              icon: Icon(Icons.water_drop_outlined))
        ],
      ),
      drawer: const Drawer(
        child: MyDrawer(),
      ),
      // appBar: AppBar(elevation: 0, backgroundColor: Color(0xFF21BFBD)),
      backgroundColor: backgrounColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Categories",
              style: TextStyle(
                  fontSize: 25,
                  height: 2,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            addVerticalSpace(20),
            SingleChildScrollView(
              child: Container(
                  height: screenHeigth! - 155,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(45),
                      topLeft: Radius.circular(45),
                    ),
                  ),
                  child: CarouselSlider.builder(
                      options: CarouselOptions(
                          disableCenter: true,
                          viewportFraction: 0.4,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.vertical),
                      itemCount: categories.length,
                      itemBuilder: ((context, index, realIndex) {
                        var myCateory = categories[index];
                        return CategoryBox(
                            imagURL: myCateory.imagURL,
                            title: myCateory.title,
                            subtitle: myCateory.subtitle,
                            theCollectionReference:
                                myCateory.theCollectionReference);
                      }))
                  // myGridView(),
                  ),
            ),
          ]),
    );
  }

  // Widget myGridView() => GridView.builder(
  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //       ),
  //       padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
  //       itemCount: categories.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         var myCateory = categories[index];
  //         return CategoryBox(
  //             imagURL: myCateory.imagURL,
  //             title: myCateory.title,
  //             subtitle: myCateory.subtitle,
  //             theCollectionReference: myCateory.theCollectionReference);
  //       },
  //     );
}
