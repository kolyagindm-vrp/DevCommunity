public class CommunityUserReminderSchedule implements Schedulable {
	public void execute(SchedulableContext sc) {
		String query = 'SELECT Id, Alias FROM User';
		CommunityUserReminderBatch b = new CommunityUserReminderBatch(query);
		Database.executeBatch(b);
	}
}