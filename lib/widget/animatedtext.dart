import 'package:flutter/material.dart';

// class AnimatedTextFieldDemo extends StatefulWidget {
//   @override
//   _AnimatedTextFieldDemoState createState() => _AnimatedTextFieldDemoState();
// }

// class _AnimatedTextFieldDemoState extends State<AnimatedTextFieldDemo>
//     with SingleTickerProviderStateMixin {
//   late TextEditingController _textController;
//   late AnimationController _animationController;
//   late Animation<double> _opacityAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _textController = TextEditingController();
//     _animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 300));
//     _opacityAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
//     );

//     _textController.addListener(() {
//       if (_textController.text.isNotEmpty) {
//         _animationController.forward();
//       } else {
//         _animationController.reverse();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _textController.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Complex Animated TextField'),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Colors.blue,
//                   Colors.purple,
//                 ],
//               ),
//             ),
//           ),
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: AnimatedBuilder(
//                 animation: _animationController,
//                 builder: (context, child) {
//                   return Opacity(
//                     opacity: _opacityAnimation.value,
//                     child: child,
//                   );
//                 },
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12.0),
//                     border: Border.all(
//                       color: Colors.blueAccent,
//                       width: 2.0,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: Offset(0, 3), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: TextField(
//                     controller: _textController,
//                     style: TextStyle(color: Colors.black),
//                     decoration: InputDecoration(
//                       hintText: 'Enter your text',
//                       border: InputBorder.none,
//                       icon: Icon(Icons.search, color: Colors.grey),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class AnimatedTextFieldDemo extends StatefulWidget {
//   @override
//   _AnimatedTextFieldDemoState createState() => _AnimatedTextFieldDemoState();
// }

// class _AnimatedTextFieldDemoState extends State<AnimatedTextFieldDemo>
//     with SingleTickerProviderStateMixin {
//   late TextEditingController _textController;
//   late AnimationController _animationController;
//   late Animation<double> _opacityAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _textController = TextEditingController();
//     _animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 300));
//     _opacityAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
//     );

//     _textController.addListener(() {
//       if (_textController.text.isNotEmpty) {
//         _animationController.forward();
//       } else {
//         _animationController.reverse();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _textController.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sophisticated Animated TextField'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: AnimatedBuilder(
//             animation: _animationController,
//             builder: (context, child) {
//               return Opacity(
//                 opacity: _opacityAnimation.value,
//                 child: child,
//               );
//             },
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12.0),
//                 border: Border.all(
//                   color: Colors.blueAccent,
//                   width: 2.0,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                     offset: Offset(0, 3), // changes position of shadow
//                   ),
//                 ],
//               ),
//               child: TextField(
//                 controller: _textController,
//                 style: TextStyle(color: Colors.black),
//                 decoration: InputDecoration(
//                   hintText: 'Enter your text',
//                   border: InputBorder.none,
//                   icon: Icon(Icons.search, color: Colors.grey),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// class AnimatedTextFieldDemo extends StatefulWidget {
//   @override
//   _AnimatedTextFieldDemoState createState() => _AnimatedTextFieldDemoState();
// }

// class _AnimatedTextFieldDemoState extends State<AnimatedTextFieldDemo>
//     with SingleTickerProviderStateMixin {
//   late TextEditingController _textController;
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _textController = TextEditingController();
//     _animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 300));
//     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
//     );

