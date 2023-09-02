import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/constant/constant_text.dart';
import '../../../common/utils/utils.dart';
import '../../../common/widgets/widgets.dart';
import '../logic/logic.dart';
import '../model/model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _deviceModel = "";

  List<BankModel> _bankList = [];

  late bool _startListAnimation = false;

  late double _searchBarheight = 37.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          setState(() {
            _startListAnimation = true;
          });
        },
      );
    });
    _setDeviceModel();

    context.read<BankBloc>().add(FetchBankListEvent(deviceModel: _deviceModel));
  }

  void _setDeviceModel() async {
    _deviceModel = await DeviceInfoService.getDeviceModel();
    SharePref.setData(
        key: ConstantText.headerDeviceName,
        dValue: _deviceModel,
        type: 'String');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BankBloc, BankState>(
      listener: (context, state) {
        if (state is BankStateLoaded) {
          _bankList = state.bankList;

          setState(() {});
        }
      },
      buildWhen: (previous, current) =>
          previous != current &&
          (current is BankStateLoading ||
              current is BankStateError ||
              current is BankStateLoaded),
      builder: (context, state) {
        if (state is BankStateLoading) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                const CupertinoSliverNavigationBar(
                  backgroundColor: Colors.white,
                  largeTitle: Text("Loading"),
                  border: Border(),
                ),
                SliverList.builder(
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return const BankLoadingItem();
                  },
                ),
              ],
            ),
          );
        }
        if (state is BankStateLoaded) {
          return Scaffold(
            body: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                setState(() {
                  if (scrollNotification.metrics.pixels <= _searchBarheight) {
                    _searchBarheight = 37 - scrollNotification.metrics.pixels;
                  }
                });
                // debugPrint("search bar height => $_searchBarheight");
                return true;
              },
              child: CustomScrollView(
                slivers: [
                  const CupertinoSliverNavigationBar(
                    backgroundColor: Colors.white,
                    largeTitle: Text("Bank List"),
                    border: Border(),
                  ),
                  SliverToBoxAdapter(
                    child: SearchFieldWidget(
                      searchBarheight: _searchBarheight,
                    ),
                  ),
                  SliverList.builder(
                    itemCount: _bankList.length,
                    itemBuilder: (context, index) {
                      return BankListItemWidget(
                        index: index,
                        indexItem: _bankList[index],
                        isAnimationStart: _startListAnimation,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
        if (state is BankStateError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.message,
                    textScaleFactor: 1.1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  15.0.spaceY,
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<BankBloc>()
                          .add(FetchBankListEvent(deviceModel: _deviceModel));
                    },
                    child: const Text("Retry Request"),
                  )
                ],
              ),
            ),
          );
        }
        return const Scaffold();
      },
    );
  }
}
