import 'dart:async';
import 'package:flutter/material.dart';
import 'package:valorant_stats/Database.dart';
import 'package:valorant_stats/MapStats.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valorant Stats',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Stack(
      children: <Widget>[
      Opacity(
      opacity: 0.5,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/home_valorant_background_noText.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ),
        Center(
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'ValorantStats',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "ValorantFont", fontSize: 30,
                        color: Color(0xFFFFFFFF), decoration: TextDecoration.none),
                  ),
                  FlatButton(
                    color: Color.fromRGBO(225, 70, 84, 1),
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    splashColor: Colors.redAccent,
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapsStatsScreen(mapsStats: SQLiteDbProvider.db.getAllMapsStats())),
                      );
                    },
                    child: Text(
                      "Maps Stats",
                      style: TextStyle(fontFamily: "ValorantFont", fontSize: 10,
                          color: Color(0xFFFFFFFF), decoration: TextDecoration.none),
                    ),
                  ),
                ],
              ),
          ),
      ],
    );
  }
}

class MapsStatsScreen extends StatelessWidget {
  final Future<List<MapStats>> mapsStats;
  MapsStatsScreen({Key key, this.mapsStats}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.5,
          child: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/home_valorant_background_noText.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Center(
          child: FutureBuilder<List<MapStats>>(
            future: mapsStats,
            builder: (context, snapshot){
              if(snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ?
              Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(15.0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index){
                    return index < snapshot.data.length - 1 ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FlatButton(
                          padding: EdgeInsets.all(8),
                          child: Stack(
                            children: <Widget>[
                              Image.asset(snapshot.data[index].pictureUri),
                              Center(
                                child: Text(
                                  snapshot.data[index].name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontFamily: "ValorantFont", fontSize: 40,
                                      color: Color.fromRGBO(225, 70, 84, 1), decoration: TextDecoration.none,
                                      height: 3),
                                ),
                              ),
                            ],
                          ),
                          splashColor: Colors.redAccent,
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    MapStatsDetails(details: SQLiteDbProvider.db.getMapStatsById(snapshot.data[index].id)
                                    )
                                )
                            );
                          },
                        ),
                      ],
                    )
                        :
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FlatButton(
                          padding: EdgeInsets.all(8),
                          child: Stack(
                            children: <Widget>[
                              Image.asset(snapshot.data[index].pictureUri),
                              Center(
                                child: Text(
                                  snapshot.data[index].name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontFamily: "ValorantFont", fontSize: 40,
                                      color: Color.fromRGBO(225, 70, 84, 1), decoration: TextDecoration.none,
                                      height: 3),
                                ),
                              ),
                            ],
                          ),
                          splashColor: Colors.redAccent,
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    MapStatsDetails(details: SQLiteDbProvider.db.getMapStatsById(snapshot.data[index].id)
                                    )
                                )
                            );
                          },
                        ),
                        FlatButton(
                          color: Color.fromRGBO(225, 70, 84, 1),
                          textColor: Colors.white,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.redAccent,
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  MyHomePage()
                              )
                            );
                          },
                          child: Text(
                            "Back",
                            style: TextStyle(fontFamily: "ValorantFont", fontSize: 10,
                                color: Color(0xFFFFFFFF), decoration: TextDecoration.none),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
                  :
              CircularProgressIndicator();
            }
          ),
        ),
      ],
    );
  }
}

