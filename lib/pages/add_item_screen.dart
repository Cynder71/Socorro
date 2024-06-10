import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/FirebaseStorageService.dart';
import 'package:flutter_app/utils/ImagePickerService.dart';
import 'package:image_picker/image_picker.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePickerService.pickImage();

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _uploadItem() async {
    if (_formKey.currentState!.validate() && _image != null) {
      String imageUrl = await FirebaseStorageService.uploadImage(_image!);
      await FirebaseFirestore.instance.collection('items').add({
        'name': _nameController.text,
        'imageUrl': imageUrl
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                _image == null ?
                    const Text('Nenhuma imagem selecionada') :
                    Image.file(_image!),
                ElevatedButton(onPressed: _pickImage, child: const Text('Selecionar Imagem')),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _uploadItem,
                  child: const Text('Adicionar Item')
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}