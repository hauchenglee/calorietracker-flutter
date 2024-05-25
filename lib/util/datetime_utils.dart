class DateTimeUtils {
  // 给定文字（yyyymmdd），转成DateTime
  static DateTime parseDate(String dateString) {
    // 使用 DateTime.parse 方法需要标准的日期格式，所以我们需要先格式化输入字符串
    assert(dateString.length == 8, "The date string must be in the format yyyymmdd");
    String formattedDateString = "${dateString.substring(0, 4)}-${dateString.substring(4, 6)}-${dateString.substring(6, 8)}";
    return DateTime.parse(formattedDateString);
  }

  // 给定DateTime，转成文字（yyyymmdd）
  static String formatDate(DateTime dateTime) {
    return "${dateTime.year.toString().padLeft(4, '0')}${dateTime.month.toString().padLeft(2, '0')}${dateTime.day.toString().padLeft(2, '0')}";
  }
}