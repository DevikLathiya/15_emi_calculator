import 'package:carousel_pro/carousel_pro.dart';
import 'package:emi_calculator/Statement%20View.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Controller.dart';

class HomePage extends StatelessWidget {

  List <String> images=["images/loan.jpg","images/Loan1.jpg","images/Loan.png","images/Loan2.jpg","images/Loan3.jpg"];
  final TextEditingController _loanAmount = TextEditingController();
  final TextEditingController _interest = TextEditingController();
  final TextEditingController _term = TextEditingController();



  @override
  Widget build(BuildContext context) {
    MyController data = Get.put(MyController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(alignment: Alignment.center,
              height: 50,width: double.infinity,
              child: const Text("Loan Emi Calculator",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,),),),

              Container(margin:const EdgeInsets.fromLTRB(10,10,10,0),
                  height:200,width:double.infinity,
                  decoration:BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(10),
                    boxShadow: const [BoxShadow(color: Colors.grey,offset: Offset(0, 0),blurRadius: 5,spreadRadius: 2),]
                  ),
                  child:ClipRRect(
                    borderRadius:BorderRadius.circular(10),
                    child:AspectRatio( aspectRatio:16/9,
                      child:Carousel(
                          dotSize:4, dotSpacing:15,
                          dotColor:Colors.lightBlueAccent, indicatorBgPadding:5,
                          dotBgColor:Colors.transparent, dotVerticalPadding:5,
                          dotPosition:DotPosition.bottomCenter,
                          images:images.map((e)=>Container(
                            child:Image(fit:BoxFit.cover,image:AssetImage(e)),)).toList()
                      ),),
                  )
              ),
              SizedBox(height: 20),

               Card(elevation: 2,margin: EdgeInsets.all(10),
                child: TextField(controller: _loanAmount,
                  style: TextStyle(fontSize: 18),keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "Ex..1,00,000", label: Text("Loan Amount"),
                      border: OutlineInputBorder()
                  ),
                ),
              ),
               Card(elevation: 2,margin: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(controller: _interest,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "Ex..8%", border: OutlineInputBorder(),
                      label: Text("Interest Rate")
                  ),
                ),
              ),
               Card(elevation: 2,margin: EdgeInsets.all(10),
                child: TextField(controller: _term,
                  keyboardType: TextInputType.number,
                  decoration:  InputDecoration(
                      hintText: "Ex..12 Months",
                      label: Text("Loan Tenure"),border: OutlineInputBorder()
                      //contentPadding: EdgeInsets.all(15),
                  ),
                ),
              ),

              Container(margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                height: 40,width: 80,
                decoration: BoxDecoration(
                  color: Colors.white, borderRadius:BorderRadius.circular(10),
                    boxShadow: const [BoxShadow(color: Colors.grey,offset: Offset(0, 0),blurRadius: 5,spreadRadius: 2),]
                ),
                child: ElevatedButton(onPressed: () {
                  if(_loanAmount.text.isEmpty || _term.text.isEmpty || _interest.text.isEmpty)
                    {
                      Get.snackbar(
                        "Filed Required",
                        "Please Enter Value",
                        icon: Icon(Icons.person, color: Colors.white),
                        snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                        isDismissible: true,
                        barBlur: 50
                      );
                    }
                  else
                    {
                      data.amount.value = double.parse(_loanAmount.text);
                      data.term.value = int.parse(_term.text);
                      data.interest.value = double.parse(_interest.text );
                      data.Calculation();
                      showModalBottomSheet(context: context, builder: (context) {
                        return Container(
                          height: 300,width: double.infinity,margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2)),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(" EMI",style: TextStyle(fontSize: 15)),
                              Obx(() => Text("₹ ${data.emi.toString()}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500))),
                              Divider(endIndent: 10,indent: 10,color: Colors.black),

                              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(padding: EdgeInsets.all(5),width: 90,margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(color: Colors.cyan.shade100, borderRadius: BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Text("Principal"),
                                          Text("Amount"),
                                          Container(margin: EdgeInsets.symmetric(vertical: 10),
                                              child: Text("₹ ${data.amount.value}",style: TextStyle(fontSize: 20),)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Text("+",style: TextStyle(fontSize: 20)),
                                  Expanded(
                                    child: Container(padding: EdgeInsets.all(5),margin: EdgeInsets.all(5),width: 90,
                                      decoration: BoxDecoration(color: Colors.cyan.shade100, borderRadius: BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Text("Intrest"),
                                          Text("Amount"),
                                          Container(margin: EdgeInsets.symmetric(vertical: 10),
                                              child: Text("₹ ${data.totalInterest}",style: TextStyle(fontSize: 20),)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(padding: EdgeInsets.all(5),width: 200,height: 80,alignment: Alignment.center,
                                    decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        Text("Total Amount"),
                                        Container(margin: EdgeInsets.only(top: 10),
                                            child: Text("₹ ${data.total.value}",style: TextStyle(fontSize: 20),)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(onPressed: () {
                                data.statement();
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return StatementView();
                                },));
                              }, child: Text("View Statment"))
                            ],
                          ),
                        );
                      },);
                    }
                }, child: Text("Submit")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*Container(margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                        height: 40,width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:BorderRadius.circular(10),
                            boxShadow: [BoxShadow(color: Colors.grey,offset: Offset(0, 0),blurRadius: 5,spreadRadius: 2),]
                        ),
                      ),*/