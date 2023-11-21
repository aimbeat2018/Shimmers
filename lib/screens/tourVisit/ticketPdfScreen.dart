import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicketPdfScreen extends StatelessWidget {
  String pathPDF = "";
  TicketPdfScreen(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Document"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
        );
  }
}