import 'package:assign_khalti/common/utils/extensions/size.dart';
import 'package:assign_khalti/common/utils/extensions/space_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../src/home/logic/bank_bloc.dart';
import 'list_loading_widget.dart';
import 'list_single_widget.dart';

class SearchListWidget extends StatelessWidget {
  const SearchListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: context.height,
        width: context.width,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      10.0.spaceX,
                      Expanded(
                        child: CupertinoSearchTextField(
                          key: const Key('Search Bank Field'),
                          enabled: true,
                          autofocus: true,
                          borderRadius: BorderRadius.circular(12),
                          placeholder: "Search Bank by Name or Code...",
                          style: const TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 0.2,
                          ),
                          onChanged: (value) {
                            context
                                .read<BankBloc>()
                                .add(SearchBankListEvent(query: value));
                          },
                        ),
                      ),
                      TextButton(
                        key: const Key('Cancel Button Pop'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w400,
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                10.0.spaceY,
                BlocBuilder<BankBloc, BankState>(
                  builder: (context, state) {
                    if (state is SearchBankStateLoading) {
                      return ListView.builder(
                        itemCount: 10,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return const BankLoadingItem();
                        },
                      );
                    }
                    if (state is SearchBankStateLoaded) {
                      return state.bankList.isNotEmpty
                          ? ListView.builder(
                              itemCount: state.bankList.length,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final indexItem = state.bankList[index];
                                return BankListItemWidget(
                                  index: index,
                                  indexItem: indexItem,
                                  isAnimationStart: true,
                                );
                              },
                            )
                          : SizedBox(
                              height: context.height * .9,
                              width: context.width * .9,
                              child: const Center(
                                child: Text("No Data Found."),
                              ),
                            );
                    }
                    return SizedBox(
                      height: context.height * .9,
                      width: context.width * .9,
                      child: const Center(
                        child: Text("No Data Found."),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
