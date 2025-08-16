import 'package:flutter/material.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:paheli/utils/string.dart';
import 'package:easy_localization/easy_localization.dart';

enum CellState {
  correct,
  incorrect,
  incorrectButContainsAdha,
  empty,
  misplaced,
  correctVyanjanWithAdhaRemoveAdha,
  correctVyanjanWithAdhaAddMatra,
  correctVyanjanWithAdhaAddAdha,
  correctVyanjanWithMatraRemoveMatra,
  correctVyanjanWithMatraAddAdha,
  correctVyanjanWithMatraAddMatra,
  correctVyanjanWithMatraAndAdhaRemoveMatraAndAdha,
  correctVyanjanWithMatraAndAdhaRemoveMatra,
  correctVyanjanWithMatraAndAdhaRemoveAdha,
  correctVyanjanWithoutMatraAndAdhaAddMatra,
  correctVyanjanWithoutMatraAndAdhaAddAdha,
  correctVyanjanWithoutMatraAndAdhaAddMatraAndAdha,
  misplacedVyanjanWithAdhaRemoveAdha,
  misplacedVyanjanWithAdhaAddMatra,
  misplacedVyanjanWithAdhaAddAdha,
  misplacedVyanjanWithMatraRemoveMatra,
  misplacedVyanjanWithMatraAddAdha,
  misplacedVyanjanWithMatraAddMatra,
  misplacedVyanjanWithMatraAndAdhaRemoveMatraAndAdha,
  misplacedVyanjanWithMatraAndAdhaRemoveMatra,
  misplacedVyanjanWithMatraAndAdhaRemoveAdha,
  misplacedVyanjanWithoutMatraAndAdhaAddMatra,
  misplacedVyanjanWithoutMatraAndAdhaAddAdha,
  misplacedVyanjanWithoutMatraAndAdhaAddMatraAndAdha;

  Color get color {
    switch (this) {
      case CellState.correct:
        return const Color.fromRGBO(129, 178, 154, 1);
      case CellState.incorrectButContainsAdha:
      case CellState.incorrect:
        return const Color.fromRGBO(224, 122, 95, 1);
      case CellState.empty:
        return Colors.black12;
      case CellState.misplaced:
        return const Color.fromRGBO(242, 204, 143, 1);
      case CellState.correctVyanjanWithAdhaRemoveAdha:
      case CellState.correctVyanjanWithAdhaAddMatra:
      case CellState.correctVyanjanWithAdhaAddAdha:
      case CellState.correctVyanjanWithMatraRemoveMatra:
      case CellState.correctVyanjanWithMatraAddAdha:
      case CellState.correctVyanjanWithMatraAddMatra:
      case CellState.correctVyanjanWithMatraAndAdhaRemoveMatraAndAdha:
      case CellState.correctVyanjanWithMatraAndAdhaRemoveMatra:
      case CellState.correctVyanjanWithMatraAndAdhaRemoveAdha:
      case CellState.correctVyanjanWithoutMatraAndAdhaAddMatra:
      case CellState.correctVyanjanWithoutMatraAndAdhaAddAdha:
      case CellState.correctVyanjanWithoutMatraAndAdhaAddMatraAndAdha:
        return const Color.fromARGB(255, 177, 213, 171);
      case CellState.misplacedVyanjanWithAdhaRemoveAdha:
      case CellState.misplacedVyanjanWithAdhaAddMatra:
      case CellState.misplacedVyanjanWithAdhaAddAdha:
      case CellState.misplacedVyanjanWithMatraRemoveMatra:
      case CellState.misplacedVyanjanWithMatraAddAdha:
      case CellState.misplacedVyanjanWithMatraAddMatra:
      case CellState.misplacedVyanjanWithMatraAndAdhaRemoveMatraAndAdha:
      case CellState.misplacedVyanjanWithMatraAndAdhaRemoveMatra:
      case CellState.misplacedVyanjanWithMatraAndAdhaRemoveAdha:
      case CellState.misplacedVyanjanWithoutMatraAndAdhaAddMatra:
      case CellState.misplacedVyanjanWithoutMatraAndAdhaAddAdha:
      case CellState.misplacedVyanjanWithoutMatraAndAdhaAddMatraAndAdha:
        return const Color.fromARGB(255, 229, 166, 6);
    }
  }

