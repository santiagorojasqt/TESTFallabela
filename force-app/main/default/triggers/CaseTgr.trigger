/**
 * @description       : 
 * @author            : santiagorqui@gmail.com
 * @group             : 
 * @last modified on  : 09-21-2020
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   09-21-2020   santiagorqui@gmail.com               Initial Version
**/
trigger CaseTgr on Case (before insert,before update,before delete,after insert,after update,after delete) {

    Panel_de_Triggers__mdt pan = [
                                    SELECT 
                                        After_Delete__c,After_Insert__c,After_Update__c,Before_Delete__c,
                                        Before_Insert__c,Before_Update__c,Is_Active__c 
                                    FROM Panel_de_Triggers__mdt 
                                    WHERE DeveloperName ='CaseTgr'
                                ];
    if(pan.Is_Active__c){
        if(Trigger.isBefore){
            if(Trigger.isInsert && pan.Before_Insert__c){
                CaseTgrHandler.isBeforeInsert(Trigger.newMap);
    
            }
            if(Trigger.isUpdate && pan.Before_Update__c){
                CaseTgrHandler.isBeforeUpdate(Trigger.newMap,Trigger.oldMap);
    
            }
            if(Trigger.isDelete && pan.Before_Delete__c){
                CaseTgrHandler.isBeforeDelete(Trigger.oldMap);
    
            }
        }
        else if(Trigger.isAfter){
            if(Trigger.isInsert && pan.After_Insert__c){
                CaseTgrHandler.isAfterInsert(Trigger.newMap);
                
            }
            if(Trigger.isUpdate && pan.After_Update__c){
                CaseTgrHandler.isAfterupdate(Trigger.newMap,Trigger.oldMap);
    
            }
            if(Trigger.isDelete && pan.After_Delete__c){
                CaseTgrHandler.isAfterDelete(Trigger.oldMap);
    
            }
        }
    }
}