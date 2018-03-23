#import <Foundation/Foundation.h>
#import "Url.h"

@interface SettingsUtility : NSObject

+ (NSArray*)getSettingsCategories;
+ (NSArray*)getSettingsForCategory:(NSString*)categoryName;
+ (NSString*)getTypeForSetting:(NSString*)setting;

+ (NSDictionary*)getTests;
+ (NSArray*)getTestTypes;

+ (NSArray*)getAutomaticTestsEnabled;
+ (NSArray*)addRemoveAutomaticTest:(NSString*)testName;

+ (int)getVerbosity;

+ (NSArray*)getSitesCategories;

+ (NSArray*)getSitesCategoriesEnabled;
+ (void)addRemoveSitesCategory:(NSString*)categoryName;

+ (NSArray*)getSettingsForTest:(NSString*)testName :(BOOL)includeAll;

+ (BOOL)getSettingWithName:(NSString*)settingName;

+ (UIColor*)getColorForTest:(NSString*)testName;

+ (NSArray*)getUrlsTest;
@end
