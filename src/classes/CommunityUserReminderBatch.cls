public class CommunityUserReminderBatch implements Database.Batchable<sObject> {

	@TestVisible private Integer dayToday;	
	@TestVisible private Date checkDate;	//Today date. May diff frim realy today date for test reasons.
	
	public CommunityUserReminderBatch() {
		checkDate = Date.today();
	}

	public CommunityUserReminderBatch(Date curDate) {
		checkDate = curDate;
	}
	
	public Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator([SELECT Email, Alias, LastLoginDate FROM User WHERE Profile.Name = 'Customer Community User']);
	}

   	public void execute(Database.BatchableContext BC, List<User> scope) {

   		String plainText = 'Welcome to our community!';
   		Integer loginDaysAgo, loginMonthsAgo;		//Last login was n days ago and day in month for today and LastLoginDate
   		List<String> emails = new List<String>();

   		dayToday = checkDate.day();

		for (User u : scope) {
			//Test whether the user have logged in already
			if (u.LastLoginDate == null) { 
				continue; 
			}
			//Receive diff in days and months between today and last login date
			loginDaysAgo = u.LastLoginDate.date().daysBetween(checkDate);
			loginMonthsAgo = u.LastLoginDate.date().monthsBetween(checkDate);	
			System.debug(loginDaysAgo + ' | ' + loginMonthsAgo);
			//Receive email if it' 14 days, 28 days, 3 months, 6 months
			if ((loginDaysAgo == 14) || (loginDaysAgo == 28) || (((loginMonthsAgo == 3) || (loginMonthsAgo == 6)) && (dayToday == u.LastLoginDate.date().day()))) {
				emails.add(u.Email);
			}
		}

		//Send email if our email list is not empty
		if (!emails.isEmpty()) {
			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			mail.setToAddresses(emails);
			mail.setReplyTo('koliagindm@gmail.com');
			mail.setSenderDisplayName('DevCom');
			mail.setSubject('Invitation');
			mail.setPlainTextBody(plainText);

			Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
		}
	}
	
	public void finish(Database.BatchableContext BC) {
		String plainText = 'Batch Complete!';
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		mail.setToAddresses(new List<String> {'koliagindm@gmail.com'});
		mail.setReplyTo('koliagindm@gmail.com');
		mail.setSenderDisplayName('Batch');
		mail.setSubject('Batch process');
		mail.setPlainTextBody(plainText);

		Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});	
	}
	
}