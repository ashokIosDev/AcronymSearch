//
//  SearchField.h
//  AcronymSearch
//
//  Created by Ashok on 7/29/17.
//  Copyright © 2017 Macys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchField : UIView
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *searchTxtFld;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (nonatomic, copy) void (^btnActionBlock)();

@end
