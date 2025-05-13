import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tamam/shared/components/constants.dart';

import '../styles/colors.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.amberAccent,
      ),
    );

Widget myVerticalDivider() => Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: Container(
        width: 1.0,
        color: Colors.amberAccent,
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.white,
  bool isUpperCase = true,
  bool isClicked = false,
  double radius = 0.0,
  double? fSize,
  Color tColor = Colors.black,
  required Function()? function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: isClicked? background : Colors.amberAccent,
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        color: background,
        elevation: 0.8,
        hoverColor: Colors.amberAccent,
        hoverElevation: 0.8,
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: tColor, fontSize: fSize),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required String? Function(String?)? validate,
  Function(String)? onSubmit,
  Function(String)? onChange,
  Function()? suffixPressed,
  Function()? onTap,
  Color labelColor = Colors.white60,
  Color textColor = Colors.white,
  Color suffixColor = Colors.black,
  Color prefixColor = Colors.black,
  double labelSize = 20,
  double textSize = 20,
  bool isPassword = false,
  IconData? prefix,
  IconData? suffix,
  bool isClickable = true,
  BorderRadius radius = BorderRadius.zero,
  TextDirection textDirection = TextDirection.ltr,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      style: TextStyle(
        color: textColor,
        fontSize: textSize
      ),
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.greenAccent,
          ),
        ),
        alignLabelWithHint: true,
        label: Text(label, textDirection: textDirection, textAlign: TextAlign.right, style: TextStyle(fontSize: labelSize)),
        labelStyle: TextStyle(
          color: labelColor,
        ),
        prefixIcon: Icon(prefix, color: prefixColor,),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffix, color: suffixColor,),
              )
            : null,
        border: OutlineInputBorder(borderRadius: radius),
      ),
    );

Widget defaultArabicFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required String? Function(String?)? validate,
  Function(String)? onSubmit,
  Function(String)? onChange,
  Function()? suffixPressed,
  Function()? onTap,
  Color labelColor = Colors.white60,
  Color textColor = Colors.white,
  double labelSize = 20,
  double textSize = 20,
  bool isPassword = false,
  IconData? prefix,
  IconData? suffix,
  bool isClickable = true,
  BorderRadius radius = BorderRadius.zero,
  TextDirection textDirection = TextDirection.ltr,
}) =>
    TextFormField(
      inputFormatters: [ArabicNumbersInputFormatter()],
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      style: TextStyle(
        color: textColor,
        fontSize: textSize
      ),
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.greenAccent,
          ),
        ),
        alignLabelWithHint: true,
        label: Text(label, textDirection: textDirection, textAlign: TextAlign.right, style: TextStyle(fontSize: labelSize)),
        labelStyle: TextStyle(
          color: labelColor,
        ),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffix),
              )
            : null,
        border: OutlineInputBorder(borderRadius: radius),
      ),
    );

Widget newFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required String? Function(String?)? validate,
  Function(String)? onSubmit,
  Function(String)? onChange,
  Function()? suffixPressed,
  Function()? prefixPressed,
  Function()? onTap,
  bool isPassword = false,
  IconData? prefix,
  IconData? suffix,
  bool isClickable = true,
  Color labelColor = Colors.black,
  Color textColor = Colors.black,
  Color prefixColor = Colors.white,
  BorderRadius radius = BorderRadius.zero,
  int? maxLines,
  TextDirection textDirection = TextDirection.ltr,
  TextAlign textAlign = TextAlign.left,
}) =>
    TextFormField(
      inputFormatters: [ArabicNumbersInputFormatter()],
      scrollPhysics: const BouncingScrollPhysics(),
      maxLines: maxLines,
      textDirection: textDirection,
      textAlign: textAlign,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      style: TextStyle(
        color: textColor,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: labelColor,
        ),
        // prefixIcon: Icon(prefix, color: prefixColor),
        prefixIcon: IconButton(onPressed: prefixPressed, icon: Icon(prefix, color: prefixColor)),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffix),
              )
            : null,
      ),
    );

Widget dropdownMenu({
  required List<String> Items,
  required String hint,
  String? Function(String?)? validator,
  required Function(String?)? onChanged,
  required Function(String?)? onSaved,
  required Function()? suffixPressed,

}) => DropdownButtonFormField2<String>(
      isExpanded: true,
      style: const TextStyle(
        color: AccentColor,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      hint: Text(
        hint,
        style: const TextStyle(fontSize: 14, color: Colors.white),
      ),
      items: Items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select from the list.';
        }
        return null;
      },
      onChanged: (value) {
      },
      onSaved: (value) {
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );

// Widget newsBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
//     condition: list.length > 0,
//     builder: (context) => ListView.separated(
//       physics: const BouncingScrollPhysics(),
//       itemBuilder: (context, index) {
//         return buildArticleItem(list[index], context);
//       },
//       separatorBuilder: (context, index) => myDivider(),
//       itemCount: list.length,
//     ),
//     fallback: (context) => isSearch? Container() : const Center(child: CircularProgressIndicator())
// );

