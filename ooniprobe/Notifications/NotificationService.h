#import <Foundation/Foundation.h>
#import "ReachabilityManager.h"

@interface NotificationService : NSObject
+ (id)sharedNotificationService;

+ (void)registerUserNotification;
- (void)updateClient;

@property (strong, nonatomic) NSString *platform;
@property (strong, nonatomic) NSString *software_name;
@property (strong, nonatomic) NSString *software_version;
@property (strong, nonatomic) NSArray *supported_tests;
@property (strong, nonatomic) NSString *network_type;
@property (strong, nonatomic) NSString *available_bandwidth;
@property (strong, nonatomic) NSString *device_token;
@property (strong, nonatomic) NSString *language;

@end
