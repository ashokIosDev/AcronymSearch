//
//  AcromineSearchResult.m
//  AcronymSearch
//
//  Created by Ashok on 7/29/17.
//  Copyright © 2017 Macys. All rights reserved.
//

#import "AcromineSearchResult.h"
#import "LongFormObject.h"

@interface AcromineSearchResult ()

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSDictionary *arryData;
@end

@implementation AcromineSearchResult

@synthesize data=_data;

- (id)init {
    if (self = [self initWithDictionary:nil]) {
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)data {
    if (self = [super init]) {
        _data = data;
        if (_data == nil) {
            _data = [NSDictionary dictionary];
        }
    }
    return self;
}

- (NSArray *)results {

    NSMutableArray *resultArray = [NSMutableArray array];
    [self.data[@"lfs"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *longformDict = (NSDictionary *)obj;
        NSString *lf = [longformDict valueForKey:@"lf"];
        NSNumber *freq = [longformDict valueForKey:@"freq"];
        NSNumber *since = [longformDict valueForKey:@"since"];
        NSArray *vars = [longformDict valueForKey:@"vars"];
        
        LongFormObject *longform = [[LongFormObject alloc] initWithLongform:lf freq:freq since:since];
        if(vars && [vars count] > 0){
            NSMutableArray *variations = [NSMutableArray array];
            [vars enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *longformDict = (NSDictionary *)obj;
                NSString *lf = [longformDict valueForKey:@"lf"];
                NSNumber *freq = [longformDict valueForKey:@"freq"];
                NSNumber *since = [longformDict valueForKey:@"since"];
                LongFormObject *longForm = [[LongFormObject alloc] initWithLongform:lf freq:freq since:since];
                [variations addObject:longForm];
            }];
            longform.variations = variations;
        }
        
        [resultArray addObject:longform];
    }];
    return resultArray;//self.data[@"lfs"];
}


@end
