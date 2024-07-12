// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:dailyted/models/talk.dart';
import 'package:dailyted/repository/talk_repository.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
export 'tedx_page_model.dart';


class TedxpageWidget extends StatefulWidget {
  final String id;

  const TedxpageWidget({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<TedxpageWidget> createState() => _TedxpageWidgetState();
}

class _TedxpageWidgetState extends State<TedxpageWidget> with TickerProviderStateMixin {
  late final String id = widget.id;

  final scaffoldKey = GlobalKey<ScaffoldState>();


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
    Future<Talk> _talk = getTalksByID(id);

    return GestureDetector(
      child: FutureBuilder<Talk>(
        future: _talk,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            Talk talk = snapshot.data!;

            return Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(100.0),
                child: AppBar(
                  backgroundColor: Colors.red, //
                  automaticallyImplyLeading: false,
                  actions: [],
                  flexibleSpace: FlexibleSpaceBar(
                    title: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 14.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                  child: FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 30.0,
                                    borderWidth: 1.0,
                                    buttonSize: 50.0,
                                    icon: Icon(
                                      Icons.arrow_back_rounded,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'Back',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                            child: Text(
                              talk.title,
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 22.0,
                                    letterSpacing: 0.0,
                                  ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    centerTitle: true,
                    expandedTitleScale: 1.0,
                  ),
                  elevation: 2.0,
                ),
              ),
              body: SafeArea(
                top: true,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 0.0),
                              child: Center(
                                child: Image.network(
                                  talk.urlimg,
                                  width: double.infinity,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 0.0, 0.0),
                              child: Text(
                                'Descrizione',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(24.0, 4.0, 24.0, 12.0),
                              child: Text(
                                talk.description,
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).labelMedium.override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 0.0, 0.0),
                              child: Text(
                                'Speaker',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(24.0, 4.0, 24.0, 12.0),
                              child: Text(
                                talk.speakers,
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).labelMedium.override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 0.0, 0.0),
                              child: Text(
                                'Link',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(24.0, 4.0, 24.0, 12.0),
                              child: Text(
                                talk.url,
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 0.0, 12.0),
                              child: Text(
                                'Video Correlati',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).labelMedium.override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: talk.relatedTalks!.length,
                                itemBuilder: (context, talksIndex) {
                                  final talksItem = talk.relatedTalks![talksIndex];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                                    child: InkWell(
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
                                          padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 16.0, 8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(0, 8.0, 0.0, 8.0),
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
                                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 4.0, 8.0),
                                                child: Text(
                                                 _formatDuration(talksItem.duration)+" m",
                                                  textAlign: TextAlign.end,
                                                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                    fontFamily: 'Readex Pro',
                                                    letterSpacing: 0.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}