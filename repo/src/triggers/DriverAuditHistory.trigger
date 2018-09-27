trigger DriverAuditHistory on Driver__c(before delete, before insert, before update, 
                                    after delete, after insert, after update) {
    if (Trigger.isBefore) {
        if (Trigger.isDelete) {
    
            // In a before delete trigger, write the delete action to Quote Audit History.
            List<Quote_Audit_History__c> qAudit = new List<Quote_Audit_History__c>();
            for (Driver__c d : Trigger.old) {
                qAudit.add(new Quote_Audit_History__c(
                    Quote__c=d.Quote__c,
                    Entity__c='Driver',
                    Action__c='Record Deleted',
                    Details__c='Driver: ' +d.Name__c+' deleted by '+Userinfo.getName())); 
            }
            insert qAudit;
        } else if (Trigger.isUpdate) {
    
        // In before insert or before update triggers, the trigger adds insert/update records
            List<Quote_Audit_History__c> qAudit = new List<Quote_Audit_History__c>();
            for (Driver__c d : Trigger.New) {
                qAudit.add(new Quote_Audit_History__c(
                    Quote__c=d.Quote__c,
                    Entity__c='Driver',
                    Action__c='Record Updated',
                    Details__c='Driver: ' +d.Name__c+' updated by '+Userinfo.getName())); 
            }
            insert qAudit;
        }
        if (Trigger.isInsert) {
            List<Quote_Audit_History__c> qAudit = new List<Quote_Audit_History__c>();
            for (Driver__c d : Trigger.New) {
                qAudit.add(new Quote_Audit_History__c(
                    Quote__c=d.Quote__c,
                    Entity__c='Driver',
                    Action__c='Record Added',
                    Details__c='Driver: ' +d.Name__c+' added by '+Userinfo.getName())); 
            }
            insert qAudit;
    
    // If the trigger is not a before trigger, it must be an after trigger.
    } else {
        /*if (Trigger.isInsert) {
            List<Quote_Audit_History__c> qAudit = new List<Quote_Audit_History__c>();
            for (Driver__c d : Trigger.New) {
                qAudit.add(new Quote_Audit_History__c(
                    Quote__c=d.Quote__c,
                    Entity__c='Driver',
                    Action__c='Record Added',
                    Details__c='Driver: ' +d.Name__c+' added by '+Userinfo.getName())); 
            }
            insert qAudit;
        }*/
      }
    }
}