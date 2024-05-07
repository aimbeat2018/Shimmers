import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/textConstant.dart';
import '../../model/employeeTargetDetail.dart';

class BrandwiseTargetDetails extends StatefulWidget{
  final List<ProductData> productList;
  final String? brandName;

  BrandwiseTargetDetails({required this.productList,required this.brandName});

  @override
  State<StatefulWidget> createState() {
    return _BrandwiseTargetDetails();
  }

}
class _BrandwiseTargetDetails extends State<BrandwiseTargetDetails>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       iconTheme: IconThemeData(
         color: Colors.white, //change your color here
       ),
       backgroundColor: primaryColor,
       centerTitle: true,
       title: Text(
         widget.brandName!,
         style: const TextStyle(
             color: Colors.white,
             fontSize: 16,
             fontWeight: FontWeight.bold),
       ),
     ),
     body:SingleChildScrollView(
       child: ListView.builder(
           shrinkWrap: true,
           itemCount: widget.productList!.length,
           physics:
           const NeverScrollableScrollPhysics(),
           itemBuilder: (BuildContext context,
               int index) {
             return Padding(
               padding: const EdgeInsets.symmetric(
                   vertical: 8.0, horizontal: 10),
               child: Card(
                 elevation: 5,
                 color: widget.productList![index].status == "pending"
                     ? Colors.red.shade50
                     : Colors.green.shade50,
                 shape: RoundedRectangleBorder(
                   borderRadius:
                   BorderRadius.all(Radius.circular(10)),
                 ),
                 child: Padding(
                   padding: const EdgeInsets.symmetric(
                       horizontal: 15.0, vertical: 8),
                   child: Row(
                     mainAxisAlignment:
                     MainAxisAlignment.spaceBetween,
                     children: [
                       Expanded(
                         child: Column(
                           mainAxisAlignment:
                           MainAxisAlignment.start,
                           crossAxisAlignment:
                           CrossAxisAlignment.start,
                           children: [
                             Text(
                               'Product Name: ${widget.productList![index].productName}',
                               style: const TextStyle(
                                   color: primaryColor,
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold),
                             ),
                             SizedBox(
                               height: 5,
                             ),
                             Text(
                               'Assigned Target: ${widget.productList![index].assignedTarget}',
                               style: const TextStyle(
                                   color: primaryColor,
                                   fontSize: 13,
                                   fontWeight: FontWeight.w500),
                             ),
                             SizedBox(
                               height: 5,
                             ),
                             Text(
                               'Completed Target: ${widget.productList![index].completedTarget}',
                               style: const TextStyle(
                                   color: primaryColor,
                                   fontSize: 13,
                                   fontWeight: FontWeight.w500),
                             ),
                             SizedBox(
                               height: 5,
                             ),
                             Text(
                               'Target Status: ${widget.productList![index].status!}',
                               style: TextStyle(
                                   color: widget.productList![index].status ==
                                       "pending"
                                       ? Colors.red
                                       : Colors.green,
                                   fontSize: 13,
                                   fontWeight: FontWeight.w500),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
             );
           }),
     )
   );
  }

}