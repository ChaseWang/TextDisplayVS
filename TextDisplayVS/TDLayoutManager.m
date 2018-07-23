//
//  TDLayoutManager.m
//  TextDisplayVS
//
//  Created by wangtao on 2018/7/20.
//  Copyright © 2018年 wangtao. All rights reserved.
//

#import "TDLayoutManager.h"

@implementation TDLayoutManager
- (void)drawGlyphsForGlyphRange:(NSRange)glyphsToShow atPoint:(CGPoint)origin {
    [super drawGlyphsForGlyphRange:glyphsToShow atPoint:origin];
    NSTextStorage *copyStorage = [self.textStorage copy];
    NSRange range = NSMakeRange(MAX(0, glyphsToShow.location), MIN(copyStorage.length, glyphsToShow.location + glyphsToShow.length));
    [copyStorage enumerateAttributesInRange:range
                                    options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                                 usingBlock:^(NSDictionary<NSAttributedStringKey, id> *attrs, NSRange range, BOOL * _Nonnull stop)
     {
         CGRect rect = [self boundingRectForGlyphRange:range
                                       inTextContainer:[self textContainerForGlyphAtIndex:range.location effectiveRange:NULL]];
     }];
}

@end
