//
//  YYLabelTableViewCell.m
//  TextDisplayVS
//
//  Created by wangtao on 2018/7/20.
//  Copyright © 2018年 wangtao. All rights reserved.
//

#import "YYLabelTableViewCell.h"

@implementation YYLabelTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.yyLabel = [[YYLabel alloc] init];
        [self.contentView addSubview:self.yyLabel];
    }
    return self;
}

- (void)setMessage:(TDItem *)message {
    [super setMessage:message];

    [self.yyLabel setAttributedText:message.attStr];
    self.yyLabel.textLayout = message.yyLayout;
    self.yyLabel.size = message.yyLayout.textBoundingSize;
}
@end
