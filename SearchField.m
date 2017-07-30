//
//  SearchField.m
//  AcronymSearch
//
//  Created by Ashok on 7/29/17.
//  Copyright © 2017 Macys. All rights reserved.
//

#import "SearchField.h"
@interface SearchField ()

@property (assign, nonatomic) BOOL isEditing;

@end

@implementation SearchField


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initForView];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initForView];
    }
    return self;
}

- (void)initForView
{
   // dispatch_async(dispatch_get_main_queue(), ^{
    //UIView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] objectAtIndex:0];
    view.frame = self.bounds;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:view];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
    
    //making the entire view touchable
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapAction)];
    singleFingerTap.cancelsTouchesInView = NO; //add this line
    [self addGestureRecognizer:singleFingerTap];
    
    // Default keyboard types
    self.searchTxtFld.autocorrectionType = UITextAutocorrectionTypeNo;
    self.searchTxtFld.returnKeyType = UIReturnKeyDone;
       // });
}

- (void)onTapAction
{
    if (!self.searchTxtFld.userInteractionEnabled)
        return;
    self.isEditing = !self.isEditing;
    if (self.isEditing) {
        [self.superview.superview.superview endEditing:YES];
    } else {
        [self.searchTxtFld becomeFirstResponder];
    }
}

- (IBAction)searchBtnAction:(id)sender {
    if (self.btnActionBlock)
        [self.btnActionBlock invoke];
}




@end
