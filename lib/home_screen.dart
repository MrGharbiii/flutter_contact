import 'package:flutter/material.dart';

class Contact {
  String name;
  String phone;

  Contact({required this.name, required this.phone});
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Contact> contacts = [
    Contact(name: 'Wajdi Zakhama', phone: '99877558'),
    Contact(name: 'Ahmed Dziri', phone: '96056564'),
    Contact(name: 'Glovo', phone: '78556468'),
  ];

  void _editContact(int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final _nameController =
            TextEditingController(text: contacts[index].name);
        final _phoneController =
            TextEditingController(text: contacts[index].phone);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Edit Name'),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Edit Phone Number'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        contacts[index].name = _nameController.text;
                        contacts[index].phone = _phoneController.text;
                      });
                      Navigator.pop(context); // Close bottom sheet
                    },
                    child: Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        contacts.removeAt(index);
                      });
                      Navigator.pop(context); // Close bottom sheet
                    },
                    child: Text('Delete', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _callContact(String phone) {
    print('Calling $phone'); // In a real app, use url_launcher to make a call.
  }

  void _addContact() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final _nameController = TextEditingController();
        final _phoneController = TextEditingController();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    contacts.add(Contact(
                      name: _nameController.text,
                      phone: _phoneController.text,
                    ));
                  });
                  Navigator.pop(context); // Close bottom sheet
                },
                child: Text('Add Contact'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(contacts[index].name),
            background: Container(
              color: Colors.green,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16),
              child: Icon(Icons.phone, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.blue,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.edit, color: Colors.white),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                _callContact(contacts[index].phone);
                return false; // Prevent dismissal
              } else if (direction == DismissDirection.endToStart) {
                _editContact(index);
                return false; // Prevent dismissal
              }
              return false; // Prevent dismissal in any case
            },
            child: ListTile(
              title: Text(contacts[index].name),
              subtitle: Text(contacts[index].phone),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addContact,
        child: Icon(Icons.add),
      ),
    );
  }
}
