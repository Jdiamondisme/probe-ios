// Part of MeasurementKit <https://measurement-kit.github.io/>.
// MeasurementKit is free software. See AUTHORS and LICENSE for more
// information on the copying conditions.

#import <UIKit/UIKit.h>

@interface AdvancedSettingsTableViewController : UITableViewController <UIAlertViewDelegate>
{
    NSArray *settingsItems;
    UITextField *value;
}

@end