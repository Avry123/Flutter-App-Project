import 'package:flutter/material.dart';

// class ProjectDetails extends StatelessWidget {
//   final List<Map<String, dynamic>> projectData;

//   const ProjectDetails({Key? key, required this.projectData}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Project Details'),
//       ),
//       body: ListView.builder(
//         itemCount: projectData.length,
//         itemBuilder: (context, index) {
//           Map<String, dynamic> project = projectData[index];
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Card(
//               elevation: 5.0,
//               child: ListTile(
//                 title: Text(project['title'] ?? ''),
//                 subtitle: Text(project['shortDescription'] ?? ''),
//                 onTap: () {
//                   // Add navigation or any other action when the card is tapped
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class ProjectDetails extends StatelessWidget {
  final List<Map<String, dynamic>> projectDataList;

  const ProjectDetails({Key? key, required this.projectDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color stuff = Color(0xFF40A2E3);
    Color circle_color = Color(0xFFBBE2EC);

    return Column(
      children: [
        // Iterate through the list and create a ProjectDetails for each item
        for (var projectData in projectDataList)
          Container(
            width: double.infinity,
            height: 450,
            color: stuff,
            // Rest of your existing code...
          ),
      ],
    );
  }
}

