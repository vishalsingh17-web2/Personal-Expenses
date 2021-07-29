import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/Models/transactions.dart';


class TransactionList extends StatelessWidget {
  
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions,this.deleteTx);

  
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      return Container(
      height: constraints.maxHeight*0.7,
      child: transactions.isEmpty?
      Center(
        child: Column(
          children: [
            Text("No Transaction added yet"),
            SizedBox(height: 20,),
            Container(
              height: constraints.maxHeight*0.7,
              child: Image.asset('lib/assets/waiting.png',fit: BoxFit.cover,)),
          ],
        ),
      ):
       ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx,index){
          return Card(
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5
            ),
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6), 
                child: FittedBox(child: Text("₹ ${transactions[index].amount}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
                ))),
              ),
              title: Text(transactions[index].title),
              subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
              trailing: IconButton(
                iconSize: 30,
                onPressed: () =>deleteTx(transactions[index].id), 
                icon: Icon(Icons.delete)),
            ),
          );
        }
            ),
    );
    });
    
  }
}