//
//  NetworkController.h
//  AcronymSearch
//
//  Created by Ashok on 7/29/17.
//  Copyright © 2017 Macys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NetworkController : NSObject
+ (NetworkController *)instance;
+ (void)getAcronym:(NSString *)acronym success:(void (^)(NSURLSessionDataTask *task, id response))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
