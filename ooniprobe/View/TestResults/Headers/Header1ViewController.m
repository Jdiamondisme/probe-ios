#import "Header1ViewController.h"
#import "SettingsUtility.h"
@interface Header1ViewController ()

@end

@implementation Header1ViewController
@synthesize result;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.headerView setBackgroundColor:[SettingsUtility getColorForTest:result.name]];
    Summary *summary = [self.result getSummary];

    if ([result.name isEqualToString:@"websites"]){
        [self.view4 setHidden:YES];
        
        [self.label1Top setText:NSLocalizedString(@"tested", nil)];
        [self.label1Central setText:[NSString stringWithFormat:@"%ld", summary.totalMeasurements]];
        [self.label1Bottom setText:NSLocalizedString(@"sites", nil)];

        [self.label2Top setText:NSLocalizedString(@"blocked", nil)];
        [self.label2Central setText:[NSString stringWithFormat:@"%ld", summary.blockedMeasurements]];
        [self.label2Bottom setText:NSLocalizedString(@"sites", nil)];

        [self.label3Top setText:NSLocalizedString(@"reachable", nil)];
        [self.label3Central setText:[NSString stringWithFormat:@"%ld", summary.okMeasurements]];
        [self.label3Bottom setText:NSLocalizedString(@"found", nil)];
    }
    else if ([result.name isEqualToString:@"instant_messaging"]){
        [self.view4 setHidden:YES];
        
        [self.label1Top setText:NSLocalizedString(@"tested", nil)];
        [self.label1Central setText:[NSString stringWithFormat:@"%ld", summary.totalMeasurements]];
        [self.label1Bottom setText:NSLocalizedString(@"apps", nil)];

        [self.label2Top setText:NSLocalizedString(@"blocked", nil)];
        [self.label2Central setText:[NSString stringWithFormat:@"%ld", summary.blockedMeasurements]];
        [self.label2Bottom setText:NSLocalizedString(@"apps", nil)];

        [self.label3Top setText:NSLocalizedString(@"reachable", nil)];
        [self.label3Central setText:[NSString stringWithFormat:@"%ld", summary.okMeasurements]];
        [self.label3Bottom setText:NSLocalizedString(@"apps", nil)];
    }
    else if ([result.name isEqualToString:@"performance"]){
        [self addLine:self.view4];
        [self.label1Top setText:NSLocalizedString(@"video", nil)];
        [self.label1Central setText:[summary getVideoQuality:YES]];
        [self.label1Bottom setText:NSLocalizedString(@"quality", nil)];
        
        [self.label2Top setText:NSLocalizedString(@"upload", nil)];
        [self.label2Central setText:[summary getUpload]];
        [self.label2Bottom setText:[summary getUploadUnit]];
        
        [self.label3Top setText:NSLocalizedString(@"download", nil)];
        [self.label3Central setText:[summary getDownload]];
        [self.label3Bottom setText:[summary getDownloadUnit]];

        [self.label4Top setText:NSLocalizedString(@"ping", nil)];
        [self.label4Central setText:[summary getPing]];
        [self.label4Bottom setText:NSLocalizedString(@"ms", nil)];
    }

    
    [self addLine:self.view2];
    [self addLine:self.view3];
/*
 UIView *LineView=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-5, 0, 1, self.view.frame.size.height)]; // customize the frame what u need
 [LineView setBackgroundColor:[UIColor whiteColor]]; //customize the color
 [self.view1 addSubview:LineView];
 

    CGFloat sortaPixel = 1 / [UIScreen mainScreen].scale;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, sortaPixel)];
    
    line.userInteractionEnabled = NO;
    line.backgroundColor = self.backgroundColor;
    
    line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self.view1 addSubview:line];
    
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
*/
}

-(void)addLine:(UIView*)view{
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, view.frame.size.height)];
    [lineView setBackgroundColor:[UIColor whiteColor]];
    [view addSubview:lineView];
}

@end
