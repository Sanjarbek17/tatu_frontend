// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ArticleState {
  List<String> get articles => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of ArticleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArticleStateCopyWith<ArticleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleStateCopyWith<$Res> {
  factory $ArticleStateCopyWith(
    ArticleState value,
    $Res Function(ArticleState) then,
  ) = _$ArticleStateCopyWithImpl<$Res, ArticleState>;
  @useResult
  $Res call({List<String> articles, bool isLoading, String errorMessage});
}

/// @nodoc
class _$ArticleStateCopyWithImpl<$Res, $Val extends ArticleState>
    implements $ArticleStateCopyWith<$Res> {
  _$ArticleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArticleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? articles = null,
    Object? isLoading = null,
    Object? errorMessage = null,
  }) {
    return _then(
      _value.copyWith(
            articles:
                null == articles
                    ? _value.articles
                    : articles // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            isLoading:
                null == isLoading
                    ? _value.isLoading
                    : isLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            errorMessage:
                null == errorMessage
                    ? _value.errorMessage
                    : errorMessage // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ArticleStateImplCopyWith<$Res>
    implements $ArticleStateCopyWith<$Res> {
  factory _$$ArticleStateImplCopyWith(
    _$ArticleStateImpl value,
    $Res Function(_$ArticleStateImpl) then,
  ) = __$$ArticleStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> articles, bool isLoading, String errorMessage});
}

/// @nodoc
class __$$ArticleStateImplCopyWithImpl<$Res>
    extends _$ArticleStateCopyWithImpl<$Res, _$ArticleStateImpl>
    implements _$$ArticleStateImplCopyWith<$Res> {
  __$$ArticleStateImplCopyWithImpl(
    _$ArticleStateImpl _value,
    $Res Function(_$ArticleStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ArticleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? articles = null,
    Object? isLoading = null,
    Object? errorMessage = null,
  }) {
    return _then(
      _$ArticleStateImpl(
        articles:
            null == articles
                ? _value._articles
                : articles // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        isLoading:
            null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        errorMessage:
            null == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$ArticleStateImpl implements _ArticleState {
  const _$ArticleStateImpl({
    final List<String> articles = const [],
    this.isLoading = false,
    this.errorMessage = '',
  }) : _articles = articles;

  final List<String> _articles;
  @override
  @JsonKey()
  List<String> get articles {
    if (_articles is EqualUnmodifiableListView) return _articles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_articles);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String errorMessage;

  @override
  String toString() {
    return 'ArticleState(articles: $articles, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticleStateImpl &&
            const DeepCollectionEquality().equals(other._articles, _articles) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_articles),
    isLoading,
    errorMessage,
  );

  /// Create a copy of ArticleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArticleStateImplCopyWith<_$ArticleStateImpl> get copyWith =>
      __$$ArticleStateImplCopyWithImpl<_$ArticleStateImpl>(this, _$identity);
}

abstract class _ArticleState implements ArticleState {
  const factory _ArticleState({
    final List<String> articles,
    final bool isLoading,
    final String errorMessage,
  }) = _$ArticleStateImpl;

  @override
  List<String> get articles;
  @override
  bool get isLoading;
  @override
  String get errorMessage;

  /// Create a copy of ArticleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArticleStateImplCopyWith<_$ArticleStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
