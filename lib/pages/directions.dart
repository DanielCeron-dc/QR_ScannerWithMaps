import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:qr_scanner/providers/DB_provider.dart';

class DirectionPage extends StatefulWidget {
  @override
  _DirectionPageState createState() => _DirectionPageState();
}

class _DirectionPageState extends State<DirectionPage> {
  final DBProvider db = new DBProvider();
  @override
  Widget build(BuildContext context) {
    DBProvider cosa = DBProvider();
    return FutureBuilder<List<ScanModel>>(
        // <2> Pass `Future<QuerySnapshot>` to future
        future: cosa.getAllScanModel(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // <3> Retrieve `List<DocumentSnapshot>` from snapshot
            final List<ScanModel> documents = snapshot.data;
            return ListView(
                children: documents
                    .map((doc) => doc.type == "http"
                        ? Card(
                            child: ListTile(
                              title: Text(doc.value),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  db.deleteDocuments(id: doc.id, http: true);
                                },
                              ),
                            ),
                          )
                        : Container())
                    .toList());
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
