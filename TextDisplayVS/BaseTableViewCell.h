//
//  BaseTableViewCell.h
//  TextDisplayVS
//
//  Created by wangtao on 2018/7/20.
//  Copyright © 2018年 wangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDItem.h"

@interface BaseTableViewCell : UITableViewCell
@property (nonatomic, strong)TDItem *message;
@end
