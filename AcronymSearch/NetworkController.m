//
//  NetworkController.m
//  AcronymSearch
//
//  Created by Ashok on 7/29/17.
//  Copyright © 2017 Macys. All rights reserved.
//

#import "NetworkController.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface NetworkController()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation NetworkController

static NSString *BASE_URL = @"http://www.nactem.ac.uk/software/acromine/";

+ (NetworkController *)instance {
    static NetworkController *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        // Setup a general API manager
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString: BASE_URL]];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/plain"]];
        
        // Setup the AFHTTPRequestOperationManager completion queue
        // responses on the general manager, are processed in this queue instead of the main (UI thread)
        self.manager.completionQueue = dispatch_queue_create("com.Macys.Api", DISPATCH_QUEUE_SERIAL);
        
        // Enable the spinner in the status bar - to indicate network activity
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    return self;
}

+ (void)getAcronym:(NSString *)acronym success:(void (^)(NSURLSessionDataTask *task, id response))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSDictionary *parameters = @{@"sf": acronym, @"lf": @""};
    [[self instance].manager GET:@"dictionary.py" parameters:parameters progress:nil success:success failure:failure];
  
}

@end
