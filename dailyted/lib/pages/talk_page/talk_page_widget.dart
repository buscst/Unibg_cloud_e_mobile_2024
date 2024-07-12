// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:dailyted/repository/talk_repository.dart';
import '../../flutter_flow/nav/navbar.dart';
import 'package:dailyted/models/talk.dart';
import '../tedx_page/tedx_page_widget.dart';

class TalkPageWidget extends StatefulWidget {
  const TalkPageWidget({
    super.key,
    this.title = "DailyTed - Talks",
  });

  final String title;
  
  @override
  State<TalkPageWidget> createState() => _TalkPageWidgetState();
}

class _TalkPageWidgetState extends State<TalkPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
    final TextEditingController _controller = TextEditingController();
    late Future<List<Talk>> _talks;
    int page = 1;
    bool init = true;

    @override
    void initState() {
      super.initState();
      _talks = initEmptyList();
      init = true;
    }

    void _getTalksByTag() async {
    setState(() {
      init = false;
      _talks = getTalksByTag(_controller.text, page);
    });
   }

    String _formatDuration(String durationInSecondsStr) {
    int? durationInSeconds = int.tryParse(durationInSecondsStr);
    if (durationInSeconds == null) {
      return 'NAN';
    }
    Duration duration = Duration(seconds: durationInSeconds);
    String minutes = (duration.inMinutes).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }   

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'DailyTed - Talks',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Scaffold(
            appBar:AppBar(
            backgroundColor: Colors.red,
            automaticallyImplyLeading: false,
            title: Text(
              'DailyTEDx - Talks',
              style: TextStyle(
                fontFamily: 'Readex Pro',
                color: Colors.white,
                letterSpacing: 0.0,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/dailyted_logo.png',  // Percorso relativo all'immagine nell'asset
                    width: 60.0,
                    height: 60.0,
                    fit: BoxFit.cover,
                    alignment: Alignment(0.0, 0.0),
                  ),
                ),
              ),
            ],
            centerTitle: false,
            elevation: 0.0,
          ),
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: (init)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        controller: _controller,
                        decoration:
                            const InputDecoration(hintText: 'Enter your favorite talk'),
                      ),
                      ElevatedButton(
                        child: const Text('Search by tag'),
                        onPressed: () {
                          page = 1;
                          _getTalksByTag();
                        },
                      ),
                    ],
                  )
                : FutureBuilder<List<Talk>>(
                    future: _talks,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Scaffold(
                            appBar: AppBar(
                              title: Text("Tag: ${_controller.text}"),
                            ),
                            body: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, talksIndex) {
                                  final talksItem = snapshot.data![talksIndex];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TedxpageWidget(
                                              id: talksItem.id,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 3.0,
                                              color: Color(0x20000000),
                                              offset: Offset(0.0, 1.0),
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 16.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  talksItem.urlimg,
                                                  width: 90.0,
                                                  height: 90.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                        child: Text(
                                                          talksItem.title,
                                                          style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                fontFamily: 'Inter',
                                                                letterSpacing: 0.0,
                                                              ),
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      Text(
                                                        talksItem.speakers,
                                                        style: FlutterFlowTheme.of(context).labelMedium.override(
                                                              fontFamily: 'Inter',
                                                              letterSpacing: 0.0,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  _formatDuration(talksItem.duration) + " m",
                                                  textAlign: TextAlign.end,
                                                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                        fontFamily: 'Readex Pro',
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),//-----------------------------
                                      ),
                                    ),
                                  );
                                },
                            ),
                            floatingActionButtonLocation:
                                FloatingActionButtonLocation.centerDocked,
                            floatingActionButton: FloatingActionButton(
                              child: const Icon(Icons.arrow_drop_down),
                              onPressed: () {
                                if (snapshot.data!.length >= 6) {
                                  page = page + 1;
                                  _getTalksByTag();
                                }
                              },
                            )
                            );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      return const CircularProgressIndicator();
                    },
                  ),
          ),
        bottomNavigationBar: NavBar(),
        ),
      );
    }
}
