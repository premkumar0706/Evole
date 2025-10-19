import 'package:flutter/material.dart';
import '../theme/constants.dart';

class BasicInfoScreen extends StatefulWidget {
  const BasicInfoScreen({super.key});

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? currentStatus;
  String? highestQualification;
  String? fieldStream;
  String? yearOfCompletion;

  bool firstFormChecked = false;
  bool secondFormChecked = false;

  late final List<Map<String, dynamic>> textFeilds = [
    {
      "label": "Name",
      "controller": nameController,
      "cursorColor": Colors.black,
      "validator": (value) =>
          value!.trim().isEmpty ? 'Please enter your name' : null,
    },
    {
      "label": "DOB",
      "controller": dobController,
      "cursorColor": Colors.black,
      "validator": (value) => value!.trim().isEmpty ? 'Please enter DOB' : null,
    },
    {
      "label": "Gender",
      "controller": genderController,
      "cursorColor": Colors.black,
      "validator": (value) =>
          value!.trim().isEmpty ? 'Please enter Gender' : null,
    },
    {
      "label": "Phone No",
      "controller": phoneController,
      "cursorColor": Colors.black,
      "vali
