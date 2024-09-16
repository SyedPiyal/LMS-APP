import 'package:flutter/material.dart';

import '../profile/profile_view.dart';

class DashboardScreen extends StatelessWidget {
  // Demo data
  final int coursesCount = 10;
  final int completedCourses = 5;
  final int ongoingCourses = 3;
  final int notificationsCount = 7;
  final List<String> recentActivities = [
    'Completed Assignment 1',
    'Started Course 2',
    'Reviewed Quiz 3',
  ];

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Pass the user ID to the profile screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(userId: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Statistics
            Card(
              child: ListTile(
                title: const Text(
                  'User Statistics',
                ),
                subtitle: Text(
                  'Courses: $coursesCount\nCompleted: $completedCourses',
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Course Progress
            Card(
              child: ListTile(
                title: const Text('Course Progress'),
                subtitle: Text('Ongoing Courses: $ongoingCourses'),
              ),
            ),
            const SizedBox(height: 16),

            // Notifications
            Card(
              child: ListTile(
                title: const Text('Notifications'),
                subtitle:
                    Text('You have $notificationsCount new notifications'),
              ),
            ),
            const SizedBox(height: 16),

            // Recent Activity
            Expanded(
              child: Card(
                child: Column(
                  children: [
                    const ListTile(
                      title: Text('Recent Activity'),
                      subtitle: Text(
                          'You completed the following activities recently:'),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: recentActivities.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(recentActivities[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
