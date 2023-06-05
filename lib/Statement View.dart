import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'Controller.dart';


class StatementView extends StatelessWidget {
   StatementView({Key? key}) : super(key: key);
   MyController data = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statement"),
      ),
      body: Column(
        children:[
          Container(margin: EdgeInsets.symmetric(vertical: 3,horizontal: 5),padding: EdgeInsets.all(5),
            decoration: BoxDecoration(color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.orange.shade200.withOpacity(0.30),width: 2)
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("Principal"),
                    Text("Amount"),
                    Container(margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text("₹ ${data.amount.value}",style: TextStyle(fontSize: 16),)),
                  ],
                ),
                Column(
                  children: [
                    Text("Intrest"),
                    Text("Rate"),
                    Container(margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text("${data.interest.value.toInt()} %",style: TextStyle(fontSize: 16),)),
                  ],
                ),
                Column(
                  children: [
                    Text("Tenure"),
                    Text("Month"),
                    Container(margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text("${data.term.toInt()} ",style: TextStyle(fontSize: 16),)),
                  ],
                ),
                Column(
                  children: [
                    Text("EMI"),
                    Text("Amount"),
                    Container(margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text("₹ ${data.emi.value}",style: TextStyle(fontSize: 16),)),
                  ],
                ),
              ],
            ),
          ),
          Card(margin: EdgeInsets.only(bottom: 8,top: 2),
            child: Container(height: 30,color: Colors.cyan.shade50,padding: EdgeInsets.only(left: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:  [
                  Expanded(flex: 2,child: Container(child: Text("Month"),margin: EdgeInsets.only(right: 10),)),
                  Expanded(flex: 3,child: Container(child: Text("Principal"),margin: EdgeInsets.only(left: 8),)),
                  Expanded(flex: 3,child: Container(child: Text("Interest"),margin: EdgeInsets.only(left: 12),)),
                  Expanded(flex: 3,child: Container(child: Text("Outstanding"))),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.list.length,
              itemBuilder: (context, index) {
                return Container(margin: EdgeInsets.symmetric(vertical: 2),padding: EdgeInsets.all(5),color: (index%2==0) ? Colors.grey.shade200.withOpacity(0.7) : Colors.white,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 1,child: Container(margin: EdgeInsets.fromLTRB(3,3,12,3),child: Text("${data.list[index]['month']}"),alignment: Alignment.center,)),
                      Expanded(flex: 2,child: Container(margin: EdgeInsets.all(3),child: Text("${data.list[index]['principal']}"),alignment: Alignment.center,)),
                      Expanded(flex: 2,child: Container(margin: EdgeInsets.all(3),child: Text("${data.list[index]['interest']}"),alignment: Alignment.center,)),
                      Expanded(flex: 2,child: Container(margin: EdgeInsets.fromLTRB(3,3,5,3),child: Text((double.parse(data.list[index]['Outstanding'])<=0) ? "0" : "${data.list[index]['Outstanding']}"),alignment: Alignment.center,)),
                    ],
                  ),
                );
              },),
          ),
          Container(margin: EdgeInsets.all(5),padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
              child: Text("Please Compromise Minor Mistake."),
          decoration: BoxDecoration(color: Colors.cyan.shade50,
          borderRadius: BorderRadius.circular(8)),)
        ]
      ),
    );
  }
}


/*
class StatementView extends StatelessWidget {
  StatementView();
  final DataTableSource _data = MyData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            PaginatedDataTable(source: _data,
              columns: const [
                DataColumn(label: Text("Sr")),
                DataColumn(label: Text("Term")),
                DataColumn(label: Text("Principal")),
                DataColumn(label: Text("Interest")),
                DataColumn(label: Text("Balance")),
              ],
              header: const Center(
                child: Text("Statement Report",style: TextStyle(fontWeight: FontWeight.w500),),),
              columnSpacing: 22,
            )
          ],
        ),
      ),
    );
  }
}

class MyData extends DataTableSource
{
  final List<Map<String,dynamic>> _data =List.generate(
      10, (index) => {
     "Sr" : "${index+1}",
    "Term" : "Month${index}",
    "Principal" : "${index*225}",
    "Interest" : "${index*90}",
    "Balance" : "${(index*90)+(index*225)}"
  });
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['Sr'].toString())),
      DataCell(Text(_data[index]['Term'].toString())),
      DataCell(Text(_data[index]['Principal'].toString())),
      DataCell(Text(_data[index]['Interest'].toString())),
      DataCell(Text(_data[index]['Balance'].toString())),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => 12;//_data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
  
}
*/
