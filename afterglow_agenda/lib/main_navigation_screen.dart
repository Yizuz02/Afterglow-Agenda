import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'features/tasks/screens/task_screen.dart';
import 'features/calendar/screens/calendar_screen.dart';
import 'features/profile/screens/profile_screen.dart';

class MainNavigationScreen
        extends StatefulWidget {

    const MainNavigationScreen({
        super.key,
    });

    @override
    State<MainNavigationScreen>
            createState() =>
                    _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {

    int currentIndex = 0;

    late final List<Widget> pages;

    @override
    void initState() {
        super.initState();

        pages = const [
            HomeScreen(),
            TaskScreen(),
            CalendarScreen(),
            ProfileScreen(),
        ];
    }

    @override
    Widget build(BuildContext context) {

        return Scaffold(
            body: pages[currentIndex],

            bottomNavigationBar:
                    BottomNavigationBar(

                currentIndex: currentIndex,

                onTap: (index) {

                    setState(() {
                        currentIndex = index;
                    });

                },

                items: const [

                    BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Main',
                    ),

                    BottomNavigationBarItem(
                        icon: Icon(Icons.task),
                        label: 'Task',
                    ),

                    BottomNavigationBarItem(
                        icon: Icon(Icons.calendar_month),
                        label: 'Calendar',
                    ),

                    BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'Profile',
                    ),
                ],
            ),
        );
    }
}