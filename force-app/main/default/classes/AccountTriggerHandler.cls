public without sharing class AccountTriggerHandler {
    
    private static void beforeInsert(){
        AccountService.setRatingBasedOnRevenue(Trigger.New);        
    }

    private static void beforeUpdate(){
        AccountService.setRatingBasedOnRevenue(Trigger.New);                
    }

    public static void run(){
        if(Trigger.isBefore && Trigger.isInsert){
            beforeInsert();
        } else if(Trigger.isBefore && Trigger.isUpdate){
            beforeUpdate();
        } 
    }
}
