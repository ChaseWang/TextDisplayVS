//
//  ASTextNodeTableViewCell.m
//  TextDisplayVS
//
//  Created by wangtao on 2018/7/23.
//  Copyright © 2018年 wangtao. All rights reserved.
//

#import "ASTextNodeTableViewCell.h"

@implementation ASTextNodeTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.asLabel = [[ASTextNode2 alloc] init];
        [self.contentView addSubnode:self.asLabel];
    }
    return self;
}

- (void)setMessage:(TDItem *)message {
    [super setMessage:message];
    [self.asLabel setFrame:CGRectMake(0, 0, message.width, message.height)];
    [self.asLabel setAttributedText:message.attStr];
}
@end
