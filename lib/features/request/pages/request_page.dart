import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

enum RequestType { info, request, thanks, complaint }

extension RequestTypeX on RequestType {
  String get label => switch (this) {
        RequestType.info => 'BİLGİ',
        RequestType.request => 'TALEP',
        RequestType.thanks => 'TEŞEKKÜR',
        RequestType.complaint => 'ŞİKAYET',
      };

  IconData get icon => switch (this) {
        RequestType.info => Icons.info_outline,
        RequestType.request => Icons.help_outline,
        RequestType.thanks => Icons.front_hand,
        RequestType.complaint => Icons.error_outline,
      };
}

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  RequestType _type = RequestType.info;
  final _formKey = GlobalKey<FormState>();
  String? _neighborhood;
  String? _street;

  static const _neighborhoods = [
    'Merkez Mh.',
    'Çatalmeşe Mh.',
    'Ekşioğlu Mh.',
    'Hamidiye Mh.',
    'Hüseyinli Mh.',
    'Kirazlıdere Mh.',
    'Mehmet Akif Mh.',
    'Mimar Sinan Mh.',
    'Soğukpınar Mh.',
    'Taşdelen Mh.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text('Talep Gönder', style: AppTextStyles.h3),
        centerTitle: true,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            _sectionHeader('İçerik Türü', required: true),
            const SizedBox(height: 8),
            _typeSelector(),
            const SizedBox(height: 24),
            _sectionHeader('Kişisel Bilgiler'),
            const SizedBox(height: 12),
            _input('TC Kimlik No', required: true, keyboard: TextInputType.number, maxLength: 11),
            _input('Ad Soyad', required: true),
            _input('Cep Telefonu', required: true, keyboard: TextInputType.phone, hint: '(___) ___ __ __'),
            _input('E-Mail', keyboard: TextInputType.emailAddress),
            const SizedBox(height: 16),
            _sectionHeader('Talep / Şikayet Adres Bilgileri'),
            const SizedBox(height: 12),
            _dropdown('Mahalle', _neighborhoods, _neighborhood, required: true,
                onChanged: (v) => setState(() => _neighborhood = v)),
            _dropdown('Cadde / Sokak', const ['Atatürk Cad.', 'İnönü Cad.', 'Mareşal Fevzi Çakmak Cad.'], _street,
                required: true, onChanged: (v) => setState(() => _street = v)),
            _input('Dış Kapı No'),
            _input('İç Kapı No'),
            _input('Ek Adres'),
            const SizedBox(height: 16),
            _sectionHeader('İçerik Bilgileri'),
            const SizedBox(height: 12),
            _input('Açıklama', required: true, maxLines: 5),
            const SizedBox(height: 8),
            _photoPicker(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Talebi Gönder', style: AppTextStyles.bodyBold.copyWith(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, {bool required = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Row(
        children: [
          Text(title.toUpperCase(),
              style: AppTextStyles.bodyBold.copyWith(color: AppColors.textPrimary)),
          if (required) const Text(' *', style: TextStyle(color: AppColors.error, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _typeSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: RequestType.values.map((t) {
        final selected = _type == t;
        return GestureDetector(
          onTap: () => setState(() => _type = t),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? AppColors.primary.withValues(alpha: 0.1) : AppColors.surface,
              border: Border.all(
                color: selected ? AppColors.primary : AppColors.border,
                width: selected ? 1.5 : 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(t.icon, size: 16, color: selected ? AppColors.primary : AppColors.textSecondary),
                const SizedBox(width: 6),
                Text(t.label,
                    style: AppTextStyles.caption.copyWith(
                      color: selected ? AppColors.primary : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _input(String label,
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
            keyboardType: keyboard,
            maxLines: maxLines,
            maxLength: maxLength,
            inputFormatters: keyboard == TextInputType.number
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

  Widget _dropdown(String label, List<String> items, String? value,
      {bool required = false, required ValueChanged<String?> onChanged}) {
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
          DropdownButtonFormField<String>(
            initialValue: value,
            isExpanded: true,
            items: items.map((it) => DropdownMenuItem(value: it, child: Text(it))).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            ),
            validator: required ? (v) => (v == null) ? 'Zorunlu' : null : null,
          ),
        ],
      ),
    );
  }

  Widget _photoPicker() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border, style: BorderStyle.solid),
      ),
      child: Row(
        children: [
          const Icon(Icons.camera_alt, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Text('Fotoğraf veya Konum Ekle (opsiyonel)',
                style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
          ),
          const Icon(Icons.add_circle_outline, color: AppColors.primary),
        ],
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: AppColors.success, size: 56),
        title: const Text('Talebiniz Alındı'),
        content: const Text('En kısa sürede tarafınıza dönüş yapılacaktır.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }
}
