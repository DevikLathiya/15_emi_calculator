import 'dart:math';

import 'package:get/get.dart';

class MyController extends GetxController
{
  RxDouble total=0.0.obs,totalInterest=0.0.obs;
  double monthRate=0;
  RxDouble emi=0.0.obs ;
  RxDouble amount=0.0.obs;
  RxDouble interest=0.0.obs;
  RxInt term=0.obs;

  Calculation()
  {
    num terms = term.value ;
    monthRate = interest/12/100;  // interest in month
    num A = pow((monthRate+1), terms);
    num B = A-1;

    emi.value = ((amount * monthRate * pow((1 + monthRate), terms)) / (pow((1 + monthRate), terms) - 1)).roundToDouble() ;
    total.value = (emi * terms).roundToDouble();
    totalInterest.value = (total.value - amount.value);

    print("Emi : ${emi.value}");
    print("Interest : ${totalInterest.value}");
    print("Total : ${total.value}");
  }

  RxDouble remainBalance=0.0.obs;
  RxDouble principalPaid=0.0.obs;
  RxDouble myinterest=0.0.obs;
  RxList<Map> list = RxList<Map>([]);

  statement(){
    remainBalance.value = amount.value;
    double monthRate = interest/(12 * 100);
    int terms = term.value;

    list.clear();
    for(int i=1; i<=terms;i++){
      myinterest.value = remainBalance * monthRate;
      principalPaid.value = emi.value - myinterest.value;
      remainBalance.value = remainBalance.value - principalPaid.value;

      Map<String,dynamic> map = {
        "month" :"$i",
        "interest" : "${myinterest.value.round()}",
        "principal" : "${principalPaid.value.round()}",
        "Outstanding" : "${remainBalance.value.round()}"
      };
      list.add(map);

    }
  }

}
