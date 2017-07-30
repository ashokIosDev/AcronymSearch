//
//  AcromineSearchResult.h
//  AcronymSearch
//
//  Created by Ashok on 7/29/17.
//  Copyright © 2017 Macys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AcromineSearchResult : NSObject

- (id)initWithDictionary:(NSDictionary *)data;


@property (nonatomic, strong) NSArray *results;
//TODO: Probably should model the other fields in the response. For this app they are not used.
@end
