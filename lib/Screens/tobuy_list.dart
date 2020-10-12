import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopasai/Services/azure_cosmos.dart';
import 'package:shopasai/Services/check_list_info.dart';
import 'package:shopasai/constants.dart';

class ToBuyList extends StatefulWidget {
  @override
  _ToBuyListState createState() => _ToBuyListState();
}

class _ToBuyListState extends State<ToBuyList> {
  AzureCosmosDB cosmosDB = AzureCosmosDB();
  List<CheckListInfo> checkListItems = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFF3A91F), Color(0xFFEDDE5D)],
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1A2980),
                  Color(0xFF26D0CE),
//                Color(0xff611cdf),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Text(
              " \n      Add your Supermarket's plan, \n      for this week!!",
              style: TextStyle(
                  color: Colors.white70, fontSize: 18, fontFamily: 'CarterOne'),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () async{
                checkListItems = await cosmosDB.checkListDisplay(customerId: 'CUS149');
                setState(() {

                });
                for(CheckListInfo info in checkListItems){
                  print(info.name);
                  print(info.isChecked);
                }
              },
              child: SvgPicture.asset(
                "image/signup.svg",
                height: 200,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFFF3A91F), Color(0xFFEDDE5D)],
                ),
              ),
              child: ListView.builder(
                itemCount: checkListItems.length,
                // ignore: missing_return
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      radius: 12.0,
                      child: Icon(Icons.remove,color: Colors.white,
                        size: 12.0,)
                    ),
                    title: Text(
                      '   ${checkListItems[index].name}        (${checkListItems[index].count})',
                      style: TextStyle(
                        decoration: (checkListItems[index].isChecked)? TextDecoration.lineThrough:TextDecoration.none,
                          color: kDoctorPrimaryColor, fontFamily: 'CarterOne',
                      fontWeight: FontWeight.w100,
                      fontSize: 15.0),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
