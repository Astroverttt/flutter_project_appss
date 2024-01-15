import 'package:flutter/material.dart';
import 'package:flutter_contact_appss/contact_service.dart';
import 'package:flutter_contact_appss/edit_form.dart';

// ... Import statements

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ContactService contactService = ContactService();
  List data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });

    List getData = await contactService.getData();
    setState(() {
      data = getData;
      isLoading = false;
    });
  }

  void sortDataByName() {
    setState(() {
      data.sort((a, b) => a['name'].compareTo(b['name']));
    });
  }

  Map<String, List> groupDataByFirstLetter(List dataList) {
    Map<String, List> groupedData = {};

    for (var item in dataList) {
      String firstLetter = item['name'][0].toUpperCase();

      if (!groupedData.containsKey(firstLetter)) {
        groupedData[firstLetter] = [];
      }
      groupedData[firstLetter]!.add(item);
    }
    return groupedData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Apps',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.sort_by_alpha),
            onPressed: () {
              sortDataByName();
            },
          )
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: groupDataByFirstLetter(data)
                  .entries
                  .map((entry) => buildGroup(entry.key, entry.value))
                  .toList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addForm');
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget buildGroup(String firstLetter, List groupItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            firstLetter,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        ...groupItems.map((item) => Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    item['name'][0],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  '${item['name']}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Kelamin: ${item['gender']} \n'
                  'Phone: ${item['phone']} \n'
                  'Alamat: ${item['address']} \n'
                  'Hobi: ${item['hobby']} \n',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditForm(
                              data: item,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    IconButton(
                      onPressed: () {
                        contactService.deleteData(item);
                        getData();
                      },
                      icon: Icon(Icons.delete),
                    )
                  ],
                ),
              ),
            )),
        Divider(),
      ],
    );
  }
}
