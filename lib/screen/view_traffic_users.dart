import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivecoach/screen/update_rules.dart';
import 'package:drivecoach/screen/view_rule_detail.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewRuleUsersList extends StatefulWidget {
  @override
  _ViewRuleUsersListState createState() => _ViewRuleUsersListState();
}

getRules() async {
  return await Firestore.instance.collection('rules').getDocuments();
}

class _ViewRuleUsersListState extends State<ViewRuleUsersList> {
  QuerySnapshot ruleNo;

  @override
  void initState() {
    super.initState();
    getRules().then((data) {
      setState(() {
        ruleNo = data;
      });
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MANAGE ARTICLES'),
          backgroundColor: Colors.purple,
        ),
        body: showRuleList());
  }

  Widget showRuleList() {
    if (ruleNo != null && ruleNo.documents != null) {
      return ListView.builder(
        itemCount: ruleNo.documents.length,
        itemBuilder: (BuildContext context, index) {
          return Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  trailing: IconButton(
                    icon: Icon(
                      Icons.details,
                      color: Colors.purple,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ViewRuleDetail(ruleNo.documents[index]);
                          },
                        ),
                      );
                    },
                  ),
                  title: Text('${ruleNo.documents[index].data['title']}' ,
                    style: TextStyle(color: Colors.purple,),),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(viewArticle(ruleNo.documents[index].data['rule'])),

                    ],),
                ),
                Divider(
                  color: Colors.black,
                )
              ],
            ),
          );
        },
      );
    } else if (ruleNo != null && ruleNo.documents.length == 0) {
      return Text(
        "No Traffic Rule!",
        style: TextStyle(fontSize: 19),
      );
    } else {
      print(ruleNo);

      return Align(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Text(
              "Please Wait while load data!",
              style: TextStyle(fontSize: 19),
            )
          ],
        ),
      );
    }
  }

  String viewArticle(String article) {
    if(article.length > 90)
      {
        return article.substring(0,90);
      }
    return article;
  }



}