  String tooltip(String cellContents) {
    bool containsMatra = cellContents.matraOnly.isNotEmpty;
    bool containsAdha = cellContents.halfOnly.isNotEmpty;

    switch (this) {
      case CellState.correct:
        return LocaleKeys.cellTooltip_correct.tr(args: [cellContents]);
      case CellState.correctVyanjanWithAdhaRemoveAdha:
        return LocaleKeys.cellTooltip_correctVyanjanWithAdhaRemoveAdha
            .tr(args: [cellContents.vyanjan, cellContents.halfOnly]);
      case CellState.correctVyanjanWithAdhaAddMatra:
        return LocaleKeys.cellTooltip_correctVyanjanWithAdhaAddMatra
            .tr(args: [cellContents]);
      case CellState.correctVyanjanWithAdhaAddAdha:
        return LocaleKeys.cellTooltip_correctVyanjanWithAdhaAddAdha
            .tr(args: [cellContents]);

      case CellState.correctVyanjanWithMatraRemoveMatra:
        return LocaleKeys.cellTooltip_correctVyanjanWithMatraRemoveMatra
            .tr(args: [cellContents.vyanjan, cellContents.matraOnly]);
      case CellState.correctVyanjanWithMatraAddAdha:
        return LocaleKeys.cellTooltip_correctVyanjanWithMatraAddAdha
            .tr(args: [cellContents]);
      case CellState.correctVyanjanWithMatraAddMatra:
        return LocaleKeys.cellTooltip_correctVyanjanWithMatraAddMatra
            .tr(args: [cellContents]);
      case CellState.correctVyanjanWithMatraAndAdhaRemoveMatraAndAdha:
        return LocaleKeys
            .cellTooltip_correctVyanjanWithMatraAndAdhaRemoveMatraAndAdha
            .tr(args: [
          cellContents.vyanjan,
          cellContents.matraOnly,
          cellContents.halfOnly
        ]);
      case CellState.correctVyanjanWithMatraAndAdhaRemoveMatra:
        return LocaleKeys.cellTooltip_correctVyanjanWithMatraAndAdhaRemoveMatra
            .tr(args: [
          cellContents.halfOnly + cellContents.vyanjan,
          cellContents.matraOnly
        ]);
      case CellState.correctVyanjanWithMatraAndAdhaRemoveAdha:
        return LocaleKeys.cellTooltip_correctVyanjanWithMatraAndAdhaRemoveAdha
            .tr(args: [
          cellContents.vyanjan + cellContents.matraOnly,
          cellContents.halfOnly
        ]);
      case CellState.correctVyanjanWithoutMatraAndAdhaAddMatra:
        return LocaleKeys.cellTooltip_correctVyanjanWithoutMatraAndAdhaAddMatra
            .tr(args: [cellContents]);
      case CellState.correctVyanjanWithoutMatraAndAdhaAddAdha:
        return LocaleKeys.cellTooltip_correctVyanjanWithoutMatraAndAdhaAddAdha
            .tr(args: [cellContents]);
      case CellState.correctVyanjanWithoutMatraAndAdhaAddMatraAndAdha:
        return LocaleKeys
            .cellTooltip_correctVyanjanWithoutMatraAndAdhaAddMatraAndAdha
            .tr(args: [cellContents]);
      case CellState.misplaced:
        //return LocaleKeys.cellTooltip_misplaced.tr(args: [cellContents]);
        if (containsMatra) {
          if (containsAdha) {
            return LocaleKeys.cellTooltip_misplacedWithMatraAndAdha
                .tr(args: [cellContents]);
          } else {
            return LocaleKeys.cellTooltip_misplacedWithMatra
                .tr(args: [cellContents]);
          }
        } else {
          if (containsAdha) {
            return LocaleKeys.cellTooltip_misplacedWithAdha
                .tr(args: [cellContents]);
          } else {
            return LocaleKeys.cellTooltip_misplacedWithoutMatraAndAdha
                .tr(args: [cellContents]);
          }
        }
      case CellState.misplacedVyanjanWithAdhaRemoveAdha:
        return LocaleKeys.cellTooltip_misplacedVyanjanWithAdhaRemoveAdha
            .tr(args: [cellContents.vyanjan, cellContents.halfOnly]);
      case CellState.misplacedVyanjanWithAdhaAddMatra:
        return LocaleKeys.cellTooltip_misplacedVyanjanWithAdhaAddMatra
            .tr(args: [cellContents]);
      case CellState.misplacedVyanjanWithAdhaAddAdha:
        return LocaleKeys.cellTooltip_misplacedVyanjanWithAdhaAddAdha
            .tr(args: [cellContents]);
      case CellState.misplacedVyanjanWithMatraRemoveMatra:
        return LocaleKeys.cellTooltip_misplacedVyanjanWithMatraRemoveMatra
            .tr(args: [cellContents.vyanjan, cellContents.matraOnly]);
      case CellState.misplacedVyanjanWithMatraAddAdha:
        return LocaleKeys.cellTooltip_misplacedVyanjanWithMatraAddAdha
            .tr(args: [cellContents]);

      case CellState.misplacedVyanjanWithMatraAddMatra:
        return LocaleKeys.cellTooltip_misplacedVyanjanWithMatraAddMatra
            .tr(args: [cellContents]);
      case CellState.misplacedVyanjanWithMatraAndAdhaRemoveMatraAndAdha:
        return LocaleKeys
            .cellTooltip_misplacedVyanjanWithMatraAndAdhaRemoveMatraAndAdha
            .tr(args: [
          cellContents.vyanjan,
          cellContents.matraOnly,
          cellContents.halfOnly
        ]);
      case CellState.misplacedVyanjanWithMatraAndAdhaRemoveMatra:
        return LocaleKeys
            .cellTooltip_misplacedVyanjanWithMatraAndAdhaRemoveMatra
            .tr(args: [
          cellContents.halfOnly + cellContents.vyanjan,
          cellContents.matraOnly
        ]);
      case CellState.misplacedVyanjanWithMatraAndAdhaRemoveAdha:
        return LocaleKeys.cellTooltip_misplacedVyanjanWithMatraAndAdhaRemoveAdha
            .tr(args: [
          cellContents.vyanjan + cellContents.matraOnly,
          cellContents.halfOnly
        ]);
      case CellState.misplacedVyanjanWithoutMatraAndAdhaAddMatra:
        return LocaleKeys
            .cellTooltip_misplacedVyanjanWithoutMatraAndAdhaAddMatra
            .tr(args: [cellContents]);
      case CellState.misplacedVyanjanWithoutMatraAndAdhaAddAdha:
        return LocaleKeys.cellTooltip_misplacedVyanjanWithoutMatraAndAdhaAddAdha
            .tr(args: [cellContents]);
      case CellState.misplacedVyanjanWithoutMatraAndAdhaAddMatraAndAdha:
        return LocaleKeys
            .cellTooltip_misplacedVyanjanWithoutMatraAndAdhaAddMatraAndAdha
            .tr(args: [cellContents]);

      case CellState.incorrect:
        return LocaleKeys.cellTooltip_incorrect
            .tr(args: [cellContents.vyanjan]);
      case incorrectButContainsAdha:
        return LocaleKeys.cellTooltip_incorrectButContainsAdha
            .tr(args: [cellContents.vyanjan, '${cellContents.vyanjan}्']);
      case CellState.empty:
          // The problem is that cellContents has its vyanjan removed from it if its empty so let's add a random letter like 'A' and then check if it contains matras or half letters
          String matraOnly = cellContents.matraOnly;
          print('Matra only: $matraOnly');
          String halfOnly;
          if (cellContents.vyanjan.isNotEmpty) {
             halfOnly = cellContents.halfOnly.isNotEmpty
                 ? '${cellContents.halfOnly} ${cellContents.vyanjan}्'
                 : cellContents.vyanjan;
             matraOnly = cellContents.matraOnly.replaceAll('्', "");
          }
          else{
           halfOnly = cellContents.halfOnly;

          }
          containsAdha = halfOnly.isNotEmpty;
          containsMatra = matraOnly.isNotEmpty;
        if (containsMatra) {
          if (containsAdha) {
            return LocaleKeys.cellTooltip_emptyWithMatraAndAdha
                .tr(args: [halfOnly, matraOnly]);
          } else {
            return LocaleKeys.cellTooltip_emptyWithMatra
                .tr(args: [matraOnly]);
          }
        } else {
          if (containsAdha) {
            return LocaleKeys.cellTooltip_emptyWithAdha
                .tr(args: [halfOnly]);
          } else {
            return LocaleKeys.cellTooltip_emptyWithoutMatraAndAdha.tr();
          }
        }
    }
  }
}

class Cell {
  String value;
  CellState state;
  Cell(this.value, {this.state = CellState.empty});

  static Cell fromJson(Map<String, dynamic> json) {
    return Cell(
      json['value'] as String,
      state: CellState.values[json['state'] as int],
    );
  }

  Map<String, dynamic> toJson() => {
        'value': value,
        'state': state.index,
      };
}
