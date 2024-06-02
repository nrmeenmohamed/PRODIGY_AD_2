import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import '../shared/components/components.dart';
import '../shared/styles/colors.dart';


class EditScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

   int id;
   int? done;
  var titleController;
  var descriptionController;
  var categoryController;


  EditScreen({super.key,
    required this.titleController,
    required this.descriptionController,
    required this.categoryController,
    required this.id,
    this.done,
  });


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {
        if (state is AppUpdateDatabaseState) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text(
                'Task Updated Successfully',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.sp,
              ),
            ),
              backgroundColor: AppColor.secondColor.withGreen(1),
            ),
          );
        }
      },
      builder: (BuildContext context, AppStates state) {

        var cubit = AppCubit.get(context);

        return  Scaffold(
          backgroundColor: AppColor.secondColor,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Image(
              image: const AssetImage("assets/images/logo.png"),
              width: 120.w,
              height: 50.h,
            ),
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.grey[100],
                      ),
                      padding: const EdgeInsetsDirectional.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            key: formKey,
                            child: FastFormSection(
                              header: Text(
                                'Edit Task',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.secondColor,
                                ),
                              ),
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 25.h,),
                                    Text(
                                      'title',
                                      textAlign:TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 5.h,),

                                    // important title
                                    fieldForm(
                                      initialValue:  titleController,
                                      onChanged: (value){
                                        titleController = value;
                                        debugPrint(titleController);
                                      },
                                    ),

                                    SizedBox(height: 15.h,),
                                    Text(
                                      'description',
                                      textAlign:TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 5.h,),

                                    // important description
                                    fieldForm(
                                      expanded: true,
                                      keyboardType: TextInputType.multiline,
                                      height: 100.h,
                                      initialValue: descriptionController,
                                      onChanged: (value){
                                        descriptionController = value;
                                        debugPrint(descriptionController);
                                      },
                                    ),

                                    SizedBox(height: 15.h,),
                                    Text(
                                      'category',
                                      textAlign:TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 5.h,),

                                    // drop
                                    dropDown(
                                        context,
                                        initialValue: categoryController,
                                        onChanged: (value){
                                          categoryController = value;
                                        },
                                    ),

                                    SizedBox(height: 15.h,),
                                    // add
                                    button(
                                      onPressed: (){
                                        if(formKey.currentState != null && formKey.currentState!.validate()){
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.question,
                                            animType: AnimType.rightSlide,
                                            title: 'save change',
                                            desc: 'are you sure .',
                                            btnOkText: 'save',
                                            btnOkColor: Colors.teal,
                                            btnCancelColor: AppColor.thirdColor,
                                            btnCancelOnPress: () {},
                                            btnOkOnPress: () {
                                              cubit.updateTask(
                                                  title: titleController,
                                                  description: descriptionController,
                                                  category: categoryController,
                                                id:id,
                                                done: cubit.checkBoxStatus,
                                              );
                                              Navigator.pop(context);
                                            },
                                          ).show();
                                        }
                                        else{
                                          debugPrint('can not navigate');
                                        }
                                      },
                                      text: 'done',
                                      backgroundColor: AppColor.secondColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
