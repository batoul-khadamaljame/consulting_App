

import 'package:consulting_app/Bloc/enter_moblie_number_cubit.dart';
import 'package:consulting_app/Bloc/input_date_cubit.dart';
import 'package:consulting_app/UI/Widgets/input_field.dart';
import 'package:consulting_app/UI/Widgets/region_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class ExpertRegisterScreen extends StatelessWidget {
  const ExpertRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
  

//regester date and number

//  class RegisterExpertScreen extends StatelessWidget {
//   RegisterExpertScreen({Key? key}) : super(key: key);
//   final _mobileController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Builder(builder: (context) {
//       final state1 = context.watch<InputDateCubit>().state;
//       final state2 = context.watch<EnterMoblieNumberCubit>().state;

//       return Scaffold(
//         body: SafeArea(
//             child: Column(
//           children: [
//             //شغلك

//             TextFormField(
//               controller: _mobileController,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                 labelText: 'Mobile',
//                 hintText: '53 555 5555',
//                 border: const OutlineInputBorder(),
//                 prefixIcon: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                       child: RegionWidget(
//                         initialRegion: state2.region,
//                         onChange: (region) {
//                           context.read<EnterMoblieNumberCubit>().update(region);
//                         },
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     const VerticalDivider(color: Colors.grey),
//                   ],
//                 ),
//               ),
//             ),
//             InputField(
//               title: 'Date',
//               hint: DateFormat.yMd().format(state1.selectedDate),
//               widget: IconButton(
//                 onPressed: () {
//                   context.read<InputDateCubit>().getDateFromUser(context);
//                 },
//                 icon: const Icon(
//                   Icons.calendar_today_outlined,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: InputField(
//                     title: 'Start Time',
//                     hint: state1.startTime,
//                     widget: IconButton(
//                       onPressed: () {
//                         context.read<InputDateCubit>().getTimeFromUser(
//                             isStartTime: true, context: context);
//                       },
//                       icon: const Icon(
//                         Icons.access_time_rounded,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 12,
//                 ),
//                 Expanded(
//                   child: InputField(
//                     title: 'End Time',
//                     hint: state1.endTime,
//                     widget: IconButton(
//                       onPressed: () {
//                         context.read<InputDateCubit>().getTimeFromUser(
//                             isStartTime: false, context: context);
//                       },
//                       icon: const Icon(
//                         Icons.access_time_rounded,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         )),
//       );
//     });
//   }
// }
