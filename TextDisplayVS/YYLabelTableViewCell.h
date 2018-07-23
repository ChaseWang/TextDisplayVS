//
//  YYLabelTableViewCell.h
//  TextDisplayVS
//
//  Created by wangtao on 2018/7/20.
//  Copyright © 2018年 wangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYLabel.h"
#import "BaseTableViewCell.h"
#import "UIView+Additions.h"

@interface YYLabelTableViewCell : BaseTableViewCell
@property (nonatomic, strong)YYLabel *yyLabel;
@end
