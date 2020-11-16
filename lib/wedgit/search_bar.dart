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
      this.defaultText = '输入您想搜索的内容',
      this.type,
      this.hint = '输入您想搜索的内容',
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
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Icon(
            Icons.backpack,
            size: 20,
            color: Colors.grey,
          ),
          Expanded(
              child: Container(
                  height: 80,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0x22000000),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    height: 30,
                    padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                    child: GestureDetector(
                      onTap: widget.inputBoxClick,
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
                                enabled: widget.type == SearchType.normal,
                                decoration: InputDecoration(
                                  hintText: widget.hint,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: -20),

                                ),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              )),
                          Container(
                            child: widget.type == SearchType.normal
                                ? Text('搜素')
                                : null,
                          )
                        ],
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}
