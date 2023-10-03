trigger trigger_UpdateAccountCA on Order (after update) {
	
    if(Trigger.isAfter && Trigger.isUpdate){
        Handler_UpdateAccountCA.updateAccountCAForTrigger(Trigger.new, Trigger.oldMap);
    }
}