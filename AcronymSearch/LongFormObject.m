//
//  LongFormObject.m
//  AcronymSearch
//
//  Created by Ashok on 7/30/17.
//  Copyright © 2017 Macys. All rights reserved.
//

#import "LongFormObject.h"

@implementation LongFormObject

- (instancetype)initWithLongform:(NSString *)longform freq:(NSNumber *)freq since:(NSNumber *)since{
    
    self = [super init];
    if(self){
        _longform = longform;
        _freq = freq;
        _since = since;
    }
    
    return self;
}

@end
