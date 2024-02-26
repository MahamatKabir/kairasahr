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
class AnimatedTextFieldDemo extends StatefulWidget {
  @override
  _AnimatedTextFieldDemoState createState() => _AnimatedTextFieldDemoState();
}

class _AnimatedTextFieldDemoState extends State<AnimatedTextFieldDemo>
    with SingleTickerProviderStateMixin {
  late TextEditingController _textController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _textController.addListener(() {
      if (_textController.text.isNotEmpty) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chic Animated TextField'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                controller: _textController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: 'Enter your text',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
