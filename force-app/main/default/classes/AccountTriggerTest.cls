@isTest
public with sharing class AccountTriggerTest {
    
    @isTest
    public static void testRatingBasedOnIndustry(){
        Account a = new Account(Name = 'test', Industry = 'Banking');
        Test.startTest();
        insert a;
        Test.stopTest();
        a = [Select Id, Rating from Account where Id = :a.Id];
        System.assert(a.Rating == 'Hot');
    }    

}
