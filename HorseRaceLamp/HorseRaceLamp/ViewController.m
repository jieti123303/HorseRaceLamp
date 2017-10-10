//
//  ViewController.m
//  HorseRaceLamp
//
//  Created by zhangkai on 2017/10/9.
//  Copyright © 2017年 liudejuan. All rights reserved.
//

#import "ViewController.h"
#import "LDJAutoRunLabel.h"

@interface ViewController ()<LDJAutoRunLabelDelegate>

@property (nonatomic,strong) LDJAutoRunLabel *autoLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建label
    [self createAutoRunLabel];
    
    // 创建停止btn
    [self createBtn];
    
    // 创建暂停开始btn
    [self creteStartBtn];
}

-(void)creteStartBtn{
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(100, 400, 100, 50);
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"start按钮" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(startToTableView) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}

-(void)createBtn{
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(100, 200, 100, 50);
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"暂停按钮" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(pauseAnimationAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}

//暂停后开始
-(void)startToTableView{
    [self.autoLabel startPauseAnimation];
}

//暂停
-(void)pauseAnimationAction{
    [self.autoLabel pauseAnimation];
}

- (void)createAutoRunLabel {
    LDJAutoRunLabel *runLabel = [[LDJAutoRunLabel alloc] initWithFrame:CGRectMake(0, 100, 375, 50)];
    runLabel.backgroundColor = [UIColor redColor];
    runLabel.delegate = self;
    runLabel.directionType = LeftType;
    [self.view addSubview:runLabel];
    [runLabel addContentView:[self createLabelWithText:@"繁华声 遁入空门 折煞了梦偏冷 辗转一生 情债又几 如你默认 生死枯等 枯等一圈 又一圈的 浮图塔 断了几层 断了谁的痛直奔 一盏残灯 倾塌的山门 容我再等 历史转身 等酒香醇 等你弹 一曲古筝" textColor:[self randomColor] labelFont:[UIFont systemFontOfSize:14]]];
    [runLabel startAnimation];
    
    self.autoLabel = runLabel;
}

- (UILabel *)createLabelWithText: (NSString *)text textColor:(UIColor *)textColor labelFont:(UIFont *)font {
    NSString *string = [NSString stringWithFormat:@"%@", text];
    CGSize size = [self getAttributeSizeWithText:string fontSize:font];
    CGFloat width = size.width;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 50)];
    label.font = font;
    label.text = string;
    label.textColor = textColor;
    return label;
}
#pragma mark --- 计算文字的宽度
-(CGSize)getAttributeSizeWithText:(NSString *)text fontSize:(UIFont *)fontSize
{
    CGSize size=[text sizeWithAttributes:@{NSFontAttributeName: fontSize}];
    
    size=[text sizeWithAttributes:@{NSFontAttributeName: fontSize}];
    return size;
}


- (UIColor *)randomColor {
    return [UIColor colorWithRed:[self randomValue] green:[self randomValue] blue:[self randomValue] alpha:1];
}

- (CGFloat)randomValue {
    return arc4random()%255 / 255.0f;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
