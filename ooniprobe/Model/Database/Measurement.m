#import "Measurement.h"
#import "Result.h"
#import "TestUtility.h"
#import "NetworkSession.h"
#import "OONIApi.h"

@implementation Measurement
@dynamic test_name, start_time, runtime, is_done, is_uploaded, is_failed, failure_msg, is_upload_failed, upload_failure_msg, is_rerun, rerun_network, report_id, url_id, test_keys, is_anomaly, result_id;

@synthesize testKeysObj = _testKeysObj;

+ (NSDictionary *)defaultValuesForEntity {
    return @{@"start_time": [NSDate date]};
}

+ (SRKResultSet*)notUploadedMeasurements {
    return [[[Measurement query] where:NOT_UPLOADED_QUERY] fetch];
}

+ (SRKResultSet*)selectWithReportId:(NSString*)report_id {
    return [[[Measurement query]
               where:[NSString stringWithFormat:@"%@ AND report_id = ?", REPORT_QUERY]
               parameters:@[report_id]]
               fetch];
}

+ (NSMutableOrderedSet*)getReportsUploaded {
    NSMutableOrderedSet *reportIds = [NSMutableOrderedSet new];
    SRKResultSet* results = [[[Measurement query] where:REPORT_QUERY] fetch];
    for (Measurement *measurement in results){
        if ([measurement hasReportFile])
            [reportIds addObject:measurement.report_id];
    }
    return reportIds;
}

+ (NSArray*)measurementsWithLog {
    NSMutableArray *measurementsLog = [NSMutableArray new];
    SRKResultSet* results = [[[Measurement query] where:BASIC_QUERY] fetch];
    for (Measurement *measurement in results){
        if ([measurement hasLogFile])
            [measurementsLog addObject:measurement];
    }
    return measurementsLog;
}

/*
    Three scenarios:
    I'm running the test, I start the empty summary, I add stuff and save
    I'm running the test, there is data in the summary, I add stuff and save
 I have to get the sum(no(nonatomic) natomic) mary of an old test and don't modify it
*/
- (TestKeys*)testKeysObj{
    if (!_testKeysObj){
        if (self.test_keys){
            NSError *error;
            NSData *data = [self.test_keys dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (error != nil) {
                NSLog(@"Error parsing JSON: %@", error);
                _testKeysObj = [[TestKeys alloc] init];
            }
            _testKeysObj = [TestKeys objectFromDictionary:jsonDic];
        }
        else
            _testKeysObj = [[TestKeys alloc] init];
    }
    return _testKeysObj;
}

- (void)setTestKeysObj:(TestKeys *)testKeysObj{
    _testKeysObj = testKeysObj;
    self.test_keys = [self.testKeysObj getJsonStr];
}

-(BOOL)hasReportFile{
    return [TestUtility fileExists:[self getReportFile]];
}

-(BOOL)hasLogFile{
    return [TestUtility fileExists:[self getLogFile]];
}

-(NSString*)getReportFile{
    //LOGS: resultID_test_name.log
    return [NSString stringWithFormat:@"%@-%@.json",  self.Id, self.test_name];
}

-(NSString*)getLogFile{
    //JSON: measurementID_test_name.log
    return [self.result_id getLogFile:self.test_name];
}

-(NSString*)getLocalizedStartTime{
    //from https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/InternationalizingLocaleData/InternationalizingLocaleData.html
    NSString *localizedDateTime = [NSDateFormatter localizedStringFromDate:self.start_time dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    return localizedDateTime;
}

-(void)save{
    [self commit];
    /*
    NSLog(@"---- START LOGGING MEASUREMENT OBJECT----");
    NSLog(@"%@", self);
    NSLog(@"---- END LOGGING MEASUREMENT OBJECT----");
     */
}

-(void)setReRun{
    self.is_rerun = TRUE;
    [TestUtility removeFile:[self getLogFile]];
    [TestUtility removeFile:[self getReportFile]];
    [self save];
}

-(void)deleteObject{
    [TestUtility removeFile:[self getLogFile]];
    [TestUtility removeFile:[self getReportFile]];
    [self remove];
}

-(void)getExplorerUrl:(void (^)(NSDictionary*))successcb onError:(void (^)(NSError*))errorcb {
    [OONIApi getExplorerUrl:self.report_id
                    withUrl:((self.url_id != nil) ? self.url_id.url : nil)
                  onSuccess:successcb
                    onError:errorcb];
}

-(void)checkPublished:(void (^)(BOOL))successcb onError:(void (^)(NSError*))errorcb{
    [OONIApi checkReportId:self.report_id
                 onSuccess:successcb
                   onError:errorcb];
}

@end
