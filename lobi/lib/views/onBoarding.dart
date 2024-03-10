import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lobby/pages/login_page.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

void onBoardingMade() async {
  final storage = FlutterSecureStorage();
  await storage.write(key: 'needOnboarding', value: '1');
}

class Onboard {
  final String image, title, desc;

  Onboard({required this.image, required this.title, required this.desc});
}

final List<Onboard> data = [
  Onboard(
      image: "lib/images/tennis.png",
      title: "Find the friend you've\nbeen looking for",
      desc: "sjdkqsj klqsjkdljqskl djqklsj dqklsjdklqsj dkljqskldj qksljkls"),
  Onboard(
      image: "lib/images/tennis.png",
      title: "Find the friend you've\nbeen looking for",
      desc: "sjdkqsj klqsjkdljqskl djqklsj dqklsjdklqsj dkljqskldj qksljkls"),
  Onboard(
      image: "lib/images/tennis.png",
      title: "Find the friend you've\nbeen looking for",
      desc: "sjdkqsj klqsjkdljqskl djqklsj dqklsjdklqsj dkljqskldj qksljkls")
];

class _OnboardingState extends State<Onboarding> {
  late PageController _pageController;
  int _pageIndex = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        backgroundColor: Color(0xffecf0f3),
        body: SafeArea(
          child: Column(

            children: [
              Padding(
                padding: const EdgeInsets.only(top:24.0,right: 24),
                child: Row(mainAxisAlignment: MainAxisAlignment.end,children: [Text("SKIP",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold ),)],),
              ),

              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemCount: data.length,
                  controller: _pageController,
                  itemBuilder: (context, index) => OnboardContent(
                    image: data[index].image,
                    title: data[index].title,
                    desc: data[index].desc,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    ...List.generate(
                        data.length,
                        (index) => Padding(
                              padding: EdgeInsets.only(right: 4.0),
                              child: DotIndicator(
                                isActive: index == _pageIndex,
                              ),
                            )),
                    Spacer(),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            backgroundColor: Colors.orangeAccent),
                        onPressed: () {
                          _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease);
                          if (_pageIndex == 2) {
                            onBoardingMade();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          }
                        },
                        child: Icon(Icons.swipe_right),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({Key? key, this.isActive = false}) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: isActive ? 12*1.5 : 4*1.5,
      width: 4*1.5,
      decoration: BoxDecoration(
          color: isActive
              ? Colors.orangeAccent
              : Colors.orangeAccent.withOpacity(0.4),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    Key? key,
    required this.image,
    required this.title,
    required this.desc,
  }) : super(key: key);
  final String image, desc, title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Image.asset(
          fit:BoxFit.fill,
          image,
        ),
        Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          desc,
          textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),

        ),
        Spacer(),
      ],
    );
  }
}
