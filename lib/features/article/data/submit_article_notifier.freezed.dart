// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'submit_article_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SubmitArticleState {
  bool get isSubmitting => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;

  /// Create a copy of SubmitArticleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubmitArticleStateCopyWith<SubmitArticleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubmitArticleStateCopyWith<$Res> {
  factory $SubmitArticleStateCopyWith(
    SubmitArticleState value,
    $Res Function(SubmitArticleState) then,
  ) = _$SubmitArticleStateCopyWithImpl<$Res, SubmitArticleState>;
  @useResult
  $Res call({bool isSubmitting, String errorMessage, bool isSuccess});
}

/// @nodoc
class _$SubmitArticleStateCopyWithImpl<$Res, $Val extends SubmitArticleState>
    implements $SubmitArticleStateCopyWith<$Res> {
  _$SubmitArticleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubmitArticleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSubmitting = null,
    Object? errorMessage = null,
    Object? isSuccess = null,
  }) {
    return _then(
      _value.copyWith(
            isSubmitting:
                null == isSubmitting
                    ? _value.isSubmitting
                    : isSubmitting // ignore: cast_nullable_to_non_nullable
                        as bool,
            errorMessage:
                null == errorMessage
                    ? _value.errorMessage
                    : errorMessage // ignore: cast_nullable_to_non_nullable
                        as String,
            isSuccess:
                null == isSuccess
                    ? _value.isSuccess
                    : isSuccess // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubmitArticleStateImplCopyWith<$Res>
    implements $SubmitArticleStateCopyWith<$Res> {
  factory _$$SubmitArticleStateImplCopyWith(
    _$SubmitArticleStateImpl value,
    $Res Function(_$SubmitArticleStateImpl) then,
  ) = __$$SubmitArticleStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isSubmitting, String errorMessage, bool isSuccess});
}

/// @nodoc
class __$$SubmitArticleStateImplCopyWithImpl<$Res>
    extends _$SubmitArticleStateCopyWithImpl<$Res, _$SubmitArticleStateImpl>
    implements _$$SubmitArticleStateImplCopyWith<$Res> {
  __$$SubmitArticleStateImplCopyWithImpl(
    _$SubmitArticleStateImpl _value,
    $Res Function(_$SubmitArticleStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubmitArticleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSubmitting = null,
    Object? errorMessage = null,
    Object? isSuccess = null,
  }) {
    return _then(
      _$SubmitArticleStateImpl(
        isSubmitting:
            null == isSubmitting
                ? _value.isSubmitting
                : isSubmitting // ignore: cast_nullable_to_non_nullable
                    as bool,
        errorMessage:
            null == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                    as String,
        isSuccess:
            null == isSuccess
                ? _value.isSuccess
                : isSuccess // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$SubmitArticleStateImpl implements _SubmitArticleState {
  const _$SubmitArticleStateImpl({
    this.isSubmitting = false,
    this.errorMessage = '',
    this.isSuccess = false,
  });

  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  @JsonKey()
  final bool isSuccess;

  @override
  String toString() {
    return 'SubmitArticleState(isSubmitting: $isSubmitting, errorMessage: $errorMessage, isSuccess: $isSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitArticleStateImpl &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isSubmitting, errorMessage, isSuccess);

  /// Create a copy of SubmitArticleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitArticleStateImplCopyWith<_$SubmitArticleStateImpl> get copyWith =>
      __$$SubmitArticleStateImplCopyWithImpl<_$SubmitArticleStateImpl>(
        this,
        _$identity,
      );
}

abstract class _SubmitArticleState implements SubmitArticleState {
  const factory _SubmitArticleState({
    final bool isSubmitting,
    final String errorMessage,
    final bool isSuccess,
  }) = _$SubmitArticleStateImpl;

  @override
  bool get isSubmitting;
  @override
  String get errorMessage;
  @override
  bool get isSuccess;

  /// Create a copy of SubmitArticleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitArticleStateImplCopyWith<_$SubmitArticleStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
