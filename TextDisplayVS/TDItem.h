//
//  TDItem.h
//  TextDisplayVS
//
//  Created by wangtao on 2018/7/20.
//  Copyright © 2018年 wangtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYLabel.h"

@interface TDItem : NSObject
@property (nonatomic, strong)NSString *text;
@property (nonatomic, strong)NSMutableAttributedString *attStr;
@property (nonatomic, strong)YYTextLayout *yyLayout;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, assign)CGFloat width;
@end