class MapStatsDetails extends StatelessWidget {
  final Future<MapStats> details;
  MapStatsDetails({Key key,this.details}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MapStats>(
      future: details,
      builder: (context, snapshot){
        if(snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ?
        Scaffold(
          body: Stack(
            children: <Widget>[
              Opacity(
                opacity: 1,
                child: Scaffold(
                  body: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(snapshot.data.backgroundDetailsUri),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(15.0),
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        snapshot.data.name+" Stats",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "ValorantFont",
                            fontSize: 40,
                            color: Color.fromRGBO(225, 70, 84, 1),
                            decoration: TextDecoration.none,
                            height: 2
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Attackers Round Wins: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "ValorantFont",
                                  fontSize: 20,
                                  color: Color.fromRGBO(225, 70, 84, 1),
                                  decoration: TextDecoration.none
                              ),
                            ),
                            Text(
                              snapshot.data.attackersRoundWins.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "ValorantFont",
                                  fontSize: 20,
                                  color: Colors.black,
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Defenders Round Wins: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "ValorantFont",
                                  fontSize: 20,
                                  color: Color.fromRGBO(225, 70, 84, 1),
                                  decoration: TextDecoration.none
                              ),
                            ),
                            Text(
                              snapshot.data.defendersRoundWins.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "ValorantFont",
                                  fontSize: 20,
                                  color: Colors.black,
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Spikes Planted: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "ValorantFont",
                                  fontSize: 20,
                                  color: Color.fromRGBO(225, 70, 84, 1),
                                  decoration: TextDecoration.none
                              ),
                            ),
                            Text(
                              snapshot.data.spikesPlanted.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "ValorantFont",
                                  fontSize: 20,
                                  color: Colors.black,
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Spikes Defused: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "ValorantFont",
                                  fontSize: 20,
                                  color: Color.fromRGBO(225, 70, 84, 1),
                                  decoration: TextDecoration.none
                              ),
                            ),
                            Text(
                              snapshot.data.spikesDefused.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "ValorantFont",
                                  fontSize: 20,
                                  color: Colors.black,
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Spikes Detonated: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "ValorantFont",
                                  fontSize: 20,
                                  color: Color.fromRGBO(225, 70, 84, 1),
                                  decoration: TextDecoration.none
                              ),
                            ),
                            Text(
                              snapshot.data.spikesDetonated.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "ValorantFont",
                                  fontSize: 20,
                                  color: Colors.black,
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "First Bloods: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "ValorantFont",
                                  fontSize: 20,
                                  color: Color.fromRGBO(225, 70, 84, 1),
                                  decoration: TextDecoration.none
                              ),
                            ),
                            Text(
                              snapshot.data.firstBloods.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "ValorantFont",
                                  fontSize: 20,
                                  color: Colors.black,
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "First Blood Wins: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "ValorantFont",
                                  fontSize: 20,
                                  color: Color.fromRGBO(225, 70, 84, 1),
                                  decoration: TextDecoration.none
                              ),
                            ),
                            Text(
                              snapshot.data.firstBloodWins.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "ValorantFont",
                                  fontSize: 20,
                                  color: Colors.black,
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Elimination Wins: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "ValorantFont",
                                  fontSize: 20,
                                  color: Color.fromRGBO(225, 70, 84, 1),
                                  decoration: TextDecoration.none
                              ),
                            ),
                            Text(
                              snapshot.data.eliminationWins.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "ValorantFont",
                                  fontSize: 20,
                                  color: Colors.black,
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                heightFactor: 13,
                alignment: Alignment.bottomLeft,
                child: FlatButton(
                  color: Color.fromRGBO(225, 70, 84, 1),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.redAccent,
                  onPressed: (){
//                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          MapsStatsScreen(mapsStats: SQLiteDbProvider.db.getAllMapsStats())
                      ),
                    );
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(fontFamily: "ValorantFont", fontSize: 10,
                        color: Color(0xFFFFFFFF), decoration: TextDecoration.none),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>
                      EditMapStatsDetails(details: snapshot.data)
                  )
              );
            },
            child: Icon(Icons.edit),
            backgroundColor: Color.fromRGBO(225, 70, 84, 1),
          ),
        )
            :
        CircularProgressIndicator();
      },
    );
  }
}

class EditMapStatsDetails extends StatefulWidget {
  final MapStats details;
  EditMapStatsDetails({Key key,this.details}) : super(key: key);

  @override
  _EditMapStatsDetailsState createState() => _EditMapStatsDetailsState();
}

