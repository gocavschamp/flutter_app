import 'package:flutter/material.dart';

enum SearchType { home, normal, homeLight }

class SearchBar extends StatefulWidget {
  final bool showBack;
  final SearchType type;

  final String defaultText;
  final String hint;
  final void Function() leftButtonClick;
  final void Function() rightButtonClick;
  final void Function() speakClick;
  final void Function() inputBoxClick;
  final ValueChanged<String> onchange;

  @override
  State<StatefulWidget> createState() => _SearchBarState();

  const SearchBar(
      {this.showBack = true,
      this.defaultText = '输入您想搜素的内容',
      this.type,
      this.hint,
      this.leftButtonClick,
      this.rightButtonClick,
      this.speakClick,
      this.inputBoxClick,
      this.onchange});
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        children: [
          Icon(
            Icons.backpack,
            size: 20,
            color: Colors.grey,
          ),
          Expanded(child:           Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: TextField(
                          controller: _controller,
                          maxLines: 1,
                          onChanged: widget.onchange,
                          decoration: InputDecoration(
                            hintText: widget.defaultText,
                          ),
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        )),
                    Container(
                      child: Text('搜素'),
                    )
                  ],
                ),
              ))
          )
        ],
      ),
    );
  }
}
