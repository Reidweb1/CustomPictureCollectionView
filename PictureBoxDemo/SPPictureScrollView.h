//
//  SPPictureScrollView.h
//  PictureBoxDemo
//
//  Created by Reid Weber on 12/3/15.
//  Copyright © 2015 Reid Weber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPPictureBoxCell.h"

@interface SPPictureScrollView : UIView <SPPictureBoxCellDelegate>

- (void)setScrollContentSize:(CGFloat)height;

@end
