import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class AddContactsButton extends StatelessWidget {
  const AddContactsButton({
    Key? key,
    bool enabled = true,
    bool completed = false,
    required Function() onTap,
  })   : _enabled = enabled,
        _completed = completed,
        _onTap = onTap,
        super(key: key);

  final bool _enabled;
  final bool _completed;
  final Function() _onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: _onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              _completed ? Icons.check : Icons.person_add,
              color: _enabled ? primaryColor : Colors.grey,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              _completed ? 'Contato salvo' : 'Salvar aos contatos',
              style: textStyle.copyWith(
                  fontSize: 14, color: _enabled ? primaryColor : Colors.grey),
            )
          ],
        ));
  }
}
