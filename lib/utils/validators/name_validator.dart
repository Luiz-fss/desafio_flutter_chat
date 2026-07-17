String? validateName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Campo obrigatório';
  }

  if (value.trim().length < 3) {
    return 'Nome muito curto';
  }

  return null;
}
