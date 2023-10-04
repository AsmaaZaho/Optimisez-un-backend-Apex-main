trigger trigger_UpdateAccountCA on Order (after update) {
	//It will execute code logic after records of the Order object have been updated
    if(Trigger.isAfter && Trigger.isUpdate){
        Handler_UpdateAccountCA.updateAccountCAForTrigger(Trigger.new, Trigger.oldMap);
    }
}