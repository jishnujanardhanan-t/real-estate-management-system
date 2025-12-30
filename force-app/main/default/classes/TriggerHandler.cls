public abstract class TriggerHandler {

    public virtual void beforeInsert() {}
    public virtual void beforeUpdate() {}
    public virtual void afterInsert() {}
    public virtual void afterUpdate() {}

    public void run() {
        if (Trigger.isBefore) {
            if (Trigger.isInsert) beforeInsert();
            if (Trigger.isUpdate) beforeUpdate();
        }
        if (Trigger.isAfter) {
            if (Trigger.isInsert) afterInsert();
            if (Trigger.isUpdate) afterUpdate();
        }
    }
}