import 'package:flutter/material.dart';

import '../../../shared/models/task.dart';
import '../services/task_service.dart';

class TaskScreen
        extends StatefulWidget {

    const TaskScreen({
        super.key,
    });

    @override
    State<TaskScreen> createState() =>
            _TaskScreenState();
}

class _TaskScreenState
        extends State<TaskScreen> {

    final TaskService taskService =
            TaskService();
     final _formKey = GlobalKey<FormState>();

    final titleController = TextEditingController();
    final durationController = TextEditingController();

    DateTime selectedDateTime = DateTime.now();

    Recurrence selectedRecurrence = Recurrence.none;

    int selectedColor = 0xFF2196F3;       

    final List<int> availableColors = [
        0xFFFF71CE,
        0xFF01CDFE,
        0xFF05FFA1,
        0xFFFFFB96,
        0xFFB967FF,
    ];

    Future<void> pickDateTime() async {
        final date = await showDatePicker(
            context: context,
            initialDate: selectedDateTime,
            firstDate: DateTime(2020),
            lastDate: DateTime(2100),
        );

        if (date == null) return;

        final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(
            selectedDateTime,
            ),
        );

        if (time == null) return;

        setState(() {
            selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
            );
        });
    }

    Future<void> createTask() async {
        if (!_formKey.currentState!.validate()) {
            return;
        }

        final duration =
            durationController.text.trim().isEmpty
                ? null
                : int.tryParse(
                    durationController.text,
                    );

        final task = Task(
            id: '',
            title: titleController.text.trim(),
            completed: false,
            color: selectedColor,
            dateTime: selectedDateTime,
            recurrence: selectedRecurrence,
            durationMinutes: duration,
            createdAt: DateTime.now(),
            updatedAt: null,
        );

        await taskService.createTask(task);

        titleController.clear();
        durationController.clear();

        setState(() {
            selectedDateTime = DateTime.now();
            selectedRecurrence = Recurrence.none;
            selectedColor = availableColors.first;
        });
    }

    @override
    Widget build(BuildContext context) {

        return Scaffold(

            appBar: AppBar(
                title: const Text(
                    'Tasks',
                ),
            ),

            body: Column(
                children: [
                    Padding(
                        padding: const EdgeInsets.all(16),
                        child: Form(
                            key: _formKey,
                            child: Column(
                            children: [

                                TextFormField(
                                controller: titleController,
                                decoration: const InputDecoration(
                                    labelText: 'Title',
                                ),
                                validator: (value) {
                                    if (value == null ||
                                        value.trim().isEmpty) {
                                    return 'Enter a title';
                                    }
                                    return null;
                                },
                                ),

                                const SizedBox(height: 12),

                                TextFormField(
                                controller: durationController,
                                keyboardType:
                                    TextInputType.number,
                                decoration: const InputDecoration(
                                    labelText:
                                        'Duration (minutes)',
                                ),
                                ),

                                const SizedBox(height: 12),

                                DropdownButtonFormField<
                                    Recurrence>(
                                value: selectedRecurrence,
                                decoration:
                                    const InputDecoration(
                                    labelText: 'Recurrence',
                                ),
                                items: Recurrence.values
                                    .map(
                                        (recurrence) =>
                                            DropdownMenuItem(
                                        value: recurrence,
                                        child: Text(
                                            recurrence.name,
                                        ),
                                        ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                    if (value == null) return;

                                    setState(() {
                                    selectedRecurrence =
                                        value;
                                    });
                                },
                                ),

                                const SizedBox(height: 12),

                                Row(
                                children: [

                                    Expanded(
                                    child: Text(
                                        selectedDateTime
                                            .toString(),
                                    ),
                                    ),

                                    ElevatedButton(
                                    onPressed:
                                        pickDateTime,
                                    child: const Text(
                                        'Select',
                                    ),
                                    ),
                                ],
                                ),

                                const SizedBox(height: 12),

                                Wrap(
                                spacing: 8,
                                children: availableColors
                                    .map(
                                        (color) => GestureDetector(
                                        onTap: () {
                                            setState(() {
                                            selectedColor =
                                                color;
                                            });
                                        },
                                        child: Container(
                                            width: 32,
                                            height: 32,
                                            decoration:
                                                BoxDecoration(
                                            color: Color(
                                                color,
                                            ),
                                            border:
                                                selectedColor ==
                                                        color
                                                    ? Border.all(
                                                        width:
                                                            3,
                                                        )
                                                    : null,
                                            ),
                                        ),
                                        ),
                                    )
                                    .toList(),
                                ),

                                const SizedBox(height: 16),

                                SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: createTask,
                                    child: const Text(
                                    'Create Task',
                                    ),
                                ),
                                ),
                            ],
                            ),
                        ),
                    ),   

                    Expanded(
                        child:
                                StreamBuilder<
                                        List<Task>>(
                            stream:
                                    taskService.getTasks(),

                            builder:
                                    (
                                        context,
                                        snapshot,
                                    ) {

                                if (!snapshot
                                        .hasData) {
                                    return const Center(
                                        child:
                                                CircularProgressIndicator(),
                                    );
                                }

                                final tasks =
                                        snapshot.data!;

                                if (tasks
                                        .isEmpty) {

                                    return const Center(
                                        child: Text(
                                            'No tasks',
                                        ),
                                    );

                                }

                                return ListView.builder(
                                    itemCount:
                                            tasks.length,

                                    itemBuilder:
                                            (
                                                context,
                                                index,
                                            ) {

                                        final task =
                                                tasks[index];

                                        return ListTile(

                                            leading: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [

                                                    Container(
                                                    width: 12,
                                                    height: 12,
                                                    color: Color(task.color),
                                                    ),

                                                    Checkbox(
                                                    value: task.completed,
                                                    onChanged: (value) {
                                                        taskService.toggleCompleted(
                                                        task.id,
                                                        value ?? false,
                                                        );
                                                    },
                                                    ),
                                                ],
                                            ),
                                            title: Text(
                                                task.title,
                                            ),
                                            subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [

                                                    Text(
                                                    task.dateTime.toString(),
                                                    ),

                                                    Text(
                                                    'Recurrence: ${task.recurrence.name}',
                                                    ),

                                                    if (task.durationMinutes != null)
                                                    Text(
                                                        'Duration: ${task.durationMinutes} min',
                                                    ),
                                                ],
                                            ),

                                            trailing:
                                                    IconButton(
                                                icon:
                                                        const Icon(
                                                    Icons.delete,
                                                ),

                                                onPressed:
                                                        () {

                                                    taskService
                                                            .deleteTask(
                                                        task.id,
                                                    );

                                                },
                                            ),
                                        );
                                    },
                                );
                            },
                        ),
                    ),
                ],
            ),
        );
    }
}