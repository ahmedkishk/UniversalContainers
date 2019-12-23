@isTest
public with sharing class AccountTriggerTest {        

    @isTest
    public static void testRatingBasedOnRevenue(){
        Account a = new Account(Name = 'test', AnnualRevenue = 1100000);
        Test.startTest();
        insert a;
        Test.stopTest();
        a = [Select Id, Rating from Account where Id = :a.Id];
        System.assert(a.Rating == 'Warm');
    }

}
