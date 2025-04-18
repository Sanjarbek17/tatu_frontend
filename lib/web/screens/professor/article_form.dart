import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/article_provider.dart';
import '../../providers/submit_article_provider.dart';

class AddArticleScreen extends StatefulWidget {
  const AddArticleScreen({super.key});

  @override
  _AddArticleScreenState createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedSchoolYear;
  PlatformFile? _selectedFile;
  final bool _isLoading = false;

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
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text('Okay'),
                ),
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
        schoolYear: _selectedSchoolYear!,
        filePath: _selectedFile!.path!,
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
                    Navigator.of(ctx).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('Okay'),
                ),
              ],
            ),
      );
    } catch (error) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text('Error'),
              content: Text(error.toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text('Okay'),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Add Article')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              DropdownButtonFormField<String>(
                value: _selectedSchoolYear,
                items:
                    articleProvider.schoolYears
                        .map(
                          (year) => DropdownMenuItem(
                            value:
                                year.name, // Use the name property of SchoolYear
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
