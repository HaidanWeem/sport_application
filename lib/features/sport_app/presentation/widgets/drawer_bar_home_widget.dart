// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sport_app/common/main_colors.dart';
// import 'package:sport_app/features/sport_app/presentation/provider/provider_home/provider_home.dart';

// class DrawerBar extends StatefulWidget {
//   const DrawerBar({Key? key}) : super(key: key);

//   @override
//   State<DrawerBar> createState() => _DrawerBarState();
// }

// class _DrawerBarState extends State<DrawerBar> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//           const  Text(
//               'Language: ',
//               style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
//             ),
//             const SizedBox(height: 10),
//             DropdownButton2(
//               isExpanded: true,
//               hint: Padding(
//                 padding: const EdgeInsets.all(6.0),
//                 child: Row(
//                   children: const [
//                     Icon(
//                       Icons.language,
//                       size: 20,
//                       color: Colors.black,
//                     ),
//                     SizedBox(
//                       width: 4,
//                     ),
//                     Expanded(
//                       child: Text(
//                         'Select Item',
//                         style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.black,
//                             fontFamily: 'Poppins'),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               items: context
//                   .read<Home>()
//                   .itemsLanguages
//                   .map((item) => DropdownMenuItem<String>(
//                         value: item,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             item,
//                             style: const TextStyle(
//                                 fontSize: 14, fontFamily: 'Poppins'),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ))
//                   .toList(),
//               value: context.read<Home>().selectedValue,
//               onChanged: (value) {
//                 setState(
//                   () {
//                     context.read<Home>().selectedValue = value as String;
//                   },
//                 );
//               },
//               buttonHeight: 40,
//               buttonWidth: 180,
//               itemHeight: 40,
//               dropdownDecoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(14),
//                 color: Colors.grey,
//               ),
//               buttonDecoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(14),
//                 border: Border.all(
//                   color: Colors.black26,
//                 ),
//                 color: Colors.grey.shade300,
//               ),
//             ),
//             TextButton(
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(
//                     MainColors.mainBlack,
//                   ),
//                   overlayColor:
//                       MaterialStateProperty.all<Color>(MainColors.mainWhite)),
//               onPressed: () {
               
//               },
//               child:const SizedBox(
//                 width: double.infinity,
//                 child: Center(
//                   child: Text(
//                     'Save',
//                     style: TextStyle(
//                         color: MainColors.mainWhite, fontFamily: 'Poppins'),
//                   ),
//                 ),
//               ) ,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
