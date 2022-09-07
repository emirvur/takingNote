import 'package:flutter/material.dart';
import 'package:tea/models/note.dart';
import 'package:tea/provider/noteProvider.dart';
import 'package:tea/utils/constants/size.dart';
import 'package:tea/view/MainScreen.dart';
import 'package:provider/provider.dart';
import 'package:tea/view/noteList.dart';

class NoteDetail extends StatefulWidget {
  final Note note;
  const NoteDetail(this.note);

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  TextEditingController _controllertitle;
  TextEditingController _controllerdescription;
  String _update = "Update";
  String _updated = "Updated";
  String _deleted = "Deleted";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllertitle = TextEditingController(text: widget.note.noteTitle);
    _controllerdescription =
        TextEditingController(text: widget.note.noteDescription);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await context.read<NoteProvider>().deletenote(widget.note);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(_deleted)),
                );
              },
              icon: Icon(Icons.delete)),
          TextButton(
              onPressed: () {
                Note note = widget.note;
                note.noteTitle = _controllertitle.text;
                note.noteDescription = _controllerdescription.text;
                context.read<NoteProvider>().updatenote(note);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(_updated)),
                );
              },
              child: Text(
                _update,
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              widget.note.noteDate.substring(0, 10),
              style: TextStyle(fontStyle: FontStyle.italic),
            )),
          ),
          Padding(
              padding: const EdgeInsets.all(CentralSize.generalPadding),
              child: CustomTextFormField(
                controller: _controllertitle,
                hintText: "Title",
                defaultText: widget.note.noteTitle,
              )),
          Divider(),
          Padding(
              padding: const EdgeInsets.all(CentralSize.generalPadding),
              child: CustomTextFormFieldNote(
                controller: _controllerdescription,
                hintText: "Desription",
                defaultText: widget.note.noteDescription,
              )),
        ],
      ),
    );
  }
}
