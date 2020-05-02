import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:knee_kinematic_monitor/ui/monitor/status_info.dart';

class MonitorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
            title: AutoSizeText(
              "Monitor de Parametros Cinemáticos",
              maxLines: 1,
            ),
            bottom: TabBar(
              isScrollable: true,
              tabs: choices.map((Choice choice) {
                return Tab(
                  text: choice.title,
                  icon: Icon(choice.icon),
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: choices.map((Choice choice) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: ChoiceCard(choice: choice),
              );
            }).toList(),
          ),
          
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon, this.about, this.content});

  final String title;
  final IconData icon;
  final String about;
  final Widget content;
}

const List<Choice> choices = const <Choice>[
  const Choice(
    title: 'INFO',
    icon: Icons.info_outline,
    about: "Informações sobre permissões e dispositivos",
    content: StatusInfo(),
  ),
  const Choice(
    title: 'JOELHO',
    icon: Icons.directions_walk,
    about: "Parametros cinemáticos do jolho",
    content: Placeholder(
      color: Colors.green,
    ),
  ),
  const Choice(
    title: 'DADOS',
    icon: Icons.storage,
    about: "Dados puros sendo recebidos do dispositivo",
    content: Placeholder(
      color: Colors.blue,
    ),
  ),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).primaryTextTheme.subtitle;
    return Card(
      color: Color.fromRGBO(58, 66, 86, 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              AutoSizeText(choice.about, style: textStyle),
              Spacer(),
              Icon(choice.icon, size: 30.0, color: Colors.white),
            ],
          ),
          choice.content,
        ],
      ),
    );
  }
}
