import 'package:flutter/material.dart';
import 'package:musicapp/bloc/music_bloc.dart';
import 'package:musicapp/model/music_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Music List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    musicBloc.getMusicData();
  }

  @override
  Widget build(BuildContext context) {

    void _musicDetailsBottomSheet(
        {BuildContext context, DataModel musicModel}) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: FadeInImage.assetNetwork(
                          image: musicModel.imageUrl,
                          placeholder: 'assets/placeholder.png',
                        )),
                    SizedBox(height: 20.0,),
                    Text(musicModel.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),),
                    //SizedBox(height: 10.0,),
                    Divider(),
                    Text(musicModel.artistName, style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),),
                    SizedBox(height: 20.0,),
                    Text('Released On: ${musicModel.releaseDate}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),),
                    SizedBox(height: 5.0,),
                    Text('Type: ${musicModel.kind}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),),
                    Divider(),
                    Text(musicModel.copyright,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),),
                    SizedBox(height: 20.0,),
                  ],
                ),
              ),
            );
          });
    }
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0.0,
          title: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
            child: FutureBuilder<MusicModel>(
                future: musicBloc.getMusicData(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.error_outline,
                          color: Colors.white,
                          size: 50.0,
                        ),
                        Text(
                          'There is some problem.',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ],
                    );
                  }

                  if (snapshot.hasData) {
                    MusicModel musicModel = snapshot.data;
                    return ListView.builder(
                        itemCount: musicModel.resultList.length,
                        itemBuilder: (_, index) {
                          //Text(musicModel.data[index].artistName);
                          DataModel _musicModel = musicModel.resultList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                    onTap: () => _musicDetailsBottomSheet(
                                        context: context,
                                        musicModel: _musicModel),
                                    title: Text(
                                      _musicModel.artistName,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: FadeInImage.assetNetwork(
                                          image: _musicModel.imageUrl,
                                          placeholder: 'assets/placeholder.png',
                                        ))),
                                Divider(
                                  color: Colors.white,
                                )
                              ],
                            ),
                          );
                        });
                  }
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  );
                })),
      ),
    );
  }
}
