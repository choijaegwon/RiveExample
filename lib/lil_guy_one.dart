import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// FloatingActionButton 버튼을 눌러서도 실행되고, board 안에 있는 Button을 버튼을 클릭하여도 되는 버전
class LilGuyone extends StatefulWidget {
  const LilGuyone({super.key});

  @override
  State<LilGuyone> createState() => _LilGuyoneState();
}

class _LilGuyoneState extends State<LilGuyone> {
  late StateMachineController _stmController;

  SMIInput<double>? _numberExampleInput;

  @override
  void initState() {
    super.initState();
  }

  // Version 1
  void _onInit(Artboard art) {
    // Animations에 있는 State Machine 1
    _stmController = StateMachineController.fromArtboard(art, 'State Machine 1')
        as StateMachineController;
    _stmController.isActive = true;
    art.addController(_stmController);
    // Inputs에 있는 Number 1
    _numberExampleInput =
        _stmController.findInput<double>('Number 1') as SMINumber;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _numberExampleInput?.value = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 100),
          const Text(
            'FloatingActionButton 버튼을 눌러서도 실행되고 \nboard 안에 있는 Button을 버튼을 클릭하여도 되는 버전',
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: RiveAnimation.asset(
                'assets/rives/lil_guy.riv',
                onInit: _onInit,
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                // // Update the play state when the widget's initialized
                // onInit: () => setState(() {}),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_numberExampleInput?.value != null &&
              _numberExampleInput!.value < 3) {
            _numberExampleInput?.value += 1;
          } else {
            _numberExampleInput?.value = 0;
          }
        },
        tooltip: 'Play',
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