class _EditMapStatsDetailsState extends State<EditMapStatsDetails> {
  TextEditingController attackersWinRoundController;
  TextEditingController defendersWinRoundController;
  TextEditingController spikesPlantedController;
  TextEditingController spikesDefusedController;
  TextEditingController spikesDetonatedController;
  TextEditingController firstBloodsController;
  TextEditingController firstBloodWinsController;
  TextEditingController eliminationWinsController;
  @override
  void initState(){
    attackersWinRoundController =
    new TextEditingController(text: widget.details.attackersRoundWins.toString());

    defendersWinRoundController =
    new TextEditingController(text: widget.details.defendersRoundWins.toString());

    spikesPlantedController =
    new TextEditingController(text: widget.details.spikesPlanted.toString());

    spikesDefusedController =
    new TextEditingController(text: widget.details.spikesDefused.toString());

    spikesDetonatedController =
    new TextEditingController(text: widget.details.spikesDetonated.toString());

    firstBloodsController =
    new TextEditingController(text: widget.details.firstBloods.toString());

    firstBloodWinsController =
    new TextEditingController(text: widget.details.firstBloodWins.toString());

    eliminationWinsController =
    new TextEditingController(text: widget.details.eliminationWins.toString());

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Opacity(
            opacity: 1,
            child: Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.details.backgroundDetailsUri),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.details.name+" Stats",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "ValorantFont",
                        fontSize: 30,
                        color: Color.fromRGBO(225, 70, 84, 1),
                        decoration: TextDecoration.none,
                        height: 2
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Attackers Round Wins: ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "ValorantFont",
                            fontSize: 20,
                            color: Color.fromRGBO(225, 70, 84, 1),
                            decoration: TextDecoration.none
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: TextFormField(
                          controller: attackersWinRoundController,
                          decoration: null,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Defenders Round Wins: ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "ValorantFont",
                            fontSize: 20,
                            color: Color.fromRGBO(225, 70, 84, 1),
                            decoration: TextDecoration.none
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: TextFormField(
                          controller: defendersWinRoundController,
                          decoration: null,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Spikes Planted: ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "ValorantFont",
                            fontSize: 20,
                            color: Color.fromRGBO(225, 70, 84, 1),
                            decoration: TextDecoration.none
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: TextFormField(
                          controller: spikesPlantedController,
                          decoration: null,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Spikes Defused: ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "ValorantFont",
                            fontSize: 20,
                            color: Color.fromRGBO(225, 70, 84, 1),
                            decoration: TextDecoration.none
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: TextFormField(
                          controller: spikesDefusedController,
                          decoration: null,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Spikes Detonated: ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "ValorantFont",
                            fontSize: 20,
                            color: Color.fromRGBO(225, 70, 84, 1),
                            decoration: TextDecoration.none
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: TextFormField(
                          controller: spikesDetonatedController,
                          decoration: null,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "First Bloods: ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "ValorantFont",
                            fontSize: 20,
                            color: Color.fromRGBO(225, 70, 84, 1),
                            decoration: TextDecoration.none
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: TextFormField(
                          controller: firstBloodsController,
                          decoration: null,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "First Blood Wins: ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "ValorantFont",
                            fontSize: 20,
                            color: Color.fromRGBO(225, 70, 84, 1),
                            decoration: TextDecoration.none
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: TextFormField(
                          controller: firstBloodWinsController,
                          decoration: null,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Elimination Wins: ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "ValorantFont",
                            fontSize: 20,
                            color: Color.fromRGBO(225, 70, 84, 1),
                            decoration: TextDecoration.none
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: TextFormField(
                          controller: eliminationWinsController,
                          decoration: null,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Align(
            heightFactor: 13,
            alignment: Alignment.bottomLeft,
            child: FlatButton(
              color: Color.fromRGBO(225, 70, 84, 1),
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.redAccent,
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text(
                "Back",
                style: TextStyle(fontFamily: "ValorantFont", fontSize: 10,
                    color: Color(0xFFFFFFFF), decoration: TextDecoration.none),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await SQLiteDbProvider.db.update(MapStats(
              widget.details.id,
              widget.details.name,
              widget.details.pictureUri,
              widget.details.backgroundDetailsUri,
          int.parse(attackersWinRoundController.text),
          int.parse(defendersWinRoundController.text),
            int.parse(spikesPlantedController.text),
            int.parse(spikesDefusedController.text),
            int.parse(spikesDetonatedController.text),
            int.parse(firstBloodsController.text),
            int.parse(firstBloodWinsController.text),
            int.parse(eliminationWinsController.text)
          )
          );
          Navigator.push(context,
              MaterialPageRoute(builder: (context)=>
                  MapStatsDetails(details: SQLiteDbProvider.db.getMapStatsById(widget.details.id))
              )
          );
        },
        child: Icon(Icons.check),
        backgroundColor: Color.fromRGBO(225, 70, 84, 1),
      ),
    );
  }
}

