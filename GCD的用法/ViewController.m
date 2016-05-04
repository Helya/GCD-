//
//  ViewController.m
//  GCD的用法
//
//  Created by 余敏侠 on 16/5/4.
//  Copyright © 2016年 secrui Co.,Ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)btn1:(id)sender;
- (IBAction)btn2:(id)sender;
- (IBAction)btn3:(id)sender;
- (IBAction)btn4:(id)sender;
- (IBAction)btn5:(id)sender;
- (IBAction)btn6:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"打印当前线程----->%@",[NSThread currentThread]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn1:(id)sender {
    //延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"延迟执行 ， 线程---->%@",[NSThread currentThread]);
    });

    //并发队列,自定义时间点,default定义的是线程的等级,0是标志
    dispatch_queue_t queeeee= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_time_t timeeeeee = dispatch_time(DISPATCH_TIME_NOW,
                                              5.0*NSEC_PER_SEC);
    dispatch_after(timeeeeee, queeeee, ^{
        NSLog(@"并发队列 ，延迟执行，线程---->%@",[NSThread currentThread]);
    });
}

- (IBAction)btn2:(id)sender {
    //并发队列后台处理数据。dispatch_async 函数会将传入的block块放入指定的queue里运行。这个函数是异步的，这就意味着它会立即返回而不管block是否运行结束。因此，我们可以在block里运行各种耗时的操作（如网络请求） 而同时不会阻塞UI线程。
    //dispatch_get_global_queue 会获取一个全局队列，我们姑且理解为系统为我们开启的一些全局线程。我们用priority指定队列的优先级，而flag作为保留字段备用（一般为0）。
    //dispatch_get_main_queue 会返回主队列
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"此处处理延时的操作");
        sleep(5);//此处可以继续跳到主队列去处理其他动作
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"返回主队列去更新UI");
        });
    });
}

- (IBAction)btn3:(id)sender {
    //predicate是判断后面代码块是否执行的一个谓标志，此方法可用来创建单例
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        NSLog(@"该代码只执行一次");
    });
}

- (IBAction)btn4:(id)sender {
}

- (IBAction)btn5:(id)sender {
}

- (IBAction)btn6:(id)sender {
}
@end
