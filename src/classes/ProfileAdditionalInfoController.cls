public with sharing class ProfileAdditionalInfoController {

	public User user { get; private set; }			//User sObject
	public Integer daysAgo { get; private set; }		//Last login days ago
	public Integer monthsAgo { get; private set; }	//Last login months ago
	public Boolean isAdmin { get; private set; }		//@TODO

	public ProfileAdditionalInfoController() {
		user = [SELECT Id, Name, Email, LastLoginDate, IsActive FROM User WHERE Id = :ApexPages.currentPage().getParameters().get('sfdc.userid')];
		daysAgo = user.LastLoginDate.date().daysBetween(Date.today());
		monthsAgo = user.LastLoginDate.date().monthsBetween(Date.today());

		//See if current user is System Administrator
		Profile curProfile = [SELECT Name FROM Profile WHERE Id = :UserInfo.getProfileId()];
		isAdmin = (curProfile.Name == 'System Administrator');
	}

	/*
	 * Deactivate user
	 */
	public PageReference deactivateUser() {
		user.isActive = false;
		update user;
		return ApexPages.currentPage();
	}

	/*
	 * Activate user
	 */
	public PageReference activateUser() {
		user.isActive = true;
		update user;
		return ApexPages.currentPage();
	}

}