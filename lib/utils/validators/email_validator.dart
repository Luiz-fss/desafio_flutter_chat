String? validateEmail(String? value) {
  if (value == null || value.isEmpty) return 'Campo obrigatório';
  final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!regex.hasMatch(value)) return 'Email inválido';
  return null;
}
