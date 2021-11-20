import 'package:flutter/material.dart';
import 'package:portfolio_website/utils/theme_selector.dart';
import 'package:portfolio_website/utils/view_wrapper.dart';
import 'package:portfolio_website/widgets/bullet_list.dart';
import 'package:portfolio_website/widgets/navigation_arrow.dart';

class AboutView extends StatefulWidget {
  const AboutView({Key key}) : super(key: key);

  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView>
    with SingleTickerProviderStateMixin {
  double screenWidth;
  double screenHeight;
  String loremIpsum =
      'Benefícios da leitura:';

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return ViewWrapper(
      desktopView: desktopView(),
      mobileView: mobileView(),
    );
  }

  Widget desktopView() {
    return Stack(
      children: [
        NavigationArrow(isBackArrow: false),
        NavigationArrow(isBackArrow: true),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 1),
            Expanded(flex: 3, child: infoSection()),
            Spacer(flex: 1),
            Expanded(
                flex: 3,
                child: BulletList(
                  strings: [loremIpsum, loremIpsum, loremIpsum, loremIpsum],
                )),
            Spacer(flex: 1),
          ],
        )
      ],
    );
  }

  Widget mobileView() {
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.05),
        infoText(),
        SizedBox(height: screenHeight * 0.05),
        Container(
          height: screenHeight * 0.3,
          child: BulletList(
            strings: [loremIpsum, loremIpsum, loremIpsum, loremIpsum],
          ),
        ),
      ],
    );
  }

  Widget infoSection() {
    return Container(
      width: screenWidth * 0.35,
      child: Column(
        children: [
          profilePicture(),
          SizedBox(height: screenHeight * 0.05),
          infoText()
        ],
      ),
    );
  }

  Widget profilePicture() {
    return Container(
      height: getImageSize(),
      width: getImageSize(),
      /*child: ClipRRect(
          /*borderRadius: BorderRadius.circular(getImageSize() / 2),*/
          child: Container(
            color: Colors.grey,
            /*child: Center(child: Image.asset(asset/monteirolobato.jpg)),*/
          )),*/
    );
  }

  double getImageSize() {
    if (screenWidth > 1600 && screenHeight > 800) {
      return 350;
    } else if (screenWidth > 1300 && screenHeight > 600) {
      return 300;
    } else if (screenWidth > 1000 && screenHeight > 400) {
      return 200;
    } else {
      return 150;
    }
  }

  Widget infoText() {
    return Text(
      'A leitura é um hábito enriquecedor que traz uma série de benefícios e aprimora diversas habilidades do leitor, e uma delas é a criatividade. As histórias apresentadas nos livros exploram diferentes cenários. Dependendo do estilo do autor, os ambientes, personagens e objetos são descritos com riqueza de detalhes.Para entrar nesse outro universo, o leitor precisa criar as imagens e as cenas em sua mente e se conectar com a narrativa. Quanto mais produtiva for a sua imaginação, melhor será a experiência da leitura.',
      overflow: TextOverflow.clip,
      style: ThemeSelector.selectBodyText(context),
    );
  }
}
