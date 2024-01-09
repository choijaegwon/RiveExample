import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// Toggle을 하면 춤을 추고, 버튼을 클릭하면 예정된 움직임 한번 실행되는 버전
class Bird extends StatefulWidget {
  const Bird({super.key});

  @override
  State<Bird> createState() => _BirdState();
}

class _BirdState extends State<Bird> {
  late StateMachineController _stmController;

  // Inputs를 보고 SMI 값을 찾아봄
  SMIBool? _dance;
  SMITrigger? _lookUp;

  @override
  void initState() {
    super.initState();
  }

  // Version 1
  void _onInit(Artboard art) {
    // Animations에 있는 StateMachine이름 birb
    _stmController = StateMachineController.fromArtboard(art, 'birb')
        as StateMachineController;
    art.addController(_stmController);
    // Inputs에 있는 dance
    _dance = _stmController.findSMI('dance');
    _lookUp = _stmController.findSMI('look up');
  }

  void toggleDance(bool newValue) {
    setState(
      () => _dance!.value = newValue,
    );
  }

  void triggerLookUp() {
    // fire()는 한번만 실행된다.
    _lookUp?.fire();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 100),
          const Text(
            'Toggle을 하면 춤을 추고, \n버튼을 클릭하면 예정된 움직임 한번 실행되는 버전',
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: RiveAnimation.asset(
                'assets/rives/bird.riv',
                onInit: _onInit,
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  const Text('Dance'),
                  Switch(
                    value: _dance == null ? false : _dance!.value,
                    onChanged: (value) => toggleDance(value),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  triggerLookUp();
                },
                child: const Text('look up'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
