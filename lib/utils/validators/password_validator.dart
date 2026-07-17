String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'Campo obrigatório';
  if (value.length < 6) return 'Senha deve ter ao menos 6 caracteres';
  return null;
}