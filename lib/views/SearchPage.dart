import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_app/config/ConsumedMedication/consumed_medication_bloc.dart';
import 'package:medicine_app/views/Notification.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController Name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConsumedMedicationBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Container(
              height: 40,
              width: 400,
              child: TextFormField(
                controller: Name,
                onEditingComplete: () => context
                    .read<ConsumedMedicationBloc>()
                    .add(GetAllConsumedMedications(Name.text)),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide(color: Colors.white, width: 0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide(color: Colors.white))),
              ),
            ),
            actions: [
              SizedBox(
                width: 15,
              ),
              IconButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ReminderPage())),
                  icon: Icon(Icons.notifications))
            ],
            backgroundColor: Color.fromARGB(255, 23, 156, 28),
          ),
          body: Scaffold(
            body: BlocBuilder<ConsumedMedicationBloc, ConsumedMedicationState>(
              builder: (context, state) {
                if (state is ConsumedMedicationLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ConsumedMedicationSuccess) {
                  return ListView.builder(
                    itemCount: state.consumedMedications.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                              state.consumedMedications[index].drug!.Drug_name),
                          subtitle: Text(
                              state.consumedMedications[index].Doctor_Name),
                        ),
                      );
                    },
                  );
                } else if (state is ConsumedMedicationError) {
                  return Center(child: Text(state.runtimeType.toString()));
                } else {
                  return const Center(
                      child: Text('Enter a drug name to search'));
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
