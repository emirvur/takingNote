import 'package:flutter/material.dart';
import 'package:tea/models/note.dart';
import 'package:tea/provider/noteProvider.dart';
import 'package:tea/utils/constants/size.dart';
import 'package:tea/view/MainScreen.dart';
import 'package:provider/provider.dart';
import 'package:tea/view/noteList.dart';
import 'package:tea/widgets/customtextformfield.dart';
import 'package:tea/widgets/customtextformfieldnote.dart';

class AddNote extends StatefulWidget {
  const AddNote();

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController _controllertitle;
  TextEditingController _controllerdescription;
  String _added = "Added";
  String _addnote = "Add a Note";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllertitle = TextEditingController();
    _controllerdescription = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllertitle.dispose();
    _controllerdescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                Note note = Note(
                    noteTitle: _controllertitle.text,
                    noteDescription: _controllerdescription.text,
                    noteDate: DateTime.now().toString().substring(0, 10));
                await context.read<NoteProvider>().addnote(note);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(_added)),
                );
              },
              child: Text(
                _addnote,
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(CentralSize.generalPadding),
            child: Center(
                child: Text(
              DateTime.now().toString().substring(0, 10),
              style: TextStyle(fontStyle: FontStyle.italic),
            )),
          ),
          //     Divider(),
          Padding(
              padding: const EdgeInsets.all(CentralSize.generalPadding),
              child: CustomTextFormField(
                controller: _controllertitle,
                hintText: "Title",
              )),
          //       Divider(),
          Padding(
              padding: const EdgeInsets.all(CentralSize.generalPadding),
              child: CustomTextFormFieldNote(
                  controller: _controllerdescription, hintText: "Description")),
        ],
      ),
    );
  }
}
