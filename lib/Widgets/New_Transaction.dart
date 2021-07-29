import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class NewTransaction extends StatefulWidget {
  
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  
  
  final amountController= TextEditingController();
  final titleController=TextEditingController();
  var  _selectedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate==null) {
      return;
    }
    widget.addTx(enteredTitle,enteredAmount,_selectedDate);
    Navigator.of(context).pop();
 
}
  void _setDate(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2015), 
      lastDate: DateTime.now()
      ).then((value) {
        if(value==null){
          return;
        }
        setState(() {
          _selectedDate=value;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: InputDecoration(labelText:"Title"),
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  onSubmitted: (_) => submitData,
                ),
                TextField(
                  decoration: InputDecoration(labelText:"Amount"),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => submitData,
                ),

                Row(
                  children: [
                    Text(_selectedDate==null?"No Date Chosen!":DateFormat.yMMMEd().format(_selectedDate)),
                    SizedBox(width: 20,),
                    IconButton(onPressed: _setDate, icon: Icon(CupertinoIcons.calendar))
                  ],
                ),
                ElevatedButton(onPressed: submitData,
                  child: Text("Add Transaction"))
              ],
            ),
          );
    
  }
}