//
//  SPPictureBoxCell.h
//  PictureBoxDemo
//
//  Created by Reid Weber on 12/3/15.
//  Copyright © 2015 Reid Weber. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPPictureBoxCell;

@protocol SPPictureBoxCellDelegate <NSObject>

- (void)pictureCellPressed:(SPPictureBoxCell *)cell;

@end

@interface SPPictureBoxCell : UIView

- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image;

- (void)highlightCell;
- (void)unhighlightCell;

@property (weak, nonatomic) id<SPPictureBoxCellDelegate> delegate;

@end
