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

  List<Contact> filteredContacts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredContacts = contacts;
    searchController.addListener(_filterContacts);
  }

  void _filterContacts() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredContacts = contacts
          .where((contact) =>
              contact.name.toLowerCase().contains(query) ||
              contact.phone.contains(query))
          .toList();
    });
  }

  void _editContact(int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final _nameController =
            TextEditingController(text: filteredContacts[index].name);
        final _phoneController =
            TextEditingController(text: filteredContacts[index].phone);

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
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    filteredContacts[index].name = _nameController.text;
                    filteredContacts[index].phone = _phoneController.text;
                  });
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _callContact(String phone) {
    print('Calling $phone');
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
                    _filterContacts();
                  });
                  Navigator.pop(context);
                },
                child: Text('Add Contact'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmDeleteContact(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Contact'),
          content: Text(
              'Are you sure you want to delete ${filteredContacts[index].name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  contacts.remove(filteredContacts[index]);
                  _filterContacts(); // Refresh the filtered list
                });
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search contacts...',
            border: InputBorder.none,
          ),
          style: TextStyle(color: const Color.fromARGB(255, 168, 49, 49)),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredContacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(filteredContacts[index].name),
            subtitle: Text(filteredContacts[index].phone),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.call, color: Colors.green),
                  onPressed: () => _callContact(filteredContacts[index].phone),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _editContact(index),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _confirmDeleteContact(index),
                ),
              ],
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
