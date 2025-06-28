import 'package:flutter/material.dart';

class ExpandableList extends StatefulWidget {
  final List list_categ;
  final String percent;
  final double amount;

  const ExpandableList({
    super.key,
    required this.list_categ,
    required this.percent,
    required this.amount,
  });

  @override
  State<ExpandableList> createState() => _ExpandableListState();
}

class _ExpandableListState extends State<ExpandableList> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFCAC4D0), width: 1),
            ),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFEF7FF),
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            onPressed: () async {
              setState(() => _isExpanded = !_isExpanded);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      widget.list_categ[0].category.emoji,
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.list_categ[0].category.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        if (widget.list_categ[0].comment != null)
                          Text(
                            widget.list_categ[0].comment,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF49454F),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${widget.percent} %',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${widget.amount} ₽',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Container(width: 20),
                    Icon(
                      Icons.navigate_next,
                      color: Color(0xFFCAC4D0),
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Container(
            height:
            (widget.list_categ.length * 100 < 300)
                ? widget.list_categ.length * 100
                : 300,
            child: ExpandableListItem(list_categ: widget.list_categ),
          ),
      ],
    );
  }
}

class ExpandableListItem extends StatefulWidget {
  const ExpandableListItem({super.key, required this.list_categ});

  final list_categ;

  @override
  State<ExpandableListItem> createState() => _ExpandableListItemState();
}

class _ExpandableListItemState extends State<ExpandableListItem> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list_categ.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Color(0xFFE6DEE8),
            border: Border(
              bottom: BorderSide(color: Color(0xFFB1ACB6), width: 2),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      widget.list_categ[index].category.emoji,
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.list_categ[index].category.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        (widget.list_categ[index].comment != null)
                            ? Text(
                          widget.list_categ[index].comment,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF49454F),
                          ),
                        )
                            : Text(
                          ' ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF49454F),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${widget.list_categ[index].amount} ₽',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '${widget.list_categ[index].transactionDate.toString().split(' ')[1].split(':')[0]}:${widget.list_categ[index].transactionDate.toString().split(' ')[1].split(':')[1]}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Container(width: 20),
                    Icon(
                      Icons.navigate_next,
                      color: Color(0xFFCAC4D0),
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}