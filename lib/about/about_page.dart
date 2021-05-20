import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  double sizeOfIcon = 30;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("О проекте"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Мобильное приложение для экспресс кино-рекомендаций",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "2021",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Приложение позволяет найти фильм, если вы забыли его название, но помните, например, сюжетный твист",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                        "Приложение выполнено в качестве выпуской квалификационной работы бакалавриата Программной Инженерии Факультета Компьютерных Наук НИУ ВШЭ. В работе использованы данные с сайта ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "Кинопоиск",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            final url = 'https://www.kinopoisk.ru/';
                            // if (await canLaunch(url)) {
                            await launch(
                              url,
                              forceSafariVC: false,
                            );
                            // }
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                ),
                child: SvgPicture.asset(
                  'assets/icons/student.svg',
                  // color: Colors.black,
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  "Дмитрий Подшивалов",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "podshivalov.d.a@gmail.com",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            final url =
                                'mailto:podshivalov.d.a@gmail.com?subject=Movie&Search&App';
                            // if (await canLaunch(url)) {
                            await launch(
                              url,
                              forceSafariVC: false,
                            );
                            // }
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: Container(
                        height: sizeOfIcon,
                        width: sizeOfIcon,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/github.svg',
                          color: Colors.black,
                        ),
                      ),
                      onTap: () async {
                        await launch(
                          'https://github.com/dapodshivalov',
                          forceSafariVC: false,
                        );
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: sizeOfIcon,
                        width: sizeOfIcon,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/telegram.svg',
                          // color: Colors.black,
                        ),
                      ),
                      onTap: () async {
                        await launch(
                          'https://t.me/lovemacarony',
                          forceSafariVC: false,
                        );
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: sizeOfIcon,
                        width: sizeOfIcon,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/vk.svg',
                          // color: Colors.black,
                        ),
                      ),
                      onTap: () async {
                        await launch(
                          'https://vk.com/lovemacarony',
                          forceSafariVC: false,
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
