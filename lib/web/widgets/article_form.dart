import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tatu_frontend/web/constants.dart';
import '../providers/submit_article_provider.dart';
import '../services/school_year_service.dart';
import '../models/school_year.dart';

class AddArticleScreen extends StatefulWidget {
  static const routeName = '/add-article';

  const AddArticleScreen({super.key});

  @override
  _AddArticleScreenState createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  SchoolYear? _selectedSchoolYear;
  PlatformFile? _selectedFile;
  final bool _isLoading = false;
  List<SchoolYear> _schoolYears = [];

  @override
  void initState() {
    super.initState();
    _fetchSchoolYears();
  }

  Future<void> _fetchSchoolYears() async {
    final schoolYearService = SchoolYearService(baseUrl);
    try {
      final schoolYears = await schoolYearService.getAllSchoolYears();
      setState(() {
        _schoolYears = schoolYears;
      });
    } catch (error) {
      print('Error fetching school years: $error');
    }
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null) {
      setState(() {
        _selectedFile = result.files.first;
      });
    }
  }

  void _submitArticle() async {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _selectedSchoolYear == null ||
        _selectedFile == null) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text('Missing Information'),
              content: Text('Please fill all fields and select a file.'),
              actions: [
                TextButton(onPressed: () => context.pop(), child: Text('Okay')),
              ],
            ),
      );
      return;
    }

    final submitArticleProvider = Provider.of<SubmitArticleProvider>(
      context,
      listen: false,
    );

    try {
      await submitArticleProvider.submitArticle(
        title: _titleController.text,
        description: _descriptionController.text,
        schoolYear: _selectedSchoolYear!.id,
        fileBytes: _selectedFile!.bytes!,
        fileName: _selectedFile!.name,
      );

      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text('Success'),
              content: Text('Article submitted successfully!'),
              actions: [
                TextButton(
                  onPressed: () {
                    context.pop();
                    context.pop();
                  },
                  child: Text('Okay'),
                ),
              ],
            ),
      );
    } catch (error) {
      print('error submitting article: $error');
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text('Error'),
              content: Text(error.toString()),
              actions: [
                TextButton(onPressed: () => context.pop(), child: Text('Okay')),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Article')),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 4,
          vertical: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                maxLines: 5, // Allow more lines for the description
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ), // Increased padding
                ),
              ),
              DropdownButtonFormField<SchoolYear>(
                value: _selectedSchoolYear,
                items:
                    _schoolYears
                        .map(
                          (year) => DropdownMenuItem(
                            value: year,
                            child: Text(year.name),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSchoolYear = value;
                  });
                },
                decoration: InputDecoration(labelText: 'School Year'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickFile,
                child: Text(
                  _selectedFile == null ? 'Pick File' : 'Change File',
                ),
              ),
              if (_selectedFile != null)
                Text('Selected File: ${_selectedFile!.name}'),
              SizedBox(height: 20),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                    onPressed: _submitArticle,
                    child: Text('Submit Article'),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
