import 'package:image_picker/image_picker.dart';

Future<XFile?> selectImage() async {
  final ImagePicker _picker = ImagePicker();
  // Pick an image
  return await _picker.pickImage(source: ImageSource.gallery);
}