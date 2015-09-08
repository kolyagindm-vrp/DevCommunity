public class CommunityUserReminderBatch implements Database.Batchable<sObject> {
	
	String query;
	
	public CommunityUserReminderBatch(String q) {
		query = q;
	}
	
	public Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

   	public void execute(Database.BatchableContext BC, List<User> scope) {
   		String plainText = '';
		for (User s : scope) {
			plainText += s.Alias;
		}

		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		mail.setToAddresses(new List<String>{'koliagindm@gmail.com'});
		mail.setReplyTo('koliagindm@gmail.com');
		mail.setSenderDisplayName('Batch');
		mail.setSubject('Batch process');
		mail.setPlainTextBody(plainText);

		Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
	}
	
	public void finish(Database.BatchableContext BC) {
		
	}
	
}