extension DateTimeFormatter on DateTime { 
  String formatDate() {
      try {

      final formattedDate = DateTime.now().difference(this); 

      if (formattedDate.inDays > 0) {
        return '${formattedDate.inDays} day${formattedDate.inDays > 1 ? 's' : ''} ago';
      } else if (formattedDate.inHours > 0) {
        return '${formattedDate.inHours} hour${formattedDate.inHours > 1 ? 's' : ''} ago';
      } else if (formattedDate.inMinutes > 0) {
        return '${formattedDate.inMinutes} minute${formattedDate.inMinutes > 1 ? 's' : ''} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Unknown Time';
    }
  }
}