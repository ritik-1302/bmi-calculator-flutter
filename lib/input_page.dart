import 'package:bmi_calculator/results_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_content.dart';
import 'reuseable_card.dart';
import 'constants.dart';
import 'package:bmi_calculator/input_page.dart';
import 'package:bmi_calculator/calculator_brain.dart';

class InputPage extends StatefulWidget {




  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Color maleCardColor = inactiveCardColor;
  Color femaleCardColor = inactiveCardColor;
  int height=180;
  int weight=60;
  int age=16;

  void updateColour(int gender) {
    if (gender == 1) {
      if (maleCardColor == inactiveCardColor) {
        maleCardColor = activeCardColor;
        femaleCardColor = inactiveCardColor;
      } else {
        maleCardColor = inactiveCardColor;
      }
    } else {
      if (gender == 2) {
        if (femaleCardColor == inactiveCardColor) {
          femaleCardColor = activeCardColor;
          maleCardColor = inactiveCardColor;
        } else {
          femaleCardColor = inactiveCardColor;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                  child: ReusableCard(
                onPress: () {
                  setState(() {
                    updateColour(1);
                  });
                },
                cardChild:
                    IconContent(icon: FontAwesomeIcons.mars, label: 'MALE'),
                colour: maleCardColor,
              )),
              Expanded(
                child: ReusableCard(
                  onPress: () {
                    setState(() {
                      updateColour(2);
                    });
                  },
                  cardChild: IconContent(
                      icon: FontAwesomeIcons.venus, label: 'FEMALE'),
                  colour: femaleCardColor,
                ),
              )
            ],
          )),
          Expanded(child: ReusableCard(
            cardChild:Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget> [

                Center(
                  child: Text('HEIGHT',
                  style: labelTextStyle,),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      height.toString(),
                      style: kNumberTextStyle
                      ),


                    Text(
                      'cm',
                      style: labelTextStyle,
                    )
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 30 ),
                    thumbColor:   Color(0xffeb1555),
                    activeTrackColor: Colors.white,
                      overlayColor:   Color(0x29eb1555),

                  ),
                  child: Slider(value: height.toDouble(),
                              min: 120,
                              max: 220,

                      inactiveColor: Color(0xFF8D8E98),
                      onChanged:(double newValue){
                    setState(() {
                       height=newValue.round();
                    });

                      }),
                )


              ],
            ),
              colour: Color(0xFF1D1E33))),
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(child: ReusableCard(colour: Color(0xFF1D1E33),
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('WEIGHT',style:labelTextStyle,),
                    Text(age.toString(),style:kNumberTextStyle,),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          RoundIconButton(icon: FontAwesomeIcons.minus,
                                           onPressed: (){
                            setState(() {
                              age--;
                            });
                                           },),
                          SizedBox(width:10),
                          RoundIconButton(icon: FontAwesomeIcons.plus,
                            onPressed: (){
                    setState(() {
                    age++;
                    });
                    },),
                        ],

                      ),
                    ),

                  ],
              ),)),
              Expanded(child: ReusableCard(colour: Color(0xFF1D1E33),
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('AGE',style:labelTextStyle,),
                      Text(weight.toString(),style:kNumberTextStyle,),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            RoundIconButton(icon: FontAwesomeIcons.minus,
                              onPressed: (){
                                setState(() {
                                  weight--;
                                });
                              },),
                            SizedBox(width:10),
                            RoundIconButton(icon: FontAwesomeIcons.plus,
                              onPressed: (){
                                setState(() {
                                  weight++;
                                });
                              },),
                          ],

                        ),
                      ),

                    ],
                  ))),
            ],
          )),
          BottomButton(buttonTitle: 'CALCULATE' ,onTap: (){
            CalculatorBrian calc =CalculatorBrian(height:height,weight: weight );


            Navigator.push(context, MaterialPageRoute(builder: (context){
              return ResultsPage(
                bmiResult:calc.calculateBMI() ,
                resultText: calc.getResult() ,
                interpretation:calc.getInterpretation() ,
              );
            },),);
          },),
        ],
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  BottomButton({@required this.onTap,@required this .buttonTitle});

  final Function onTap;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(child: Text(buttonTitle,style: kLargeButtonTextStyle,)),
        color: Color(0xFFEB1555),
        margin: EdgeInsets.only(top: 10),
        width: double.infinity,
        height: 80.0,
        padding:EdgeInsets.only(bottom:20   ) ,
      ),
    );
  }
}


class RoundIconButton extends StatelessWidget {
  final IconData icon;
final Function onPressed;
  RoundIconButton({this.icon,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
child: Icon(icon),
      onPressed:onPressed,

      constraints: BoxConstraints.tightFor(
        width: 56,
            height: 56,
      ),
      shape: CircleBorder(),
      fillColor:Color(0xff4c4f5e) ,
    );
  }
}
