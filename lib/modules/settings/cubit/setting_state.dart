part of 'setting_cubit.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}

class GetSettingsLoading extends SettingState {}

class GetSettingsSuccess extends SettingState {}

class GetSettingsError extends SettingState {}


class UpdateSettingsLoading extends SettingState {}

class UpdateSettingsSuccess extends SettingState {}

class UpdateSettingsError extends SettingState {}