//
//  UITextViewTableViewCell.m
//  TextDisplayVS
//
//  Created by wangtao on 2018/7/20.
//  Copyright © 2018年 wangtao. All rights reserved.
//

#import "UITextViewTableViewCell.h"
#import "TDLayoutManager.h"

@implementation UITextViewTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSTextContainer *container = [[NSTextContainer alloc] init];
        container.widthTracksTextView = YES;
        container.lineFragmentPadding = 0;

        NSTextStorage *textStorage = [[NSTextStorage alloc] initWithString:@""];

        TDLayoutManager *layoutManager = [[TDLayoutManager alloc] init];
        [textStorage addLayoutManager:layoutManager];
        [layoutManager addTextContainer:container];

        UITextView *contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(14, 1, 200, self.contentView.bounds.size.height - 5) textContainer:container];
        contentTextView.font = [UIFont boldSystemFontOfSize:14];
        contentTextView.backgroundColor = [UIColor clearColor];
        contentTextView.textColor = [UIColor redColor];
        contentTextView.textContainerInset = UIEdgeInsetsZero;
        contentTextView.editable = NO;
        contentTextView.scrollEnabled = NO;
        contentTextView.userInteractionEnabled = NO;
        contentTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:contentTextView];
        self.contentTextView = contentTextView;
    }
    return self;
}

- (void)setMessage:(TDItem *)message {
    [super setMessage:message];
    [self.contentTextView setAttributedText:message.attStr];
}
@end
