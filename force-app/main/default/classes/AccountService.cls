public without sharing class AccountService {
    
    public static void setRatingBasedOnRevenue(List<Account> lAccounts){
        for(Account acc : lAccounts){
            if(acc.AnnualRevenue >= 1000000){
                acc.Rating = 'Warm';
            }
        }
    }
        
}
