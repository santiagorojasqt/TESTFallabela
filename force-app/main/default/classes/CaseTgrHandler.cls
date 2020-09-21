/**
 * @description       : 
 * @author            : santiagorqui@gmail.com
 * @group             : 
 * @last modified on  : 09-21-2020
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
* 1.0   09-21-2020    santiagorqui@gmail.com                Initial Version
**/
public with sharing class CaseTgrHandler {
    public static  Map<string, schema.sobjecttype> describeInfo {get;set;}
    /*
    ** Method: Constructor
    */
    public CaseTgrHandler() {
        describeInfo = Schema.getGlobalDescribe();//Just call once cause each call to these method is expensive 
    }
    /*
    ** Method: isBeforeInsert
    ** Params: Map<Id,Case> the created Records
    ** Description: Handles the logic once a Case's been created
    */
    public static void isBeforeInsert(Map<Id,Case> TgrNew){
    }
    /*
    ** Method: isBeforeUpdate
    ** Params: Map<Id,Case> the updated Records
    ********** Map<Id,Case> the non updated Records
    ** Description: Handles the logic once a Case's been created
    */
    public static void isBeforeUpdate(Map<Id,Case> TgrNew,Map<Id,Case> TgrOld){
        validateType(TgrNew,TgrOld);
    }
    /*
    ** Method: isBeforeDelete
    ** Params: Map<Id,Case> the deleted Records
    ** Description: Handles the logic once a Case's been created
    */
    public static void isBeforeDelete(Map<Id,Case> TgrOld){
        
    }
    /*
    ** Method: isAfterInsert
    ** Params: Map<Id,Case> the created Records
    ** Description: Handles the logic once a Case's been created
    */
    public static void isAfterInsert(Map<Id,Case> TgrNew){
        if(TgrNew != null && TgrNew.Size()==1){
            CreateMilesTones(TgrNew);
        }
    }
    /*
    ** Method: isAfterupdate
    ** Params: Map<Id,Case> the updated Records
    ********** Map<Id,Case> the non updated Records
    ** Description: Handles the logic once a Case's been created
    */
    public static void isAfterupdate(Map<Id,Case> TgrNew,Map<Id,Case> TgrOld){
        
    }
    /*
    ** Method: isAfterDelete
    ** Params: Map<Id,Case> the deleted Records
    ** Description: Handles the logic once a Case's been created
    */
    public static void isAfterDelete(Map<Id,Case> TgrOld){
        
    }
    
    /*
    ** Method: validateType
    ** Params: Map<Id,Case> the updated Records
    ********** Map<Id,Case> the non updated Records
    ** Description: Checks the recordTypes and also validates that the status
    *************** is Closed and that the record is changing the status
    *************** If not from Trigger the data should be sent in the TgrNew and the TgrOld in Null
    */
    public static void validateType(Map<Id,Case> TgrNew,Map<Id,Case> TgrOld){
        describeInfo = Schema.getGlobalDescribe();//Just call once cause each call to this method is expensive 
        list<Case> casesToIns = new List<Case>();
        Case curRec = null;
        for(Id Cid : TgrNew.keySet()){
            curRec = curRec;
            String RcType = describeInfo.get('Case').getDescribe().getRecordTypeInfosById().get(String.ValueOf(curRec.get('RecordTypeId'))).getName();
            if(
                (label.CaseReclamoRcType == RcType && String.ValueOf(curRec.get('Status')) == label.CaseReclamoCerrado) || 
                (label.CaseSolicitudRcType == RcType && String.ValueOf(curRec.get('Status')) == label.caseSolicitudCerrado) &&
                curRec.get('Status') != TgrOld.get(Cid).get('Status')
            )
            {
                Map<String,object> params = new Map<String,object>();
                params.put('AccountId',curRec.get('AccountId'));
                params.put('OwnerId',curRec.get('OwnerId'));
                params.put('Subject',label.CaseEvaluacionSubject.replace('[CaseNumber]',String.ValueOf(curRec.get('CaseNumber'))));
                params.put('Product__c',curRec.get('Product__c'));
                params.put('type',curRec.get('type'));
                params.put('RecordtypeId',describeInfo.get('Case').getDescribe().getRecordTypeInfosByDeveloperName().get(label.CaseEvaluacionRcType).getRecordTypeId());
                casesToIns.add(CreateCase(params));
            }
            if(casesToIns.Size()>0){
                insert casesToIns;
            }
        }
    }
    /*
    ** Method: CreateCase
    ** Params: Map<String,object> the updated Records
    ** Description: Creates a Case with the given params
    */
    public static Case CreateCase(Map<String,object> params){
        Sobject Cs = new Case();
        for(String key : params.keySet()){
            cs.put(key,params.get(key));
        }
        return (Case)Cs;
    }

    public static void CreateMilesTones(Map<Id,Case> data){

    }

}