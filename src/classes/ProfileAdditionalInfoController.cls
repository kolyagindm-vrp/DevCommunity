public with sharing class ProfileAdditionalInfoController {

	public User user { get; private set; }
	public Integer daysAgo {get; private set; }
	public Integer monthsAgo {get; private set; }

	public ProfileAdditionalInfoController() {
		user = [SELECT Id, Name, Email, LastLoginDate, IsActive, Profile.Name FROM User WHERE Id = :ApexPages.currentPage().getParameters().get('sfdc.userid')];
		daysAgo = user.LastLoginDate.date().daysBetween(Date.today());
		monthsAgo = user.LastLoginDate.date().monthsBetween(Date.today());
	}

	public PageReference deactivateUser() {
		user.isActive = false;
		update user;
		return ApexPages.currentPage();
	}

	public PageReference activateUser() {
		user.isActive = true;
		update user;
		return ApexPages.currentPage();
	}

}