import 'package:collaction_cms/domain/crowdaction/crowdaction.dart';
import 'package:collaction_cms/presentation/shared/form/form_header.dart';
import 'package:flutter/cupertino.dart';

class CrowdActionInfoForm extends StatelessWidget {
  final double width;
  String? title;
  String? type;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? joinByDate;
  Location? country;
  String? description;
  String? category;
  String? subcategory;
  String? password;

  CrowdActionInfoForm({
    super.key,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FormHeader(title: "Basic Information"),
        const SizedBox(height: 18),
      ],
    );
  }
}

/*
Architecture:
Parent Modal: 
  BlocProviders provide:
    InfoBloc to CrowdActionInfoForm
    ImageBloc to CrowdActionImagesForm
    CommitmentsBloc to CrowdActionCommitmentsBloc
  OnSubmit:
    InfoBloc.GetInfo, ImageBloc.GetImages, CommitmentsBloc.GetCommitments


InfoBloc states:
  initial - not submittable
  filled - filled, now submittable
InfoBloc events:
  setFilled(bool) - used to notify modal

ImageBloc states:
  initial - submittable, uses default imgs?
  loading - image is loading, not submittable
  *failed - 
ImageBloc events:
  upload() - sets state to loading
  *uploadFinished() - sets state to initial?/failed?

CommitmentBloc states: 
  initial
  filled - at least 1 commitment, now submitable
CommitmentBloc states:
  setFilled(bool) - used to notify modal

CreateCrowdActionBloc states:
  initial - uses BlocListeners to determine if submittable
  submitting - not submittable
  failed - submittable
  success - closes modal
CreateCrowdActionBloc events:
  submitForm(FormDto) - sets state to submitting, calls API to create a new crowdaction using the DTO, sets state to success/failed
    FormDto needs to be built by grabbing form info from child forms
      Use unique keys to get children and their form data

Modal submit button disabled until:
  InfoBloc.state == filled && ImageBloc.state == initial && CommitmentBloc.state == filled
Modal submit button shows a loading indicator when CreateCrowdActionBloc.state == submitting

Sub-Blocs use BlocProvider.of to get blocs, then .add(event) when state changes
Modal Bloc wraps each form in a BlocProvider<Bloc> with their respective bloc, is wrapped in a BlocBuilder

OR

Have a CrowdActionFormRepository
Each BLoC 


*/