import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  bool? checkboxListTileValue1 = false;
  bool? checkboxListTileValue2 = false;
  bool? checkboxListTileValue3 = false;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 241, 241, 241),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ))),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Your Subscription',
                      // style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color(0x34111417),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Theme(
                          data: ThemeData(
                            backgroundColor: Colors.white,
                            checkboxTheme: CheckboxThemeData(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            unselectedWidgetColor: Color(0xFF95A1AC),
                          ),
                          child: CheckboxListTile(
                            value: checkboxListTileValue1 ??= true,
                            onChanged: (newValue) async {
                              setState(() {
                                checkboxListTileValue1 = newValue!;
                                checkboxListTileValue2 = false;
                                checkboxListTileValue3 = false;
                              });
                            },
                            title: Text(
                              'SILVER PLAN',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              // style: FlutterFlowTheme.of(context).bodyText2,
                            ),
                            subtitle: Text(
                              '\₹50/m - monthly',
                              // style: FlutterFlowTheme.of(context).title3,
                            ),
                            // tileColor:
                            // FlutterFlowTheme.of(context).primaryBackground,
                            // activeColor:
                            // FlutterFlowTheme.of(context).primaryColor,
                            // checkColor:
                            //     FlutterFlowTheme.of(context).primaryBtnText,
                            dense: false,
                            controlAffinity: ListTileControlAffinity.trailing,
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                          child: checkboxListTileValue1 == false
                              ? Text(
                                  'Gain unlimited access to all the content we have to offer! ',
                                  // style: FlutterFlowTheme.of(context).bodyText2,
                                )
                              : Column(
                                  children: [
                                    Text(
                                      'Gain unlimited access to all the content we have to offer! ',
                                      // style: FlutterFlowTheme.of(context).bodyText2,
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.check_rounded, size: 19),
                                        SizedBox(width: 10),
                                        Text(
                                          'Offers & benefits',
                                          // style: FlutterFlowTheme.of(context).bodyText2,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.check_rounded, size: 19),
                                        SizedBox(width: 10),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.73,
                                          child: Text(
                                            'For every product & services offer & benefits are subjected to change geographically and monthly.',
                                            softWrap: true,
                                            // style: FlutterFlowTheme.of(context).bodyText2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(Icons.check_rounded, size: 19),
                                        SizedBox(width: 10),
                                        Text(
                                          'Minimum selling targets & Incentives',
                                          // style: FlutterFlowTheme.of(context).bodyText2,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.check_rounded, size: 19),
                                        SizedBox(width: 10),
                                        Text(
                                          'Quantity, Item, Price define',
                                          // style: FlutterFlowTheme.of(context).bodyText2,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushNamed('Payment');
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.lightBlue[100],
                                                border: Border.all(
                                                    color: Colors.white70)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              child: Column(children: [
                                                Text(
                                                  'MONTHLY',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  '\₹50/m',
                                                  // style: FlutterFlowTheme.of(context).bodyText2,
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushNamed('Payment');
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.lightBlue[100],
                                                border: Border.all(
                                                    color: Colors.white70)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              child: Column(children: [
                                                Text(
                                                  '6 MONTHS',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  '\₹500/m',
                                                  // style: FlutterFlowTheme.of(context).bodyText2,
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushNamed('Payment');
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.lightBlue[100],
                                                border: Border.all(
                                                    color: Colors.white70)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              child: Column(children: [
                                                Text(
                                                  'YEARLY',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  '\₹200/m',
                                                  // style: FlutterFlowTheme.of(context).bodyText2,
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color(0x34111417),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Theme(
                          data: ThemeData(
                            checkboxTheme: CheckboxThemeData(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            unselectedWidgetColor: Color(0xFF95A1AC),
                          ),
                          child: CheckboxListTile(
                            value: checkboxListTileValue2 ??= false,
                            onChanged: (newValue) async {
                              setState(() {
                                checkboxListTileValue2 = newValue!;
                                checkboxListTileValue1 = false;
                                checkboxListTileValue3 = false;
                              });
                            },
                            title: Text(
                              'GOLD PLAN',
                              // style: FlutterFlowTheme.of(context).bodyText2,
                            ),
                            subtitle: Text(
                              '\₹150/m - monthly',
                              // style: FlutterFlowTheme.of(context).title3,
                            ),
                            // tileColor:
                            //     FlutterFlowTheme.of(context).primaryBackground,
                            // activeColor:
                            //     FlutterFlowTheme.of(context).primaryColor,
                            // checkColor:
                            //     FlutterFlowTheme.of(context).primaryBtnText,
                            dense: false,
                            controlAffinity: ListTileControlAffinity.trailing,
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                          child: checkboxListTileValue2 == false
                              ? Text(
                                  'Gain unlimited access to all the content we have to offer! ',
                                  // style: FlutterFlowTheme.of(context).bodyText2,
                                )
                              : Column(
                                  children: [
                                    Text(
                                      'Gain unlimited access to all the content we have to offer! ',
                                      // style: FlutterFlowTheme.of(context).bodyText2,
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Icon(Icons.check_rounded, size: 19),
                                        SizedBox(width: 10),
                                        Text(
                                          'Offers & benefits',
                                          // style: FlutterFlowTheme.of(context).bodyText2,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.check_rounded, size: 19),
                                        SizedBox(width: 10),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.73,
                                          child: Text(
                                            'For every product & services offer & benefits are subjected to change geographically and monthly.',
                                            softWrap: true,
                                            // style: FlutterFlowTheme.of(context).bodyText2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.check_rounded, size: 19),
                                        SizedBox(width: 10),
                                        Text(
                                          'Minimum selling targets & Incentives',
                                          // style: FlutterFlowTheme.of(context).bodyText2,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.check_rounded, size: 19),
                                        SizedBox(width: 10),
                                        Text(
                                          'Quantity, Item, Price define',
                                          // style: FlutterFlowTheme.of(context).bodyText2,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushNamed('Payment');
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.lightBlue[100],
                                                border: Border.all(
                                                    color: Colors.white70)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              child: Column(children: [
                                                Text(
                                                  'MONTHLY',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  '\₹700/m',
                                                  // style: FlutterFlowTheme.of(context).bodyText2,
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushNamed('Payment');
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.lightBlue[100],
                                                border: Border.all(
                                                    color: Colors.white70)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              child: Column(children: [
                                                Text(
                                                  '6 MONTHS',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  '\₹500/m',
                                                  // style: FlutterFlowTheme.of(context).bodyText2,
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushNamed('Payment');
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.lightBlue[100],
                                                border: Border.all(
                                                    color: Colors.white70)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              child: Column(children: [
                                                Text(
                                                  'YEARLY',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  '\₹200/m',
                                                  // style: FlutterFlowTheme.of(context).bodyText2,
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    // color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color(0x34111417),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                    child: Column(
                      children: [
                        Theme(
                          data: ThemeData(
                            checkboxTheme: CheckboxThemeData(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            unselectedWidgetColor: Color(0xFF95A1AC),
                          ),
                          child: CheckboxListTile(
                            value: checkboxListTileValue3 ??= false,
                            onChanged: (newValue) async {
                              setState(() {
                                checkboxListTileValue3 = newValue!;
                                checkboxListTileValue1 = false;
                                checkboxListTileValue2 = false;
                              });
                            },
                            title: Row(
                              children: [
                                Text(
                                  'Pro',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  // style: FlutterFlowTheme.of(context).title3,
                                ),
                                SizedBox(width: 10),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text('Save 20%',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[700])),
                                  ),
                                )
                              ],
                            ),
                            subtitle: Text('\₹700/m - monthly',
                                style: TextStyle(color: Colors.white)
                                // style: FlutterFlowTheme.of(context).bodyText2,
                                ),
                            // tileColor:
                            //     FlutterFlowTheme.of(context).primaryBackground,
                            // activeColor: FlutterFlowTheme.of(context).primaryColor,
                            // checkColor: FlutterFlowTheme.of(context).primaryBtnText,
                            dense: false,
                            controlAffinity: ListTileControlAffinity.trailing,
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                          child: checkboxListTileValue3 == false
                              ? Text(
                                  'Pro account gives you Subscription Services without any commission',
                                  style: TextStyle(color: Colors.white)

                                  // style: FlutterFlowTheme.of(context).bodyText2,
                                  )
                              : Column(
                                  children: [
                                    Text(
                                        'Pro account gives you Subscription Services without any commission',
                                        style: TextStyle(color: Colors.white)
                                        // style: FlutterFlowTheme.of(context).bodyText2,
                                        ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Icon(Icons.check_rounded,
                                            size: 19, color: Colors.white),
                                        SizedBox(width: 10),
                                        Text('Offers & benefits',
                                            style:
                                                TextStyle(color: Colors.white)
                                            // style: FlutterFlowTheme.of(context).bodyText2,
                                            ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.check_rounded,
                                            size: 19, color: Colors.white),
                                        SizedBox(width: 10),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.73,
                                          child: Text(
                                            'For every product & services offer & benefits are subjected to change geographically and monthly.',
                                            style:
                                                TextStyle(color: Colors.white),
                                            softWrap: true,
                                            // style: FlutterFlowTheme.of(context).bodyText2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.check_rounded,
                                            size: 19, color: Colors.white),
                                        SizedBox(width: 10),
                                        Text(
                                            'Minimum selling targets & Incentives',
                                            style:
                                                TextStyle(color: Colors.white)
                                            // style: FlutterFlowTheme.of(context).bodyText2,
                                            ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.check_rounded,
                                            size: 19, color: Colors.white),
                                        SizedBox(width: 10),
                                        Text('Quantity, Item, Price define',
                                            style:
                                                TextStyle(color: Colors.white)
                                            // style: FlutterFlowTheme.of(context).bodyText2,
                                            ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushNamed('Payment');
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.lightBlue[100],
                                                border: Border.all(
                                                    color: Colors.white70)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              child: Column(children: [
                                                Text(
                                                  'MONTHLY',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  '\₹700/m',
                                                  // style: FlutterFlowTheme.of(context).bodyText2,
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushNamed('Payment');
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.lightBlue[100],
                                                border: Border.all(
                                                    color: Colors.white70)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              child: Column(children: [
                                                Text(
                                                  '6 MONTHS',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  '\₹500/m',
                                                  // style: FlutterFlowTheme.of(context).bodyText2,
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushNamed('Payment');
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.lightBlue[100],
                                                border: Border.all(
                                                    color: Colors.white70)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              child: Column(children: [
                                                Text(
                                                  'YEARLY',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  '\₹200/m',
                                                  // style: FlutterFlowTheme.of(context).bodyText2,
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
