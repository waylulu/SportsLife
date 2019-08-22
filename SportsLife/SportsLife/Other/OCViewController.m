//
//  OCViewController.m
//  SportsLife
//
//  Created by WTW on 2018/6/20.
//  Copyright © 2018年 west. All rights reserved.
//

#import "OCViewController.h"
#import "SportsLife-Swift.h"

@interface OCViewController ()

@end

@implementation OCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self setRightBarItem];

}

- (void)configUI{
    self.view.backgroundColor = [UIColor whiteColor];
    ///新建lable控件
    UILabel *lable=[[UILabel alloc]init];
    lable.backgroundColor=[UIColor orangeColor];
    //设置字体大小
    UIFont *font=[UIFont systemFontOfSize:15];
    lable.text=@"1.如果文本内容超出指定的矩形限制，\n2.本将被截去并在最后一个字符后加上省略号。如果没有指定NSStrin\n3.gDrawingUsesLineFragmentOrigin选项，则该选项被忽略如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。如果没有指定NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。如果没有指定NSStrin\n4.gDrawingUsesLineFragmentOrigin选项，则该选项被忽略如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。如果没有指定NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略\n5.如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。如果没有指定NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略";
    lable.font=font;
    //自动换行
    lable.numberOfLines=0;
    
    //设置文本范围。200代表宽度最大为200，到了200则换到下一行；MAXFLOAT代表长度不限
    CGSize strSize=CGSizeMake(UIScreen.mainScreen.bounds.size.width - 20, MAXFLOAT);
    //需跟lable字体大小一直，否则会显示不全等问题
    NSDictionary *attr=@{NSFontAttributeName:font};
    CGSize lableSize=[lable.text boundingRectWithSize:strSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    lable.frame=CGRectMake(10, 100, lableSize.width, lableSize.height);
    
    [self.view addSubview:lable];
}

- (void)setRightBarItem{
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:@"跳网页" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightClickBtn:)];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (IBAction)rightClickBtn:(id)sender{
    
    HTWebViewViewController * vc = [HTWebViewViewController new];
    [self.navigationController pushViewController:vc animated:true];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
