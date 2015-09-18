@isTest
public class TestDataFactory {
	/*
	 * Create userNum community users
	 */
	public static void createTestCommunityUsers (Integer userNum) {
		List<User> users = new List<User>();
		List<contact> contacts = new List<Contact>();

		//Create account for test contact
		Account a = new Account(Name='Test Account Name');
		insert a;
		//Create contact for System Administrator
		Contact c = new Contact(LastName = 'Contact Last Name', AccountId = a.id);
		insert c;

		//Create test System Administrator
		User sys = new User();
		sys.ProfileID = [Select Id From Profile Where Name='System Administrator'].id;
		sys.EmailEncodingKey = 'ISO-8859-1';
		sys.LanguageLocaleKey = 'en_US';
		sys.TimeZoneSidKey = 'America/New_York';
		sys.LocaleSidKey = 'en_US';
		sys.FirstName = 'first';
		sys.LastName = 'last';
		sys.Username = 'test@test.vrp.test';   
		sys.CommunityNickname = 'testUser123';
		sys.Alias = 't1';
		sys.Email = 'no@email.com';
		sys.IsActive = true;
		//sys.ContactId = c.Id;
		insert sys;

		Id profileId = [SELECT Id FROM Profile WHERE Name = 'Customer Community User'].id;

		//Create contacts for test users
		for (Integer i = 0; i < userNum; i++) {
			contacts.add(new Contact (LastName = 'TestContact' + i, AccountId = a.Id));
		}
		insert contacts;

		//Create test users
		for (Integer i = 0; i < userNum; i++) {
			users.add(new User(	
								profileID = profileId, 
				 				emailEncodingKey = 'ISO-8859-1',
				 				languageLocaleKey = 'en_US',
				 				timeZoneSidKey = 'America/New_York',
								localeSidKey = 'en_US',
								firstName = 'FirstName' + i,
								lastName = 'LastName' + i,
								username = 'alias' + i + '@devcom.test',
								communityNickname = 'alias' + i,
								alias = 'alias' + i,
								email = 'alias' + i + '@devcom.test',
								isActive = true,
								contactId = contacts[i].Id
							   )
			);
		}
		insert users;
	}
}