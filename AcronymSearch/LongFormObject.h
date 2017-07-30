//
//  LongFormObject.h
//  AcronymSearch
//
//  Created by Ashok on 7/30/17.
//  Copyright © 2017 Macys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LongFormObject : NSObject

@property (nonatomic,strong) NSString *longform;
@property (nonatomic,strong) NSNumber *freq;
@property (nonatomic,strong) NSNumber *since;
@property (nonatomic,strong) NSArray<LongFormObject *> *variations;


- (instancetype)initWithLongform:(NSString *)longform freq:(NSNumber *)freq since:(NSNumber *)since;
@end
