import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lolo/features/memory_vault/domain/entities/memory_category.dart';

part 'memory.freezed.dart';

@freezed
class Memory with _$Memory {
  const factory Memory({
    required String id,
    required String title,
    required String description,
    required DateTime date,
    required MemoryCategory category,
    required String mood,
    @Default([]) List<String> mediaUrls,
    @Default([]) List<String> tags,
    @Default(false) bool isFavorite,
    @Default(false) bool isPrivate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Memory;
}
