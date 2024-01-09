import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// board 안에 있는 Button을 클릭하여 동작 시키는 버전
class LilGuyTwo extends StatefulWidget {
  const LilGuyTwo({super.key});

  @override
  State<LilGuyTwo> createState() => _LilGuyTwoState();
}

class _LilGuyTwoState extends State<LilGuyTwo> {
  late StateMachineController _stmController;

  @override
  void initState() {
    super.initState();
  }

  void _onInit(Artboard art) {
    _stmController = StateMachineController.fromArtboard(art, 'State Machine 1')
        as StateMachineController;

    _stmController.isActive = true;

    _stmController.addEventListener(onRiveEvent);

    art.addController(_stmController);
  }

  void onRiveEvent(RiveEvent event) {
    event.properties['Number 1' as double];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 100),
          const Text('board 안에 있는 Button을 클릭하여 동작 시키는 버전'),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: RiveAnimation.asset(
                'assets/rives/lil_guy.riv',
                onInit: _onInit,
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
