import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../../mayor_message/data/mayor_message_api.dart';

class MayorContactPage extends ConsumerStatefulWidget {
  const MayorContactPage({super.key});

  @override
  ConsumerState<MayorContactPage> createState() => _MayorContactPageState();
}

class _MayorContactPageState extends ConsumerState<MayorContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _surname = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _title = TextEditingController();
  final _content = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _name.dispose();
    _surname.dispose();
    _email.dispose();
    _phone.dispose();
    _title.dispose();
    _content.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _email.text.trim();
    if (!RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$').hasMatch(email)) {
      _snack('Geçerli bir e-posta adresi giriniz');
      return;
    }
    var phone = _phone.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (phone.startsWith('90') && phone.length == 12) phone = phone.substring(2);
    if (phone.startsWith('0') && phone.length == 11) phone = phone.substring(1);
    if (!RegExp(r'^5\d{9}$').hasMatch(phone)) {
      _snack('Telefon numarası 5XX XXX XX XX formatında olmalıdır');
      return;
    }

    setState(() => _submitting = true);
    try {
      final ok = await ref.read(mayorMessageRepositoryProvider).send(
            name: _name.text.trim(),
            surname: _surname.text.trim(),
            phone: phone,
            email: email,
            title: _title.text.trim(),
            content: _content.text.trim(),
          );
      if (!mounted) return;
      setState(() => _submitting = false);
      _resultDialog(ok);
    } catch (e) {
      if (!mounted) return;
      setState(() => _submitting = false);
      _snack('Hata: $e');
    }
  }

  void _snack(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), backgroundColor: AppColors.error),
    );
  }

  void _resultDialog(bool ok) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        icon: Icon(
          ok ? Icons.check_circle : Icons.error_outline,
          color: ok ? AppColors.success : AppColors.error,
          size: 56,
        ),
        title: Text(ok ? 'Mesajınız İletildi' : 'Gönderilemedi'),
        content: Text(ok
            ? 'Sayın Başkanımıza mesajınız ulaştı. En kısa sürede tarafınıza dönüş yapılacaktır.'
            : 'Mesajınız şu an gönderilemedi. Lütfen daha sonra tekrar deneyin.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (ok) Navigator.pop(context);
            },
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: 'Başkana Mesaj Gönder',
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(AppStrings.mayorPhoto,
                        width: 48, height: 48, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sayın Başkanımız',
                            style: AppTextStyles.caption.copyWith(color: Colors.white70)),
                        Text(AppStrings.mayorName,
                            style: AppTextStyles.bodyBold.copyWith(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _input('Ad', _name, required: true),
            _input('Soyad', _surname, required: true),
            _input('E-Posta', _email,
                required: true,
                keyboard: TextInputType.emailAddress,
                hint: 'ornek@email.com'),
            _input('Cep Telefonu', _phone,
                required: true,
                keyboard: TextInputType.phone,
                hint: '5XX XXX XX XX',
                maxLength: 11),
            const SizedBox(height: 8),
            _input('Konu', _title, required: true),
            _input('Mesajınız', _content, required: true, maxLines: 6),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _submitting ? null : _submit,
              icon: _submitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                    )
                  : const Icon(Icons.send),
              label: Text(_submitting ? 'Gönderiliyor...' : 'Mesajı Gönder'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(String label, TextEditingController c,
      {bool required = false,
      TextInputType keyboard = TextInputType.text,
      String? hint,
      int maxLines = 1,
      int? maxLength}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(label, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600)),
            if (required) const Text(' *', style: TextStyle(color: AppColors.error)),
          ]),
          const SizedBox(height: 4),
          TextFormField(
            controller: c,
            keyboardType: keyboard,
            maxLines: maxLines,
            maxLength: maxLength,
            inputFormatters: keyboard == TextInputType.phone
                ? [FilteringTextInputFormatter.digitsOnly]
                : null,
            decoration: InputDecoration(
              hintText: hint,
              counterText: '',
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            ),
            validator: required ? (v) => (v == null || v.isEmpty) ? 'Zorunlu' : null : null,
          ),
        ],
      ),
    );
  }
}
