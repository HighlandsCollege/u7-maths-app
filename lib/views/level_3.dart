import 'package:app/models/data_model.dart';
import 'package:app/services/score.dart';
import 'package:app/utils/shuffle.dart';
import '../components/page_navigator.dart';
import '../services/data.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/wrapper.dart';
import '../components/progress_bar.dart';
import 'results.dart';

class Level3 extends StatefulWidget {
  Level3({Key key}) : super(key: key);

  @override
  _Level3 createState() => _Level3();
}

class _Level3 extends State<Level3> {
  String key;
  Tion tion;
  List<int> shuffled;
  int selectedNumber;

  @override
  void didChangeDependencies() {
    var state = context.watch<DataHandler>();

    if (state.questions != null) {
      tion = state.questions[2];
      shuffled = shuffle([tion.answer, ...tion.buffer]);
    }

    super.didChangeDependencies();
  }
  
  void _verifyAnswer(BuildContext ctx, int number) {
    if (tion.answer == number) {
      ctx.read<ScoreHandler>().increment();
    }

    navigate(ctx, Results());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Wrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Level 3',
              style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[200]
              )
            ),
            Text(
              '${tion.question}',
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[200]
              )
            ),
            ProgressBar(begin: 200 / 3 + 200 / 3, end: 200),
            Spacer(),
            Container(
              height: size.width,
              width: size.width,
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(4, (index) => 
                  Center(
                    child: GestureDetector(
                      onTap: () => setState(() {
                        selectedNumber = shuffled[index];
                      }),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: selectedNumber == shuffled[index] ? Color(0xff6C63FF) : Colors.grey[200],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10)
                          )
                        ),
                        child: Center(
                          child: Text(
                            '${shuffled[index]}',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800]
                            )
                          )
                        ),
                      ),
                    ),
                  )
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () => _verifyAnswer(context, selectedNumber),
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: selectedNumber == null ? Colors.grey[500] : Colors.grey[200],
                  borderRadius: BorderRadius.all(
                    Radius.circular(10)
                  )
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                    child: Text(
                      'Verify answer',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800]
                      )
                    )
                  )
                ),
              )
            )
          ],
        )
      )
    );
  }
}
