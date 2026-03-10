import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/complaint_details/complaint_details_cubit.dart';
import '../cubits/complaint_details/complaint_details_state.dart';
import '../widgets/complaint_details/complaint_details_layout.dart';

class ComplaintDetails extends StatelessWidget {
  const ComplaintDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocBuilder<ComplaintDetailsCubit, ComplaintDetailsState>(
        builder: (context, state) {
          if (state.complaint != null) {
            return Stack(
              children: [
                ComplaintDetailsLayout(complaint: state.complaint!),
                if (state.isRefreshing)
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: LinearProgressIndicator(minHeight: 3),
                  ),
              ],
            );
          }

          if (state.status == ComplaintDetailsStatus.error) {
            return Center(
              child: Text(
                state.errorMessage,
                textAlign: TextAlign.center,
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
