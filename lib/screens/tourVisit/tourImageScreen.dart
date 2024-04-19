import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmers/constant/custom_snackbar.dart';

class TourImageScreen extends StatefulWidget{
  String image_url,extension,from;

  TourImageScreen({required this.image_url,required this.extension,required this.from});

  @override
  State<StatefulWidget> createState() {
   return _TourImageScreen();
  }

}
class _TourImageScreen extends State<TourImageScreen>{
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
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
              var url = widget.image_url;
              if(widget=='tour') {
                var filename = 'TourTicket${widget.extension}';
                download(url, filename);
              }
              else{
                var filename = 'Expenses${widget.extension}';
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
          child:
          Image.network(
            widget.image_url!,
            fit: BoxFit.fill,
            // When image is loading from the server it takes some time
            // So we will show progress indicator while loading
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            // When dealing with networks it completes with two states,
            // complete with a value or completed with an error,
            // So handling errors is very important otherwise it will crash the app screen.
            // I showed dummy images from assets when there is an error, you can show some texts or anything you want.
            errorBuilder: (context, exception, stackTrace) {
              return Image.asset(
                'assets/images/user_blue.png',
                fit: BoxFit.cover,
                height:120,
                width: double.infinity,
              );
            },
          ),/*Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 20),
            child: widget.image_url! == ""
                ? Image.asset(
              'assets/images/user_blue.png',
              height: 350,
              width: 180,
            )
                : Image.network(
              widget.image_url!,
              height: 350,
              width: 180,
            ),
          ),*/
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
    }
  }


}