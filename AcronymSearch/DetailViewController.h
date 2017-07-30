//
//  DetailViewController.h
//  AcronymSearch
//
//  Created by Ashok on 7/30/17.
//  Copyright © 2017 Macys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LongFormObject.h"

@interface DetailViewController : UIViewController<UITableViewDataSource, UITableViewDataSource>

 @property(nonatomic,strong,nonnull) NSString *shortform;
 @property(nonatomic,strong,nonnull) LongFormObject *longform;

@end
