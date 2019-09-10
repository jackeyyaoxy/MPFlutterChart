import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mp_flutter_chart/chart/mp/chart/horizontal_bar_chart.dart';
import 'package:mp_flutter_chart/chart/mp/core/data/bar_data.dart';
import 'package:mp_flutter_chart/chart/mp/core/data_set/bar_data_set.dart';
import 'package:mp_flutter_chart/chart/mp/core/description.dart';
import 'package:mp_flutter_chart/chart/mp/core/entry/bar_entry.dart';
import 'package:mp_flutter_chart/chart/mp/core/entry/entry.dart';
import 'package:mp_flutter_chart/chart/mp/core/enums/axis_dependency.dart';
import 'package:mp_flutter_chart/chart/mp/core/enums/legend_horizontal_alignment.dart';
import 'package:mp_flutter_chart/chart/mp/core/enums/legend_orientation.dart';
import 'package:mp_flutter_chart/chart/mp/core/enums/legend_vertical_alignment.dart';
import 'package:mp_flutter_chart/chart/mp/core/enums/x_axis_position.dart';
import 'package:mp_flutter_chart/chart/mp/core/highlight/highlight.dart';
import 'package:mp_flutter_chart/chart/mp/core/value_formatter/value_formatter.dart';
import 'package:mp_flutter_chart/chart/mp/listener.dart';

class BarChartStacked2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BarChartStacked2State();
  }
}

class BarChartStacked2State extends State<BarChartStacked2>
    implements OnChartValueSelectedListener {
  HorizontalBarChart _barChart;
  BarData _barData;

  @override
  void initState() {
    _initBarData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _initBarChart();
    return Scaffold(
        appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text("Bar Chart Stacked2")),
        body: Stack(
          children: <Widget>[
            Positioned(
              right: 0,
              left: 0,
              top: 0,
              bottom: 0,
              child: _barChart,
            ),
          ],
        ));
  }

  void _initBarData() {
    // IMPORTANT: When using negative values in stacked bars, always make sure the negative values are in the array first
    List<BarEntry> values = List();
    values.add(
        BarEntry.fromListYVals(x: 5, vals: List<double>()..add(-10)..add(10)));
    values.add(
        BarEntry.fromListYVals(x: 15, vals: List<double>()..add(-12)..add(13)));
    values.add(
        BarEntry.fromListYVals(x: 25, vals: List<double>()..add(-15)..add(15)));
    values.add(
        BarEntry.fromListYVals(x: 35, vals: List<double>()..add(-17)..add(17)));
    values.add(
        BarEntry.fromListYVals(x: 45, vals: List<double>()..add(-19)..add(20)));
    values.add(
        BarEntry.fromListYVals(x: 45, vals: List<double>()..add(-19)..add(20)
//        getResources().getDrawable(R.drawable.star)
            ));
    values.add(
        BarEntry.fromListYVals(x: 55, vals: List<double>()..add(-19)..add(19)));
    values.add(
        BarEntry.fromListYVals(x: 65, vals: List<double>()..add(-16)..add(16)));
    values.add(
        BarEntry.fromListYVals(x: 75, vals: List<double>()..add(-13)..add(14)));
    values.add(
        BarEntry.fromListYVals(x: 85, vals: List<double>()..add(-10)..add(11)));
    values.add(
        BarEntry.fromListYVals(x: 95, vals: List<double>()..add(-5)..add(6)));
    values.add(
        BarEntry.fromListYVals(x: 105, vals: List<double>()..add(-1)..add(2)));

    BarDataSet set = BarDataSet(values, "Age Distribution");
    set.setDrawIcons(false);
    set.setValueFormatter(B());
    set.setValueTextSize(7);
    set.setAxisDependency(AxisDependency.RIGHT);
    set.setColors1(List()
      ..add(Color.fromARGB(255, 67, 67, 72))
      ..add(Color.fromARGB(255, 124, 181, 236)));
    set.setStackLabels(List()..add("Men")..add("Women"));

    _barData = BarData(List()..add(set));
    _barData.setBarWidth(8.5);
  }

  void _initBarChart() {
    var desc = Description();
    desc.setEnabled(false);
    _barChart = HorizontalBarChart(_barData, (painter) {
      painter
        ..setOnChartValueSelectedListener(this)
        ..setDrawBarShadow(false)
        ..setDrawValueAboveBar(true)
        ..setHighlightFullBarEnabled(false);

      painter.mAxisLeft.setEnabled(false);
      painter.mAxisRight
        ..setAxisMaximum(25)
        ..setAxisMinimum(-25)
        ..setDrawGridLines(false)
        ..setDrawZeroLine(true)
        ..setLabelCount2(7, false)
        ..setValueFormatter(A())
        ..setTextSize(9);

      painter.mXAxis
        ..setPosition(XAxisPosition.BOTH_SIDED)
        ..setDrawGridLines(false)
        ..setDrawAxisLine(false)
        ..setTextSize(9)
        ..setAxisMinimum(0)
        ..setAxisMaximum(110)
        ..setCenterAxisLabels(true)
        ..setLabelCount1(12)
        ..setGranularity(10)
        ..setValueFormatter(B());

      painter.mLegend
        ..setVerticalAlignment(LegendVerticalAlignment.BOTTOM)
        ..setHorizontalAlignment(LegendHorizontalAlignment.RIGHT)
        ..setOrientation(LegendOrientation.HORIZONTAL)
        ..setDrawInside(false)
        ..setFormSize(8)
        ..setFormToTextSpace(4)
        ..setXEntrySpace(6);
    },
        touchEnabled: true,
        drawGridBackground: false,
        dragXEnabled: true,
        dragYEnabled: true,
        scaleXEnabled: true,
        scaleYEnabled: true,
        pinchZoomEnabled: false,
        desc: desc);
  }

  @override
  void onNothingSelected() {}

  @override
  void onValueSelected(Entry e, Highlight h) {}
}

class A extends ValueFormatter {
  NumberFormat mFormat;

  A() {
    mFormat = NumberFormat("###");
  }

  @override
  String getFormattedValue1(double value) {
    return mFormat.format(value.abs()) + "m";
  }
}

class B extends ValueFormatter {
  NumberFormat mFormat;

  B() {
    mFormat = NumberFormat("###");
  }

  @override
  String getFormattedValue1(double value) {
    return mFormat.format(value) + "-" + mFormat.format(value + 10);
  }
}