@isTest
private class TestCommunityUserReminderBatch {

	@testSetup static void setup() {
		TestDataFactory.createTestCommunityUsers(199);
	}

	//Test 14 days
	@isTest static void test14DaysDelay() {
		Id profileId = [SELECT Id FROM Profile WHERE Name = 'Customer Community User'].Id;
		Date existingDate = [SELECT LastLoginDate FROM User WHERE LastLoginDate != null AND ProfileId = :profileId LIMIT 1].LastLoginDate.date();
		CommunityUserReminderBatch c = new CommunityUserReminderBatch(existingDate.addDays(14));

		Test.startTest();
		ID jobId = Database.executeBatch(c);
		Test.stopTest();

		System.assertEquals('Completed', [SELECT Status FROM AsyncApexJob WHERE Id = :jobId].Status, 'There are some errors');
	}
	//Test 28 days
	@isTest static void test28DaysDelay() {
		Id profileId = [SELECT Id FROM Profile WHERE Name = 'Customer Community User'].Id;
		Date existingDate = [SELECT LastLoginDate FROM User WHERE LastLoginDate != null AND ProfileId = :profileId LIMIT 1].LastLoginDate.date();
		CommunityUserReminderBatch c = new CommunityUserReminderBatch(existingDate.addDays(28));

		Test.startTest();
		ID jobId = Database.executeBatch(c);
		Test.stopTest();

		System.assertEquals('Completed', [SELECT Status FROM AsyncApexJob WHERE Id = :jobId].Status, 'There are some errors');
	}
	//Test 3 months
	@isTest static void test3MonthsDelay() {
		Id profileId = [SELECT Id FROM Profile WHERE Name = 'Customer Community User'].Id;
		Date existingDate = [SELECT LastLoginDate FROM User WHERE LastLoginDate != null AND ProfileId = :profileId LIMIT 1].LastLoginDate.date();
		CommunityUserReminderBatch c = new CommunityUserReminderBatch(existingDate.addMonths(3));

		Test.startTest();
		ID jobId = Database.executeBatch(c);
		Test.stopTest();

		System.assertEquals('Completed', [SELECT Status FROM AsyncApexJob WHERE Id = :jobId].Status, 'There are some errors');
	}
	//Test 6 months
	@isTest static void test6MonthsDelay() {
		Id profileId = [SELECT Id FROM Profile WHERE Name = 'Customer Community User'].Id;
		Date existingDate = [SELECT LastLoginDate FROM User WHERE LastLoginDate != null AND ProfileId = :profileId LIMIT 1].LastLoginDate.date();
		CommunityUserReminderBatch c = new CommunityUserReminderBatch(existingDate.addMonths(6));

		Test.startTest();
		ID jobId = Database.executeBatch(c);
		Test.stopTest();

		System.assertEquals('Completed', [SELECT Status FROM AsyncApexJob WHERE Id = :jobId].Status, 'There are some errors');
	}
	//Test today
	@isTest static void testToday() {
		CommunityUserReminderBatch c = new CommunityUserReminderBatch();

		Test.startTest();
		ID jobId = Database.executeBatch(c);
		Test.stopTest();

		System.assertEquals('Completed', [SELECT Status FROM AsyncApexJob WHERE Id = :jobId].Status, 'There are some errors');
	}
}