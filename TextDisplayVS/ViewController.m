//
//  ViewController.m
//  TextDisplayVS
//
//  Created by wangtao on 2018/7/18.
//  Copyright © 2018年 wangtao. All rights reserved.
//

#import "ViewController.h"
#import "YYLabel.h"
#import "YYLabelTableViewCell.h"
#import "UILabelTableViewCell.h"
#import "UITextViewTableViewCell.h"
#import "ASTextNodeTableViewCell.h"

//#define showType 1 //YY
#define showType 2 //UILabel
//#define showType 3 //UITextView
//#define showType 4 //ASTextNode2

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)NSArray *texts;
@property (nonatomic, strong)NSTimer *msgTimer;
@property (nonatomic, strong)NSTimer *freshTimer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    _tableView.directionalLockEnabled = YES;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.alwaysBounceVertical = YES;
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableView];

    [_tableView registerClass:[YYLabelTableViewCell class] forCellReuseIdentifier:@"YYLabelTableViewCell"];
    [_tableView registerClass:[UILabelTableViewCell class] forCellReuseIdentifier:@"UILabelTableViewCell"];
    [_tableView registerClass:[UITextViewTableViewCell class] forCellReuseIdentifier:@"UITextViewTableViewCell"];
    [_tableView registerClass:[ASTextNodeTableViewCell class] forCellReuseIdentifier:@"ASTextNodeTableViewCell"];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"hotel" ofType:@"txt"];
    NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.texts = [string componentsSeparatedByString:@"\n"];

    self.dataSource = [NSMutableArray array];

    [self dealWithData];

    __weak ViewController *wself = self;
    self.freshTimer = [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [wself updateTableView];
    }];

    self.msgTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [wself dealWithData];
    }];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)dealWithData {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.texts enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TDItem *item = [[TDItem alloc] init];
            item.text = obj;

            NSMutableDictionary *attributeDict = [NSMutableDictionary dictionaryWithCapacity:6];

            static NSMutableParagraphStyle *paragraphStyle = nil;
            if (!paragraphStyle) {
                paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
                paragraphStyle.alignment = NSTextAlignmentLeft;
                paragraphStyle.headIndent = 3;
                paragraphStyle.firstLineHeadIndent = 0;
                paragraphStyle.minimumLineHeight = 20;
                paragraphStyle.maximumLineHeight = 20;
                paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
            }

            UIFont *font = [UIFont boldSystemFontOfSize:14];
            CTFontRef ctFont = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
            [attributeDict setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
            [attributeDict setObject:(__bridge id)ctFont forKey:(NSString *)kCTFontAttributeName];
            [attributeDict setObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
            [attributeDict setObject:@(1) forKey:NSBaselineOffsetAttributeName];
            CFRelease(ctFont);

            item.attStr = [[NSMutableAttributedString alloc] initWithString:item.text attributes:attributeDict];

            if (showType == 1) {
                YYTextContainer *container = [YYTextContainer new];
                container.size = CGSizeMake(200, CGFLOAT_MAX);
                container.maximumNumberOfRows = 0;
                item.yyLayout = [YYTextLayout layoutWithContainer:container text:item.attStr];
                item.height = item.yyLayout.textBoundingSize.height + 5;
            }else if (showType == 2) {
                NSTextAttachment *attc = [[NSTextAttachment alloc] init];
                attc.image = nil;
                attc.bounds = CGRectMake(0, 0, 30, 30);

                NSAttributedString *imgAttr = [NSAttributedString attributedStringWithAttachment:attc];
                [item.attStr appendAttributedString:imgAttr];

                CGRect rect = [item.attStr boundingRectWithSize:CGSizeMake(200, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
                item.height = rect.size.height + 5;
                item.width = rect.size.width;
            }else if (showType == 3) {
                CGRect rect = [item.attStr boundingRectWithSize:CGSizeMake(200, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
                item.height = rect.size.height + 5;
                item.width = rect.size.width;
            }else if (showType == 4) {
                CGRect rect = [item.attStr boundingRectWithSize:CGSizeMake(200, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
                item.height = rect.size.height + 5;
                item.width = rect.size.width;
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.dataSource addObject:item];
            });
        }];
    });
}


- (void)dealTextViewData {

}

- (void)updateTableView
{
    [self.tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (showType == 1) {
        YYLabelTableViewCell *labelCell = [tableView dequeueReusableCellWithIdentifier:@"YYLabelTableViewCell"];
        TDItem *item = [self.dataSource objectAtIndex:indexPath.row];
        [labelCell setMessage:item];
        return labelCell;
    }else if (showType == 2){
        UILabelTableViewCell *labelCell = [tableView dequeueReusableCellWithIdentifier:@"UILabelTableViewCell"];
        TDItem *item = [self.dataSource objectAtIndex:indexPath.row];
        [labelCell setMessage:item];
        return labelCell;
    }else if (showType == 3){
        UITextViewTableViewCell *labelCell = [tableView dequeueReusableCellWithIdentifier:@"UITextViewTableViewCell"];
        TDItem *item = [self.dataSource objectAtIndex:indexPath.row];
        [labelCell setMessage:item];
        return labelCell;
    }else {
        ASTextNodeTableViewCell *labelCell = [tableView dequeueReusableCellWithIdentifier:@"ASTextNodeTableViewCell"];
        TDItem *item = [self.dataSource objectAtIndex:indexPath.row];
        [labelCell setMessage:item];
        return labelCell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TDItem *item = [self.dataSource objectAtIndex:indexPath.row];
    return item.height;
}
@end
