import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/screens/person_registration/models/person_registration_form_data.dart';

part 'person_event.freezed.dart';

@freezed
sealed class PersonEvent with _$PersonEvent {
  const factory PersonEvent.submit(PersonRegistrationFormData formData) =
      PersonSubmit;
}
