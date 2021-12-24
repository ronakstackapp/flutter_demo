import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';




class FilePickerScreen extends StatefulWidget {
  const FilePickerScreen({Key? key}) : super(key: key);

  @override
  _FilePickerScreenState createState() => _FilePickerScreenState();
}

class _FilePickerScreenState extends State<FilePickerScreen> {
  String fileType = 'All';
  var fileTypeList = ['All', 'Image', 'Video', 'pdf','MultipleFile'];

  FilePickerResult? result;
  PlatformFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Selected File Type:  ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                DropdownButton(
                  value: fileType,
                  items: fileTypeList.map((String type) {
                    return DropdownMenuItem(
                        value: type,
                        child: Text(
                          type,
                          style: TextStyle(fontSize: 20),
                        ));
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      fileType = value!;
                      file = null;
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                pickFiles(fileType);
              },
              child: Text('Pick file'),
            ),
            ///Show_DETAILS***********
            if (file != null) fileDetails(file!),

            ///Click_button_shoe+doc
            if (file != null) ElevatedButton(onPressed: (){viewFile(file!);},child: Text('View Selected File'),)
          ],
        ),
      ),
    );
  }

  Widget fileDetails(PlatformFile file){
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final size  = (mb>=1)?'${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('File Name: ${file.name}'),
          Text('File Size: $size'),
          Text('File Extension: ${file.extension}'),
          Text('File Path: ${file.path}'),
        ],
      ),
    );

  }

  void pickFiles(String? filetype) async {
    switch (filetype) {
      case 'Image':
        result = await FilePicker.platform.pickFiles(type: FileType.image);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'Video':
        result = await FilePicker.platform.pickFiles(type: FileType.video);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;

      case 'pdf':
        result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['pdf','doc'],);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'All':
        result = await FilePicker.platform.pickFiles();
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'MultipleFile':
        result = await FilePicker.platform.pickFiles(allowMultiple: true);
        if (result == null) return;
        loadSelectedFiles(result!.files);
        break;
    }
  }

  // multiple file selected
  // navigate user to 2nd screen to show selected files
  void loadSelectedFiles(List<PlatformFile> files){
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => FileList(files: files, onOpenedFile:viewFile ))
    );
  }

  // open the picked file
  void viewFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}

///Only_MultipleFile_Section
class FileList extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;

  const FileList({Key? key, required this.files, required this.onOpenedFile})
      : super(key: key);

  @override
  _FileListState createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Selected Files'),
      ),
      body: ListView.builder(
          itemCount: widget.files.length,
          itemBuilder: (context, index) {
            final file = widget.files[index];

            return buildFile(file);
          }),
    );
  }

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final size = (mb >= 1)
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
    return InkWell(
      onTap: () => widget.onOpenedFile(file),
      child: ListTile(
        leading: (file.extension == 'jpg' || file.extension == 'png')
            ? Image.file(
          File(file.path.toString()),
          width: 80,
          height: 80,
        )
            : Container(
          width: 80,
          height: 80,
        ),
        title: Text('${file.name}'),
        subtitle: Text('${file.extension}'),
        trailing: Text(
          '$size',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}