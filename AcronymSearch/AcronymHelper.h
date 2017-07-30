//
//  AcronymHelper.h
//  AcronymSearch
//
//  Created by Ashok on 7/29/17.
//  Copyright © 2017 Macys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "MBProgressHUD.h"

@interface AcronymHelper : NSObject

+ (void)showOKAlertWithTitle:(NSString *)title message:(NSString *)message;
+ (void)showOKAlertWithError:(NSError *)error;
+ (UIViewController *)currentTopViewController;
@end
