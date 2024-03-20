// import 'package:flutter/material.dart';
// import 'package:kairasahrl/auth/sign_in.dart';
// import 'package:kairasahrl/auth/sign_up.dart';

// class SignInSignUpAnimation extends StatefulWidget {
//   @override
//   _SignInSignUpAnimationState createState() => _SignInSignUpAnimationState();
// }

// class _SignInSignUpAnimationState extends State<SignInSignUpAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: Duration(milliseconds: 1500),
//       vsync: this,
//     );

//     // Démarrer l'animation lorsque l'écran est construit
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _triggerAnimation() {
//     if (_controller.isCompleted) {
//       _controller.reverse();
//     } else {
//       _controller.forward();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           SlideTransition(
//             position: Tween<Offset>(
//               begin: Offset(1, 0),
//               end: Offset.zero,
//             ).animate(
//               CurvedAnimation(
//                 parent: _controller,
//                 curve: Interval(0, 0.5, curve: Curves.easeInOut),
//               ),
//             ),
//             child: FadeTransition(
//               opacity: Tween<double>(
//                 begin: 0,
//                 end: 1,
//               ).animate(
//                 CurvedAnimation(
//                   parent: _controller,
//                   curve: Interval(0, 0.5, curve: Curves.easeInOut),
//                 ),
//               ),
//               child: SignInPage(
//                 onSignInPressed: _triggerAnimation,
//               ),
//             ),
//           ),
//           SlideTransition(
//             position: Tween<Offset>(
//               begin: Offset(-1, 0),
//               end: Offset.zero,
//             ).animate(
//               CurvedAnimation(
//                 parent: _controller,
//                 curve: Interval(0.5, 1, curve: Curves.easeInOut),
//               ),
//             ),
//             child: FadeTransition(
//               opacity: Tween<double>(
//                 begin: 0,
//                 end: 1,
//               ).animate(
//                 CurvedAnimation(
//                   parent: _controller,
//                   curve: Interval(0.5, 1, curve: Curves.easeInOut),
//                 ),
//               ),
//               child: SignUpPage(
//                 onBackToSignInPressed: _triggerAnimation,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
