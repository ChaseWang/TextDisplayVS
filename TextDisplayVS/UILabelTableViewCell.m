//
//  UILabelTableViewCell.m
//  TextDisplayVS
//
//  Created by wangtao on 2018/7/20.
//  Copyright © 2018年 wangtao. All rights reserved.
//

#import "UILabelTableViewCell.h"
#import "UIView+Additions.h"

@implementation UILabelTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.ttLabel = [[UILabel alloc] init];
        self.ttLabel.numberOfLines = 0;
        [self.contentView addSubview:self.ttLabel];
    }
    return self;
}

- (void)setMessage:(TDItem *)message {
    [super setMessage:message];

    //[self.ttLabel setAttributedText:nil];
    [self.ttLabel setAttributedText:message.attStr];
    [self.ttLabel setNeedsDisplay];
    self.ttLabel.height = message.height;
    self.ttLabel.width = message.width;
}
@end
