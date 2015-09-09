public class CommunityUserReminderSchedule implements Schedulable {
	public void execute(SchedulableContext sc) {
		String query = 'SELECT Email, Alias, LastLoginDate FROM User WHERE Profile.Name = \'Customer Community User\'';
		CommunityUserReminderBatch b = new CommunityUserReminderBatch(query);
		Database.executeBatch(b);
	}
}