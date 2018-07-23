//
//  UITextViewTableViewCell.h
//  TextDisplayVS
//
//  Created by wangtao on 2018/7/20.
//  Copyright © 2018年 wangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface UITextViewTableViewCell : BaseTableViewCell
@property (nonatomic, strong) UITextView *contentTextView;
@end
