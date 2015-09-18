public class CommunityUserReminderSchedule implements Schedulable {
	public void execute(SchedulableContext sc) {
		CommunityUserReminderBatch b = new CommunityUserReminderBatch();
		Database.executeBatch(b);
	}
}