import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../subject.dart';
import '../subject_provider.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({Key? key}) : super(key: key);

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _markController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _markController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Subject name is required';
    }
    if (value.trim().length < 2) {
      return 'Minimum 2 characters';
    }
    return null;
  }

  String? _validateMark(String? value) {
    if (value == null || value.isEmpty) {
      return 'Marks are required';
    }
    final mark = double.tryParse(value);
    if (mark == null) {
      return 'Enter a valid number';
    }
    if (mark < 0 || mark > 100) {
      return 'Marks must be 0-100';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      Future.delayed(const Duration(milliseconds: 300), () {
        final name = _nameController.text.trim();
        final mark = double.parse(_markController.text);

        final newSubject = Subject(name: name, mark: mark);
        context.read<SubjectProvider>().addSubject(newSubject);

        _nameController.clear();
        _markController.clear();

        setState(() => _isLoading = false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✓ $name added successfully!'),
            duration: const Duration(seconds: 2),
            backgroundColor: const Color(0xFF4CAF50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(16),
            behavior: SnackBarBehavior.floating,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'Add New Subject',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                  Text(
                    'Track your academic progress',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Subject Name Field
                  Text(
                    'Subject Name',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'e.g., Mathematics, English',
                      prefixIcon: const Icon(Icons.book),
                      prefixIconColor: Theme.of(context).primaryColor,
                    ),
                    validator: _validateName,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 24),

                  // Marks Field
                  Text(
                    'Marks Obtained',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _markController,
                    decoration: InputDecoration(
                      hintText: 'Enter marks (0-100)',
                      prefixIcon: const Icon(Icons.grade),
                      prefixIconColor: Theme.of(context).primaryColor,
                      suffixText: '/100',
                    ),
                    validator: _validateMark,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _submitForm(),
                  ),
                  const SizedBox(height: 32),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _submitForm,
                      icon: _isLoading
                          ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(
                              Colors.white.withOpacity(0.8),
                              ),
                            ),
                          )
                              : const Icon(Icons.add),
                      label: Text(
                        _isLoading ? 'Adding...' : 'Add Subject',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Grade Scale Box
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(
                    children: [
                    Icon(
                    Icons.info_outline,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                      Text(
                        'Grading Scale',
                        style:
                        Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _gradeRow('A', '80+', Colors.green),
                    const SizedBox(height: 10),
                    _gradeRow('B', '65 - 79', Colors.blue),
                    const SizedBox(height: 10),
                    _gradeRow('C', '50 - 64', Colors.orange),
                    const SizedBox(height: 10),
                    _gradeRow('F', 'Below 50', Colors.red),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _gradeRow(String grade, String range, Color color) {
    return Row(
      children: [
      Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            grade,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Text(
        range,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      ],
    );
  }
}