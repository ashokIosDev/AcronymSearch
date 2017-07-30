//
//  AcronymHelper.m
//  AcronymSearch
//
//  Created by Ashok on 7/29/17.
//  Copyright © 2017 Macys. All rights reserved.
//

#import "AcronymHelper.h"

@implementation AcronymHelper

+ (void)showOKAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:nil];
   
   
    [alert addAction:yesButton];
    [[self currentTopViewController] presentViewController:alert animated:YES completion:nil];
}

+ (void)showOKAlertWithError:(NSError *)error {
    [self showOKAlertWithTitle:@"Error" message:error.localizedDescription];
    NSLog(@"%@", error.localizedDescription);
}

+ (UIViewController *)currentTopViewController
{
    UIViewController *topVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while (topVC.presentedViewController)
    {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}
@end
