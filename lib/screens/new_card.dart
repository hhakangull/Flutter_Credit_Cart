import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:credit_cart/components/card_utilis.dart';
import 'package:credit_cart/extensions/string_ex.dart';
import 'package:credit_cart/utility/constains.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class NewCardScreen extends StatefulWidget {
  const NewCardScreen({Key? key}) : super(key: key);
  @override
  State<NewCardScreen> createState() => _NewCardScreenState();
}

class _NewCardScreenState extends State<NewCardScreen> {
  final TextEditingController _cardNumberController = TextEditingController();

  CreditCardType cardType = CreditCardType.unknown;

  void getCardType() {
    if (_cardNumberController.text.length <= 6) {
      CreditCardType type = detectCCType(_cardNumberController.text);
      if (type != cardType) {
        setState(() {
          cardType = type;
        });
      }
    }
  }

  @override
  void initState() {
    _cardNumberController.addListener(() {
      getCardType();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Credit Card"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: defaultPadding,
                      ),
                      child: TextFormField(
                        controller: _cardNumberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(19),
                          CardNumberInputFormatter(),
                        ],
                        decoration: InputDecoration(
                          hintText: "Card Number",
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(top: 6, left: 0, right: 15, bottom: 6),
                            child: SizedBox(
                              height: 15,
                              width: 15,
                              child: cardType == CreditCardType.unknown
                                  ? const Icon(
                                      Icons.error,
                                      color: Colors.grey,
                                    )
                                  : CartUtility().getCardIcon(cardType),
                            ),
                          ),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Icon(
                              Icons.credit_card_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: TextFormField(
                        inputFormatters: [
                          CapitalizeTextFormatter(),
                        ],
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Full name",
                          prefixIcon: Icon(
                            Icons.person_sharp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            decoration: InputDecoration(
                              hintText: "CVV",
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: SvgPicture.asset(
                                      "assets/icons/cvv.svg",
                                      color: Colors.grey,
                                      height: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: defaultPadding),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                              CardMonthInputFormatter()
                            ],
                            decoration: const InputDecoration(
                              hintText: "MM/YY",
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(vertical: 0),
                                child: SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    child: Icon(Icons.calendar_month_outlined),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Spacer(flex: 2),
              OutlinedButton.icon(
                style: const ButtonStyle(),
                onPressed: () {},
                icon: const Icon(
                  Icons.qr_code_scanner_rounded,
                  color: Colors.grey,
                ),
                label: const Text(
                  "Scan",
                  style: TextStyle(color: Colors.black54, fontSize: 18),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: defaultPadding),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Add card"),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
