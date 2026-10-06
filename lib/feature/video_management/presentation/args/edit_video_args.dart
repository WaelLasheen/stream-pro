
import 'package:stream_pro/core/shared/entity/category_entity.dart';

class EditVideoArgs {
  final String videoId;
  final List<CategoryEntity> categories;

  const EditVideoArgs({required this.videoId, required this.categories});
}
