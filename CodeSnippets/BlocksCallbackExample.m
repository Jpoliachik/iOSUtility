- (void)doThingWithString:(NSString *)stringObject onCompletion:(void (^)(NSString *response))completionblock onFailure:(void (^)(NSError *error))failureblock
{
	//Do data processing in background. Back on main thread, call onCompletion or onFailure
	successblock(stringObject);
	failureblock(NSError *error);
}
