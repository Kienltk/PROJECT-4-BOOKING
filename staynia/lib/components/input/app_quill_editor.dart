import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/extension/app_extension.dart';
import 'package:staynia/extension/theme_extension.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

class QuillTextEditor extends StatefulWidget {
  final String? initialText;
  final Function(String)? onChanged;

  const QuillTextEditor({super.key, this.initialText, this.onChanged});

  @override
  State<QuillTextEditor> createState() => _QuillTextEditorState();
}

class _QuillTextEditorState extends State<QuillTextEditor> {
  late final QuillController _controller;

  @override
  void initState() {
    super.initState();
    _controller = QuillController.basic();

    if (widget.initialText != null && widget.initialText!.isNotEmpty) {
      _controller.document.insert(0, widget.initialText!);
    }

    _controller.addListener(() {
      final delta = _controller.document.toDelta();
      final deltaAsJson = delta.toJson(); 
      final html = QuillDeltaToHtmlConverter(deltaAsJson).convert();
      widget.onChanged?.call(html);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(defaultBorderRadious),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacitySafe(0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(defaultBorderRadious),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(defaultBorderRadious),
                ),
                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
              ),
              child: QuillSimpleToolbar(
                controller: _controller,
                config: QuillSimpleToolbarConfig(
                  showAlignmentButtons: true,
                  showBackgroundColorButton: true,
                  showBoldButton: false,
                  showItalicButton: true,
                  showUnderLineButton: true,
                  showListBullets: true,
                  showListNumbers: true,
                  showFontSize: true,
                  showFontFamily: true,
                  showColorButton: true,
                  showCodeBlock: true,
                  showLink: true,
                  showUndo: true,
                  showRedo: true,
                  showClearFormat: true,
                  multiRowsDisplay: true,
                  toolbarSectionSpacing: 4,
                  toolbarIconAlignment: WrapAlignment.start,
                  sectionDividerColor: context.primaryColor,
                ),
              ),
            ),
            Container(
              height: 250,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(defaultBorderRadious),
                ),
              ),
              child: QuillEditor.basic(
                controller: _controller,
                config: QuillEditorConfig(
                  placeholder: 'Enter content...',
                  expands: false,
                  padding: EdgeInsets.zero,
                  dialogTheme: QuillDialogTheme(
                    dialogBackgroundColor: context.scaffoldBackgroundColor,
                  ),
                  customStyles: DefaultStyles(
                    placeHolder: DefaultTextBlockStyle(
                      const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                      const HorizontalSpacing(0, 0),
                      const VerticalSpacing(0, 0),
                      const VerticalSpacing(0, 0),
                      null,
                    ),
                    paragraph: DefaultTextBlockStyle(
                      const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                      const HorizontalSpacing(0, 0),
                      const VerticalSpacing(0, 0),
                      const VerticalSpacing(0, 0),
                      null,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
