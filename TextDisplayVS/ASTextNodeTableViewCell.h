//
//  ASTextNodeTableViewCell.h
//  TextDisplayVS
//
//  Created by wangtao on 2018/7/23.
//  Copyright © 2018年 wangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import <AsyncDisplayKit/ASTextNode2.h>

@interface ASTextNodeTableViewCell : BaseTableViewCell
@property (nonatomic, strong)ASTextNode2 *asLabel;
@end
