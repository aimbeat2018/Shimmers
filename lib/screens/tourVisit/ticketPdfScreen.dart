import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constant/custom_snackbar.dart';

class TicketPdfScreen extends StatefulWidget {
  String fileUrl,from;
  TicketPdfScreen({required this.fileUrl,required this.from});


  @override
  State<StatefulWidget> createState() {
    return _TicketPdfScreen();
  }
}

class _TicketPdfScreen extends State<TicketPdfScreen> {
  late File Pfile;
  bool isLoading = false;

  Future<void> loadNetwork() async {
    setState(() {
      isLoading = true;
    });
    var url =widget.fileUrl;
      //  'https://crm.shimmerscosmetics.in/public/tourvisit/1775326384.pdf';
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    var file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    setState(() {
      Pfile = file;
    });

    print(Pfile);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadNetwork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "View Attachment",
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(onTap: (){
              var url = widget.fileUrl;
              if(widget.from=='tour') {
                var filename = 'TourTicket.pdf';
                download(url, filename);
              }
              else{
                var filename = 'Expenses.pdf';
                download(url, filename);
              }
            },
                child: Icon(Icons.download)),
          )
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Center(
                child: PDFView(
                  filePath: Pfile.path,
                ),
              ),
            ),
    );
  }
  Future download(String url, String filename) async {
    var savePath = '/storage/emulated/0/Download/$filename';
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    try {
      var response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );
      var file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
      showCustomSnackBar('Ticket Saved Successfully in '+savePath+' folder',isError: false);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  void showDownloadProgress(received, total) {
    if (total != -1) {
      debugPrint((received / total * 100).toStringAsFixed(0) + '%');
      //CircularProgressIndicator();
    }
  }


}
