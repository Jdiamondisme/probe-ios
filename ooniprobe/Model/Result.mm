#import "Result.h"
#import "Measurement.h"

@implementation Result
@dynamic name, startTime, endTime, summary, dataUsageUp, dataUsageDown, ip, asn, asnName, country, networkName, networkType, done;

+ (NSDictionary *)defaultValuesForEntity {
    return @{@"startTime": [NSDate date], @"done" : [NSNumber numberWithBool:FALSE], @"dataUsageDown" : [NSNumber numberWithInt:0], @"dataUsageUp" : [NSNumber numberWithInt:0]};
}

- (SRKResultSet*)measurements {
    return [[[Measurement query] whereWithFormat:@"result = %@", self] fetch];
}

-(void)setAsnAndCalculateName:(NSString *)asn{
    //TODO calculate asnname
    self.asnName = @"Vodafone";
    self.asn = asn;
}

//https://stackoverflow.com/questions/7846495/how-to-get-file-size-properly-and-convert-it-to-mb-gb-in-cocoa
- (NSString*)getFormattedDataUsageUp{
    return [NSByteCountFormatter stringFromByteCount:self.dataUsageUp countStyle:NSByteCountFormatterCountStyleFile];
}
    
- (NSString*)getFormattedDataUsageDown{
    return [NSByteCountFormatter stringFromByteCount:self.dataUsageDown countStyle:NSByteCountFormatterCountStyleFile];
}

//Shark supports indexing by overriding the indexDefinitionForEntity method and returning an SRKIndexDefinition object which describes all of the indexes that need to be maintained on the object.

/*
+ (SRKIndexDefinition *)indexDefinitionForEntity {
    SRKIndexDefinition* idx = [SRKIndexDefinition new];
    [idx addIndexForProperty:@"name" propertyOrder:SRKIndexSortOrderAscending];
    [idx addIndexForProperty:@"age" propertyOrder:SRKIndexSortOrderAscending];
    return idx;
}
*/

-(void)save{
    [self commit];
    NSLog(@"---- START LOGGING RESULT OBJECT----");
    NSLog(@"%@", self);
    NSLog(@"---- END LOGGING RESULT OBJECT----");

    /*
     NSLog(@"---- START LOGGING RESULT OBJECT----");
     NSLog(@"%@", self);
     NSLog(@"---- END LOGGING RESULT OBJECT----");
    NSLog(@"name %@", self.name);
    NSLog(@"startTime %@", self.startTime);
    NSLog(@"endTime %@", self.endTime);
    NSLog(@"summary %@", self.summary);
    NSLog(@"dataUsageDown %ld", self.dataUsageDown);
    NSLog(@"dataUsageUp %ld", self.dataUsageUp);
     */
}

@end
