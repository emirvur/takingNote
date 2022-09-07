import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea/utils/constants/size.dart';
import 'package:tea/utils/enums/noteEnum.dart';
import 'package:tea/models/note.dart';
import 'package:tea/provider/noteProvider.dart';
import 'package:tea/utils/routes.dart';
import 'package:tea/view/noteDetail.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList>
    with AutomaticKeepAliveClientMixin {
  String _mynotes = "My Notes";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NoteProvider>().initnote();
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_mynotes),
        ),
        body: Consumer<NoteProvider>(builder: (_, prov, child) {
          return prov.state == NoteViewState.Busy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                        child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemCount: prov.notes.length,
                            itemBuilder: (BuildContext context, int index) {
                              Note note = prov.notes[index];
                              return Padding(
                                padding: const EdgeInsets.all(
                                    CentralSize.generalPadding),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, notedetail,
                                          arguments: note);
                                    },
                                    child: ListTile(
                                        title: Text(note.noteTitle),
                                        subtitle: RichText(
                                          text: TextSpan(
                                            text:
                                                note.noteDate.substring(0, 10) +
                                                    "  ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: note.noteDescription ??
                                                      " ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ))),
                              );
                            })),
                  ],
                );
        }));
  }
}

class CustomTextFormFieldNote extends StatelessWidget {
  const CustomTextFormFieldNote({
    Key key,
    @required this.controller,
    @required this.hintText,
    this.defaultText,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String defaultText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(CentralSize.generalPadding),
      child: TextFormField(
        minLines: 10,
        maxLines: 10,
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(CentralSize.borderradius),
            ),
            fillColor: Colors.blueGrey[100],
            filled: true,
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.clear_outlined,
                size: CentralSize.iconSize,
                color: Colors.red,
              ),
              onPressed: () {
                controller.text = '';
              },
            ),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black)),
        onSaved: (String value) {},
        maxLength: 100,
      ),
    );
  }
}
