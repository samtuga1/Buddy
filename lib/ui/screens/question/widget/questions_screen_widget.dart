import 'package:Buddy/data/data.dart';
import 'package:Buddy/models/questions/response/list_questions_response.dart';
import 'package:Buddy/router/routes.dart';
import 'package:Buddy/ui/screens/question/question_detail_screen.dart';
import 'package:Buddy/ui/widgets/widgets.dart';
import 'package:Buddy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuestionsScreenWidget extends StatelessWidget {
  const QuestionsScreenWidget({
    super.key,
    required this.questions,
  });
  final ListQuestionsResponse questions;

  @override
  Widget build(BuildContext context) {
    return questions.result.isEmpty
        ? const Center(
            child: CustomText('Empty'),
          )
        : CustomListViewBuilder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            leading: Column(
              children: [
                21.verticalSpace,
                CustomTextFieldWidget(
                  contentPadding: const EdgeInsets.symmetric(vertical: 9),
                  prefixIcon: SvgPicture.asset(AppImages.search),
                  borderColor: context.getTheme.scaffoldBackgroundColor,
                  borderRadius: 31,
                  hintText: 'Search resources',
                  fillColor: const Color(0xFFF4F5F6),
                  filled: true,
                ),
                27.verticalSpace,
              ],
            ),
            itemCount: questions.result.length,
            itemBuilder: (ctx, index) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: QuestionWidget(
                question: questions.result[index],
                onTap: () => Navigator.of(context).pushNamed(
                  Routes.question_detail,
                  arguments: PageDetailParams(
                    questionId: questions.result[index].id,
                  ),
                ),
              ),
            ),
          );
  }
}
