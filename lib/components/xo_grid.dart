



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xo_game/components/xo_box.dart';

class XOGrid extends StatefulWidget {
  const XOGrid({Key? key}) : super(key: key);


  @override
  State<XOGrid> createState() => _XOGridState();
}

class _XOGridState extends State<XOGrid> {

  var grid = [[0,0,0],
              [0,0,0],
              [0,0,0]];
  int turn = 0;
  String winText = "";
  void checkRows(){
    for (int r = 0; r < 3; ++r){
      int xs = 0, os = 0;
      for (int c = 0; c < 3; ++c){
        if (grid[r][c] == 1) {
          xs++;
        } else if (grid[r][c] == 2) {
          os++;
        }
      }
      if (xs == 3){
        setState(() { winText = "X won!"; });
      }
      else if (os == 3){
        setState(() { winText = "O won!"; });
      }
    }
  }

  void checkCols(){
    for (int c = 0; c < 3; ++c){
      int xs = 0, os = 0;
      for (int r = 0; r < 3; ++r){
        if (grid[r][c] == 1) {
          xs++;
        } else if (grid[r][c] == 2) {
          os++;
        }
      }
      if (xs == 3){
        setState(() { winText = "X won!"; });
      }
      else if (os == 3){
        setState(() { winText = "O won!"; });
      }
    }
  }

  void checkDias(){
    var starts = [0,2];
    for (int st in starts){
      int xs = 0, os = 0;
      for (int d = 0; d < 3; ++d) {
        if (grid[d][(st - d).abs()] == 1) {
          xs++;
        } else if (grid[d][(st - d).abs()] == 2) {
          os++;
        }
      }
      if (xs == 3){
        setState(() { winText = "X won!"; });
      }
      else if (os == 3){
        setState(() { winText = "O won!"; });
      }
    }

  }

  void handleClick(int row, int col){
    if (winText != "" || grid[row][col] != 0) return;

    setState(() {
      grid[row][col] = turn + 1;
      turn = (turn + 1) % 2;
    });

    checkRows(); checkCols(); checkDias();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: grid.asMap().entries.map((rowEntry) {
              return Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: rowEntry.value.asMap().entries.map((xoValueEntry) {
                    return XOBox(
                      xoValue: xoValueEntry.value,
                      row: rowEntry.key,
                      col: xoValueEntry.key,
                      callback: handleClick
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  for (int r = 0; r < 3; ++r) {
                    for (int c = 0; c < 3; ++c) {
                      grid[r][c] = 0;
                    }
                  }
                  turn = 0;
                  winText = "";
                });
              },
              tooltip: 'Reset',
              child: const Text("Reset"),
            ),
          ),
        ),
        Expanded(
          child: Text(
            winText + (winText == "" ? "" : " Click reset to play again."),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
              fontSize: 20.0,
            ),
          ),
        ),
      ],
    );
  }
}