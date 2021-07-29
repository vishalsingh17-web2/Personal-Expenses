import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/Widgets/New_Transaction.dart';
import 'package:personal_expenses/Widgets/chart.dart';
import 'package:personal_expenses/Widgets/transaction_list.dart';
import 'package:personal_expenses/Models/transactions.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({ Key? key }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransaction=[];
  void _addNew(String Txtitle,double amount,DateTime Date){
    final newTx=Transaction(
      title: Txtitle, 
      amount: amount,
      date: Date,
      id: DateTime.now().toString()
      );
      setState(() {
        _userTransaction.add(newTx);
      });
  }

  
  
  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _delete(String id){
    setState(() {
      _userTransaction.removeWhere((element) => element.id==id);
    });
  }

  void _addNewTransaction(BuildContext ctx){
    showModalBottomSheet(
      context: ctx,
      builder: (_){
        return GestureDetector(
          child: NewTransaction(_addNew),
          behavior: HitTestBehavior.opaque,          
          );
      }
      ); 
  }
  
  
  @override
  Widget build(BuildContext context) {
    final appBar=AppBar(
        title: Text("Personal Expenses",style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          )),
        actions: [
          IconButton(
            onPressed: () => _addNewTransaction(context), 
            icon: Icon(Icons.add)),
        ],
      );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: (MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top-appBar.preferredSize.height)*0.25,
              child: Chart(_recentTransactions)),
            Container(
              height: (MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top-appBar.preferredSize.height)*0.75,
              child: TransactionList(_userTransaction,_delete)),
            
          ],
          
        ),
      ),


      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewTransaction(context),
        child: Icon(Icons.add),
        )
    );

  }
}