// Widget buildArticleItem(article, context) => InkWell(
//   onTap: () {
//     navigateTo(context, WebViewScreen(article['url']));
//   },
//   child:   Padding(
//
//     padding: const EdgeInsets.all(20.0),
//
//     child: Row(
//
//       children: [
//
//         Container(
//
//           width: 120.0,
//
//           height: 120.0,
//
//           decoration: BoxDecoration(
//
//             borderRadius: BorderRadius.circular(10.0),
//
//             image: DecorationImage(
//
//               image: NetworkImage('${article['urlToImage']}'),
//
//               fit: BoxFit.cover,
//
//             ),
//
//           ),
//
//         ),
//
//         const SizedBox(
//
//           width: 20.0,
//
//         ),
//
//         Expanded(
//
//           child: Container(
//
//             height: 120.0,
//
//             child: Column(
//
//               mainAxisSize: MainAxisSize.min,
//
//               mainAxisAlignment: MainAxisAlignment.start,
//
//               crossAxisAlignment: CrossAxisAlignment.start,
//
//               children:
//
//               [
//
//                 Expanded(
//
//                   child: Text(
//
//                     '${article['title']}',
//
//                     style: Theme.of(context).textTheme.displaySmall!,
//
//                     maxLines: 3,
//
//                     overflow: TextOverflow.ellipsis,
//
//                   ),
//
//                 ),
//
//                 Text(
//
//                   '${article['publishedAt']}',
//
//                   style: const TextStyle(
//
//                     color: Colors.grey,
//
//                   ),
//
//                 ),
//
//               ],
//
//             ),
//
//           ),
//
//         ),
//
//       ],
//
//     ),
//
//   ),
// );

buildSettingItem({
  required IconData icon,
  required String text,
  required Function function,
  Color textColor = Colors.white,
  Color iconColor = Colors.white,
}) =>
    InkWell(
      onTap: () {
        function();
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 30.0,
              color: iconColor,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: iconColor,
            ),
          ],
        ),
      ),
    );

// Widget lessonItemBuilder(model) => Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Center(
//               child: GestureDetector(
//             onTap: () {
// // print(model.sId);
//               showLessonBottomSheet(model!.sId!);
//             },
//             child: Container(
//               height: 120.0,
//               color: Colors.white.withOpacity(0.5),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
// // You might need this line
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           '${model.title}',
//                           style: const TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           textDirection: TextDirection.rtl,
//                         ),
//                         const SizedBox(
//                           height: 10.0,
//                         ),
//                         Text(
//                           'Unit ${model.unit}',
//                           style: TextStyle(
//                             fontSize: 15.0,
//                             color: Colors.grey[800],
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     ),
//                     const Spacer(),
//                     defaultButton(
//                       background: Colors.blue.withOpacity(0),
//                       tColor: Colors.blue,
//                       fSize: 16.0,
//                       radius: 20.0,
//                       width: 100,
//                       function: () {},
//                       text: 'Start',
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )),
//         ),
//       ],
//     );

// Widget buildItem(Map model, context) => Dismissible(
//   key: Key(model['id'].toString()),
//   child: Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: Row(
//       children: [
//         const CircleAvatar(
//           radius: 40.0,
//           child: Text(
//             'Fight',
//           ),
//         ),
//         const SizedBox(
//           width: 20.0,
//         ),
//         Expanded(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('${model['title']}',
//                   style: const TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   )),
//               Text(
//                 '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           width: 20.0,
//         ),
//         IconButton(
//           onPressed: () {
//             AppCubit.get(context)
//                 .updateDataInDatabase(status: 'done', id: model['id']);
//           },
//           icon: const Icon(
//             Icons.check_box,
//             color: Colors.green,
//           ),
//         ),
//         IconButton(
//           onPressed: () {
//             AppCubit.get(context)
//                 .updateDataInDatabase(status: 'deleted', id: model['id']);
//           },
//           icon: const Icon(
//             Icons.delete,
//             color: Colors.black45,
//           ),
//         ),
//       ],
//     ),
//   ),
//   onDismissed: (direction) {
//     AppCubit.get(context).deleteDataFromDatabase(id: model['id']);
//   },
// );

// Widget itemBuilder({required List<Map> tasks}) => ConditionalBuilder(
//     condition: tasks.isNotEmpty,
//     builder: (context) => ListView.separated(
//       itemBuilder: (context, index) => buildItem(tasks[index], context),
//       separatorBuilder: (context, index) => Container(
//         width: double.infinity,
//         height: 1.0,
//         color: Colors.grey[300],
//       ),
//       itemCount: tasks.length,
//     ),
//     fallback: (context) => const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.menu,
//             size: 100.0,
//             color: Colors.grey,
//           ),
//           Text(
//             'No fights Yet, Please Add Some Fights',
//             style: TextStyle(
//               fontSize: 16.0,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     ));


class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({
    super.key,
    required this.controller,
    required this.screenWidth,
    required this.screenRatio,
    required this.entries,
    required this.onSelected,
    this.title = '',
    this.showTitle = true,
    this.textColor = Colors.black,
    this.titleColor = Colors.black,
    this.textSize = 20,
    this.titleSize = 20,
    this.space = 10,
  });

  final String title;
  final Color textColor;
  final Color titleColor;
  final double textSize;
  final double titleSize;
  final TextEditingController controller;
  final double screenWidth;
  final double screenRatio;
  final List<DropdownMenuEntry> entries;
  final bool showTitle;

  // ignore: prefer_typing_uninitialized_variables
  final onSelected;
  final double space;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        if (showTitle)
          Container(
              margin: const EdgeInsets.all(5),
              child: Text(title,
                  style: TextStyle(fontSize: titleSize, color: titleColor))),
        SizedBox(
          height: space,
        ),
        SizedBox(
          width: max(screenWidth * screenRatio, 300),
          child: Container(
            margin: const EdgeInsets.all(5),
            child: Align(
              alignment: Alignment.center,
              child: DropdownMenu(
                textStyle: TextStyle(
                    fontSize: textSize, fontFamily: "Cairo", color: textColor),
                requestFocusOnTap: true,
                controller: controller,
                menuHeight: 200,
                enableFilter: true,
                onSelected: onSelected,
                width: screenWidth * screenRatio - 2 * 10,
                dropdownMenuEntries: entries,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}