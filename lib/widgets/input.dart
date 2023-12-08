import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CounterField extends StatefulWidget {
  const CounterField({Key? key}) : super(key: key);

  @override
  _CounterFieldState createState() => _CounterFieldState();
}

class _CounterFieldState extends State<CounterField> {
  TextEditingController _controller = TextEditingController();
  int _counter = 100;

  @override
  void initState() {
    super.initState();
    _controller.text = '$_counter';
  }

  void _updateCounter() {
    setState(() {
      _counter = int.tryParse(_controller.text) ?? 0;
    });
  }

  void _incrementCounter() {
    _updateCounter();
    setState(() {
      _counter += 100;
      _controller.text = '$_counter';
    });
  }

  void _decrementCounter() {
    _updateCounter();
    setState(() {
      _counter -= 100;
      if (_counter < 0) {
        _counter = 0;
      }
      _controller.text = '$_counter';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: _decrementCounter,
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: Text('-'),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Unidades',
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: _incrementCounter,
                style: ElevatedButton.styleFrom(primary: Colors.green),
                child: Text('+'),
              ),
            ],
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'OperationFee',
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Emoluments',
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Taxes',
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'LiquidationFee',
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'OtherFees',
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