//     _textController.addListener(() {
//       if (_textController.text.isNotEmpty) {
//         _animationController.forward();
//       } else {
//         _animationController.reverse();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _textController.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chic Animated TextField'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: AnimatedBuilder(
//             animation: _animationController,
//             builder: (context, child) {
//               return Transform.scale(
//                 scale: _scaleAnimation.value,
//                 child: child,
//               );
//             },
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               decoration: BoxDecoration(
//                 color: Colors.indigo.shade50,
//                 borderRadius: BorderRadius.circular(8.0),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.indigo.withOpacity(0.3),
//                     spreadRadius: 1,
//                     blurRadius: 1,
//                     offset: Offset(0, 0), // changes position of shadow
//                   ),
//                 ],
//               ),
//               child: TextField(
//                 controller: _textController,
//                 style: const TextStyle(color: Colors.black),
//                 decoration: const InputDecoration(
//                   hintText: 'Enter your text',
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class FlightAnimationPage extends StatefulWidget {
  @override
  _FlightAnimationPageState createState() => _FlightAnimationPageState();
}

class _FlightAnimationPageState extends State<FlightAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..forward();

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navigate to detail page or next screen
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Animation'),
      ),
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          // Your animation logic goes here
          return Transform.translate(
            offset: Offset(
                0.0, MediaQuery.of(context).size.height * _animation.value),
            child: Container(
              // Your airplane widget goes here
              width: 100,
              height: 100,
              color: Colors.blue,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
// class FuturisticTextFieldDemo extends StatefulWidget {
//   @override
//   _FuturisticTextFieldDemoState createState() =>
//       _FuturisticTextFieldDemoState();
// }

// class _FuturisticTextFieldDemoState extends State<FuturisticTextFieldDemo> {
//   late TextEditingController _textController;

//   @override
//   void initState() {
//     super.initState();
//     _textController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Futuristic Text Field'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12.0),
//                   color: Colors.grey.shade200,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: TextField(
//                   controller: _textController,
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     color: Colors.black,
//                   ),
//                   decoration: InputDecoration(
//                     hintText: 'Enter your text...',
//                     hintStyle: TextStyle(
//                       fontSize: 20.0,
//                       color: Colors.grey,
//                     ),
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               ElevatedButton(
//                 onPressed: () {
//                   // Perform action here
//                 },
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// class AnimatedTextFieldDemo extends StatefulWidget {
//   @override
//   _AnimatedTextFieldDemoState createState() => _AnimatedTextFieldDemoState();
// }

// class _AnimatedTextFieldDemoState extends State<AnimatedTextFieldDemo>
//     with SingleTickerProviderStateMixin {
//   late TextEditingController _textController;
//   late AnimationController _animationController;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _textController = TextEditingController();
//     _animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 100));
//     _animation = Tween<double>(begin: 1.0, end: 0.8).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
//     );

//     _textController.addListener(() {
//       if (_textController.text.isNotEmpty) {
//         _animationController.forward();
//       } else {
//         _animationController.reverse();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _textController.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Animated TextField'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: AnimatedBuilder(
//             animation: _animation,
//             builder: (context, child) {
//               return Transform.scale(
//                 scale: _animation.value,
//                 child: child,
//               );
//             },
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8.0),
//                 border: Border.all(
//                   color: Colors.blue,
//                   width: 2.0,
//                 ),
//               ),
//               child: TextField(
//                 controller: _textController,
//                 decoration: InputDecoration(
//                   hintText: 'Enter your text',
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// class AnimatedTextFieldDemo extends StatefulWidget {
//   @override
//   _AnimatedTextFieldDemoState createState() => _AnimatedTextFieldDemoState();
// }

// class _AnimatedTextFieldDemoState extends State<AnimatedTextFieldDemo>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<Color?> _colorAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//     _colorAnimation = ColorTween(
//       begin: Colors.blue,
//       end: Colors.green,
//     ).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Animated TextField'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: AnimatedBuilder(
//             animation: _animationController,
//             builder: (context, child) {
//               return TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Enter your text',
//                   border: OutlineInputBorder(),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                         color: _colorAnimation.value ?? Colors.transparent),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           if (_animationController.status == AnimationStatus.completed) {
//             _animationController.reverse();
//           } else {
//             _animationController.forward();
//           }
//         },
//         child: Icon(Icons.play_arrow),
//       ),
//     );
//   }
// }

// class AnimatedTextFieldDemo extends StatefulWidget {
//   @override
//   _AnimatedTextFieldDemoState createState() => _AnimatedTextFieldDemoState();
// }

// class _AnimatedTextFieldDemoState extends State<AnimatedTextFieldDemo>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//     _animation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Animated TextField'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: AnimatedBuilder(
//             animation: _animation,
//             builder: (context, child) {
//               return Transform.scale(
//                 scale: _animation.value,
//                 child: child,
//               );
//             },
//             child: TextField(
//               decoration: InputDecoration(
//                 labelText: 'Enter your text',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           if (_animationController.status == AnimationStatus.completed) {
//             _animationController.reverse();
//           } else {
//             _animationController.forward();
//           }
//         },
//         child: Icon(Icons.play_arrow),
//       ),
//     );
//   }
// }



///vvcbşkldfmvdklvd//
  
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     const SizedBox(height: 8),
            //     Container(
            //       child: Column(
            //         children: [
            //           ListView.builder(
            //             shrinkWrap: true,
            //             itemCount: _depenses != null
            //                 ? _depenses
            //                     .where((depense) =>
            //                         depense.containerID == widget.container.id)
            //                     .length
            //                 : 0,
            //             itemBuilder: (context, index) {
            //               if (_depenses != null) {
            //                 List<Expense> depensesForContainer = _depenses
            //                     .where((depense) =>
            //                         depense.containerID == widget.container.id)
            //                     .toList();
            //                 Expense depense = depensesForContainer[index];
            //                 return Column(
            //                   children: [
            //                     GestureDetector(
            //                       onTap: () {
            //                         // Navigate to container details screen
            //                       },
            //                       child: Container(
            //                         margin: const EdgeInsets.symmetric(
            //                             vertical: 8.0, horizontal: 16.0),
            //                         decoration: BoxDecoration(
            //                           color: Colors.indigo.shade50,
            //                           borderRadius: const BorderRadius.only(
            //                               topRight: Radius.circular(5),
            //                               bottomRight: Radius.circular(5),
            //                               topLeft: Radius.circular(5),
            //                               bottomLeft: Radius.circular(5)),
            //                           boxShadow: const [
            //                             BoxShadow(
            //                               color: Colors.white,
            //                               offset: Offset(5, 5),
            //                               spreadRadius: 5.0,
            //                               blurRadius: 10.0,
            //                             )
            //                           ],
            //                         ),
            //                         child: Container(
            //                           margin: const EdgeInsets.only(
            //                               top: 10, left: 18),
            //                           child: Row(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.spaceBetween,
            //                             children: [
            //                               Column(
            //                                 children: [
            //                                   Row(
            //                                     children: [
            //                                       Column(
            //                                         crossAxisAlignment:
            //                                             CrossAxisAlignment
            //                                                 .start,
            //                                         children: [
            //                                           Container(
            //                                             width: 200,
            //                                             child: Text(
            //                                               depense.article,
            //                                               style: const TextStyle(
            //                                                   fontSize: 16,
            //                                                   color: Color
            //                                                       .fromARGB(255,
            //                                                           0, 0, 0),
            //                                                   fontWeight:
            //                                                       FontWeight
            //                                                           .bold),
            //                                               overflow: TextOverflow
            //                                                   .ellipsis,
            //                                             ),
            //                                           ),
            //                                           SizedText(
            //                                               text:
            //                                                   'creer le ${depense.createdAt}',
            //                                               color: Colors.green)
            //                                         ],
            //                                       ),
            //                                     ],
            //                                   ),
            //                                   const SizedBox(
            //                                     height: 15,
            //                                   ),
            //                                 ],
            //                               ),
            //                               Row(
            //                                 children: [
            //                                   Column(
            //                                     children: [
            //                                       Container(
            //                                         width: 70,
            //                                         height: 27,
            //                                         child: Center(
            //                                           child: Container(
            //                                             width: 200,
            //                                             child: Text(
            //                                               "${depense.total.toString()}FCFA",
            //                                               style: const TextStyle(
            //                                                   fontSize: 10,
            //                                                   color:
            //                                                       Colors.green,
            //                                                   fontWeight:
            //                                                       FontWeight
            //                                                           .bold),
            //                                               overflow: TextOverflow
            //                                                   .ellipsis,
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       )
            //                                     ],
            //                                   )
            //                                 ],
            //                               )
            //                             ],
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 );
            //               } else {
            //                 return const Center(
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     children: [
            //                       Icon(
            //                         Icons
            //                             .hourglass_empty, // Icone pour une liste vide
            //                         size: 48,
            //                         color: Color.fromARGB(255, 0, 0, 0),
            //                       ),
            //                       Text(
            //                         "Aucune dépense associée",
            //                         style: TextStyle(
            //                           fontSize: 16,
            //                           color: Color.fromARGB(255, 0, 0, 0),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ); // ou tout autre widget vide si la liste de dépenses est null
            //               }
            //             },
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),


            //edi//////

            // Widget _buildEditableField({
  //   required String label,
  //   required TextEditingController controller,
  //   bool isMultiline =
  //       false, // Ajout du paramètre isMultiline avec une valeur par défaut false
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         label,
  //         style: TextStyle(
  //           color: Colors.indigo,
  //           fontSize: 16.0,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       SizedBox(height: 8.0),
  //       Container(
  //         padding: EdgeInsets.all(8.0),
  //         decoration: BoxDecoration(
  //           color: Colors.indigo.shade50,
  //           borderRadius: BorderRadius.circular(8.0),
  //         ),
  //         child: isMultiline
  //             ? // Vérifie si le champ est multiligne
  //             TextField(
  //                 controller: controller,
  //                 enabled: _isEditing,
  //                 maxLines: null, // Permet un nombre illimité de lignes
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                 ),
  //                 decoration: InputDecoration(
  //                   border: InputBorder.none,
  //                 ),
  //               )
  //             : TextField(
  //                 controller: controller,
  //                 enabled: _isEditing,
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                 ),
  //                 decoration: InputDecoration(
  //                   border: InputBorder.none,
  //                 ),
  //               ),
  //       ),
  //       SizedBox(height: 16.0),
  //     ],
  //   );
  // }

  // Widget _buildEditableField({
  //   required String label,
  //   required TextEditingController controller,
  //   bool isMultiline = false,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         label,
  //         style: TextStyle(
  //           color: Colors.indigo.shade900,
  //           fontSize: 20.0,
  //           fontWeight: FontWeight.bold,
  //           letterSpacing: 1.5,
  //         ),
  //       ),
  //       SizedBox(height: 16.0),
  //       Container(
  //         padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
  //         decoration: BoxDecoration(
  //           color: Colors.indigo.shade100,
  //           borderRadius: BorderRadius.circular(20.0),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.indigo.withOpacity(0.3),
  //               spreadRadius: 3,
  //               blurRadius: 7,
  //               offset: Offset(0, 3),
  //             ),
  //           ],
  //         ),
  //         child: isMultiline
  //             ? TextField(
  //                 controller: controller,
  //                 enabled: _isEditing,
  //                 maxLines: null,
  //                 style: TextStyle(
  //                   color: Colors.indigo.shade900,
  //                   fontSize: 18.0,
  //                 ),
  //                 decoration: InputDecoration(
  //                   border: InputBorder.none,
  //                   hintText: 'Enter $label',
  //                   hintStyle: TextStyle(color: Colors.indigo.shade400),
  //                 ),
  //               )
  //             : TextField(
  //                 controller: controller,
  //                 enabled: _isEditing,
  //                 style: TextStyle(
  //                   color: Colors.indigo.shade900,
  //                   fontSize: 18.0,
  //                 ),
  //                 decoration: InputDecoration(
  //                   border: InputBorder.none,
  //                   hintText: 'Enter $label',
  //                   hintStyle: TextStyle(color: Colors.indigo.shade400),
  //                 ),
  //               ),
  //       ),
  //       SizedBox(height: 24.0),
  //     ],
  //   );
  // }
  //edit son///
          
