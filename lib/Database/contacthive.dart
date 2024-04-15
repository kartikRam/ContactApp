
import 'package:contactapp/Model/contactdata.dart';
import 'package:hive/hive.dart';

class ContactHive{

  // var contacts_data=[]

  add_contact(ContactData contact) async{
    Box ContactBox = Hive.box<ContactData>('ContactBoxData');
    ContactBox.add(contact);
    print("Contact saved");
  }

  get_contact_data() async {
    Box ContactBox = Hive.box<ContactData>('ContactBoxData');
    var data = ContactBox.values.toList();
    return data;
  }
  delete_contact(index) async{
    Box ContactBox = Hive.box<ContactData>('ContactBoxData');
    ContactBox.deleteAt(index);
  }
  update_contact(ContactData contact,int index) {
    Box ContactBox = Hive.box<ContactData>('ContactBoxData');
    ContactBox.putAt(index, contact);
  }

}