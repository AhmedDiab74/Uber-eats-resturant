import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

FirebaseAuth auth = FirebaseAuth.instance;
ImagePicker picker = ImagePicker();
const Uuid uuid = Uuid();
FirebaseStorage storage = FirebaseStorage.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
const String collectionRestuarant = "Resturant";
const String collectionRestaurantUID = "restaurantUID";
