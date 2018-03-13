#import "RunButton.h"

@implementation RunButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.layer.cornerRadius = 15;
    self.layer.masksToBounds = YES;
    [self setTitle:NSLocalizedString(@"run", nil) forState:UIControlStateNormal];
/*
    UIColor *defaultTintColor = color_ooni_blue;
    self.layer.borderWidth = 1;
    self.layer.borderColor = defaultTintColor.CGColor;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    [self setTitleColor:defaultTintColor forState:UIControlStateNormal];
    [self setTitleColor:color_off_white forState:UIControlStateHighlighted];
    UIImage *backGroundImage = [self createSolidColorImageWithColor:defaultTintColor
                                                               andSize:self.bounds.size];
    [self setBackgroundImage:backGroundImage forState:UIControlStateHighlighted];
 */
}

- (UIImage*)createSolidColorImageWithColor:(UIColor*)color andSize:(CGSize)size
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGRect fillRect = CGRectMake(0, 0, size.width, size.height);
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    CGContextFillRect(currentContext, fillRect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
