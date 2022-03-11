import 'package:contacts_app/models/contacts.dart';
import 'package:contacts_app/pages/sign_up_page.dart';
import 'package:contacts_app/services/authentication_service.dart';
import 'package:contacts_app/services/download_service.dart';
import 'package:contacts_app/services/upload_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_button.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({Key? key}) : super(key: key);

  @override
  State<AddContacts> createState() => AddContactsState();
}

class AddContactsState extends State<AddContacts> {
  TextEditingController? controllerEmail = TextEditingController();
  TextEditingController? controllerPhone = TextEditingController();
  TextEditingController? controllerName = TextEditingController();
  bool? isLoading;
  List<Contact>? _contacts;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    context.read<DownloadService>().fetchData().then((value) {
      setState(() {
        isLoading = false;
        _contacts = value;
      });
    });
  }

  List<TableRow> createTable() {
    List<TableRow> _tableRow = [];
    _tableRow.add(TableRow(
      children: [
        tableCell("Name", Colors.blue),
        tableCell("Phone", Colors.blue),
        tableCell("Email", Colors.blue),
      ],
    ));
    for (var i = 0; i < _contacts!.length; i++) {
      _tableRow.add(TableRow(
        children: [
          tableCell(_contacts![i].getName(), Colors.white),
          tableCell(_contacts![i].getPhone(), Colors.white),
          tableCell(_contacts![i].getEmail(), Colors.white),
        ],
      ));
    }
    return _tableRow;
  }

  Widget textBox(String title, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(
          height: 12,
        ),
        TextField(
          controller: controller,
          obscureText: title == "Password" ? true : false,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Enter $title',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: InkWell(
            onTap: () {
              context.read<AuthenticationService>().signOut();
            },
            child: const Text("Add Contacts")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textBox("Name", controllerName!),
              const SizedBox(
                height: 12,
              ),
              textBox("Phone No", controllerPhone!),
              const SizedBox(height: 12),
              textBox("Email", controllerEmail!),
              const SizedBox(height: 12),
              CustomButton(
                title: "Save",
                icon: Icons.save,
                onTap: () async {
                  debugPrint(controllerEmail?.text);
                  debugPrint(controllerPhone?.text);
                  debugPrint(controllerName?.text);
                  context.read<Contact>().setEmail(controllerEmail?.text);
                  context.read<Contact>().setPhone(controllerPhone?.text);
                  context.read<Contact>().setName(controllerName?.text);
                  context
                      .read<UploadService>()
                      .uploadContacts(context)
                      .then((value) {
                    return ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Contact Saved")));
                  });
                  isLoading = true;
                  context.read<DownloadService>().fetchData().then((value) {
                    setState(() {
                      isLoading = false;
                      _contacts = value;
                    });
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              isLoading == true
                  ? Container()
                  : Table(
                      border: TableBorder.all(),
                      children: createTable(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget tableCell(String? title, Color? color) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    color: color ?? Colors.white,
    child: Center(
      child: Text(title!),
    ),
  );
}
