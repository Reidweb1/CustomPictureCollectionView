//
//  SPTextFieldHeader.h
//  PictureBoxDemo
//
//  Created by Reid Weber on 12/9/15.
//  Copyright © 2015 Reid Weber. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SPTextFieldHeaderDelegate <NSObject>

@required
- (void)giveUpButtonAction;

@optional
- (void)helpButtonAction;

@end

@interface SPTextFieldHeader : UIView

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title;

@property (strong, nonatomic) UITextField *textField;
@property (weak, nonatomic) id<SPTextFieldHeaderDelegate> delegate;

@end
