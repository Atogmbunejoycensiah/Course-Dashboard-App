import 'package:flutter/material.dart';

void main() {
  runApp(const CourseDashboardApp());
}

class CourseDashboardApp extends StatelessWidget {
  const CourseDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CourseDashboardHome(),
    );
  }
}

class CourseDashboardHome extends StatefulWidget {
  const CourseDashboardHome({super.key});

  @override
  State<CourseDashboardHome> createState() => _CourseDashboardHomeState();
}

class _CourseDashboardHomeState extends State<CourseDashboardHome> {
  int _currentIndex = 0;
  final List<String> _tabNames = ['Home', 'Courses', 'Profile'];
  double _buttonSize = 60.0;
  bool _isButtonTapped = false;
  String? _selectedCategory;
  final List<String> _categories = [
    'Computer Engineering',
    'Natural Resources',
    ' Information Technology',
    'Computer Science',
    'Health'
  ];

  final List<Map<String, dynamic>> _courses = [
    {
      'name': 'Introduction to Flutter',
      'instructor': 'Dr. Kwabena Adu',
      'icon': Icons.code,
      'color': Colors.blue
    },
    {
      'name': 'Data Structures',
      'instructor': 'Prof. Michael Opoku',
      'icon': Icons.data_array,
      'color': Colors.green
    },
    {
      'name': 'Web Development',
      'instructor': 'Dr. Emmanual Botchway',
      'icon': Icons.web,
      'color': Colors.orange
    },
    {
      'name': 'Machine Learning',
      'instructor': 'Prof. Ayitey Micheal',
      'icon': Icons.psychology,
      'color': Colors.purple
    },
    {
      'name': 'Digital Art',
      'instructor': 'Dr. Dawson',
      'icon': Icons.brush,
      'color': Colors.pink
    },
  ];

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit Confirmation'),
          content: const Text('Are you sure you want to exit the app?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // In a real app, you might want to exit the app
                // SystemNavigator.pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _animateButton() {
    setState(() {
      _isButtonTapped = true;
      _buttonSize = 80.0;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _isButtonTapped = false;
        _buttonSize = 60.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _showExitDialog,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: _buildAnimatedButton(),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return _buildCoursesTab();
      case 2:
        return _buildProfileTab();
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to the ${_tabNames[_currentIndex]} Tab',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text(
            'Explore courses, manage your profile, and more!',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          _buildCategoryDropdown(),
          if (_selectedCategory != null) ...[
            const SizedBox(height: 20),
            Text(
              'Selected Category: $_selectedCategory',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCoursesTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Available Courses',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _courses.length,
            itemBuilder: (context, index) {
              final course = _courses[index];
              return Card(
                margin:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ListTile(
                  leading: Icon(
                    course['icon'],
                    color: course['color'],
                    size: 32,
                  ),
                  title: Text(
                    course['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Instructor: ${course['instructor']}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Handle course selection
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProfileTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=80'),
          ),
          const SizedBox(height: 20),
          const Text(
            'Joyce Nsiah',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Information Technology Student',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 30),
          _buildCategoryDropdown(),
          if (_selectedCategory != null) ...[
            const SizedBox(height: 20),
            Text(
              'Interested in: $_selectedCategory',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: DropdownButtonFormField<String>(
        value: _selectedCategory,
        hint: const Text('Select a course category'),
        items: _categories.map((String category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(category),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedCategory = newValue;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedButton() {
    return AnimatedScale(
      scale: _isButtonTapped ? 1.2 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: _buttonSize,
        height: _buttonSize,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(_buttonSize / 2),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: _animateButton,
          tooltip: 'Enroll in a course',
        ),
      ),
    );
  }
}