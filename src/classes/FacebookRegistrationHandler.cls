public class FacebookRegistrationHandler implements Auth.RegistrationHandler {

	public boolean canCreateUser(Auth.UserData data) {

		if(String.isBlank(data.identifier) && String.isBlank(data.email)) {
			return false;
		} else {
			return true;
		}
	}

    public User createUser(Id portalId, Auth.UserData data) {
    		System.debug('1');
		// Match the Auth.UserData to an existing user?
		if (!canCreateUser(data)) {
			System.debug('Not enough parameters');
			System.debug(data);
			return null;
		} else {
			System.debug(data);
			//Trying to find user with id
			List<User> users = [SELECT Id FROM User WHERE facebookId__c = :data.identifier];
			if (users.size() > 0) {
				System.debug('ID: ' + users[0]);
				return users[0];
			}
			//Trying to find user with primary email
			List<Contact> contacts = [SELECT Id FROM Contact WHERE email = :data.email];
			String contactId;
			if (contacts.size() == 0) {
				System.debug('No contact founded');
				return null;
			} else {
				contactId = contacts[0].Id;
			}
			users = [SELECT Id FROM User WHERE ContactId = :contactId];
			if (users.size() > 0) {
				System.debug('email: ' + users[0]);
				return users[0];
			} else {
				//If contact already exists but without user, than create user
				//Retreiving email
				String email;
				if (String.isBlank(data.email)) {
					email = 'test@test.test';
				} else {
					email = data.email;
				}
				//Making alias
				String alias = data.firstName.substring(0,1)+data.lastName.substring(0,4);
				if(alias.length() > 8) {
					alias = alias.substring(0, 8);
				}
				//Default account for community users
				Account a = [SELECT Id FROM Account WHERE Name = 'Community User Account'];

				//Create user

				User user = new User();
				user.profileID = [Select Id From Profile Where Name='Customer Community User'].id;
				user.emailEncodingKey = 'ISO-8859-1';
				user.languageLocaleKey = 'en_US';
				user.timeZoneSidKey = 'America/New_York';
				user.localeSidKey = 'en_US';
				user.firstName = data.firstName;
				user.lastName = data.lastName;
				user.username = alias + '@devcom.com'; 
				user.communityNickname = alias;
				user.alias = alias;
				user.email = email;
				user.isActive = true;
				user.contactId = contactId;
				user.facebookId__c = data.identifier;
				//user.userRoleId = [SELECT Id FROM UserRole WHERE Name = 'CEO'].Id;

				return user;
			}
			return null;
		}		
	}

    public void updateUser(Id userId, Id portalId, Auth.UserData data) {
        
		// Update user details from Auth.UserData?
		User u = [SELECT Id FROM User WHERE facebookId__c = :data.identifier];
		u.firstName = data.firstName;
		u.lastName = data.lastName;
		update u;
    }
}