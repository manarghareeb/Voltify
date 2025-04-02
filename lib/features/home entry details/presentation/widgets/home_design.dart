import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voltify/features/const_themes.dart';
import 'package:voltify/features/home%20entry%20details/presentation/cubit/home_design_cubit.dart';

class HomeDesignWidget extends StatefulWidget {
  const HomeDesignWidget({super.key});

  @override
  State<HomeDesignWidget> createState() => _HomeDesignWidgetState();
}

class _HomeDesignWidgetState extends State<HomeDesignWidget> {
  bool isSelected = false;
  List<String> designs = [
    "https://piuqggnsgfrqlfbkugxx.supabase.co/storage/v1/object/public/voltify_images/home1.png",
    "https://piuqggnsgfrqlfbkugxx.supabase.co/storage/v1/object/public/voltify_images/home2.png",
    "https://piuqggnsgfrqlfbkugxx.supabase.co/storage/v1/object/public/voltify_images/home3.png",
    "https://piuqggnsgfrqlfbkugxx.supabase.co/storage/v1/object/public/voltify_images/home4.png",
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSize.height / 5,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: designs.length,
        itemBuilder: (context, i) {
          isSelected =
              BlocProvider.of<HomeDesignCubit>(context).selectedDesign == designs[i];
          return Padding(
            padding: EdgeInsets.all(ScreenSize.width / 40),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  BlocProvider.of<HomeDesignCubit>(context).selectedDesign =
                      designs[i];
                });
              },
              child: Container(
                width: ScreenSize.width / 2.3,
                height: ScreenSize.height / 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenSize.width / 30),
                  color: Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.kSecondaryColor
                        : Colors.transparent,
                    width: ScreenSize.width / 60,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      designs[i],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
