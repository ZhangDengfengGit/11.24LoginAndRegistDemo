//
//  RegistViewController.m
//  LoginAndRegistDemo
//
//  Created by lanouhn on 15/11/24.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "RegistViewController.h"
#import "AFNetworking.h"
@interface RegistViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *markTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation RegistViewController
- (IBAction)getMarkAction:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *dic = @{@"phone":self.phoneTextField.text};
    [manager POST:@"http://washtest.cheguchina.com/api/user/registerCode" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject[@"message"]);
        int num = [[responseObject objectForKey:@"status"]intValue];
        if (num == 200) {
            NSLog(@"获取验证码成功. 让定时器开始倒计时, 并且取消交互");
        }else {
            NSLog(@"弹窗:错误信息:%@", [responseObject objectForKey:@"message"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"验证码:error%@", error);
    }];
}
- (IBAction)doneRegistAction:(id)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *dic = @{@"code":self.markTextField.text, @"phone":self.phoneTextField.text, @"password":self.passwordTextField.text};
    [manager POST:@"http://washtest.cheguchina.com/api/user/register" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        //如果登录是成功的, 就将账号的密码一起写入到本地(NSUserDefaults)存储方法. 实现:记住账号的功能.
        int num = [[responseObject objectForKey:@"status"]intValue];
        if (num == 200) {
            NSLog(@"页面dismiss, 然后把手机号和密码传值到登录页面");
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            
        }else {
            NSLog(@"页面不能dismiss, 提示弹窗错误");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //如果本地数据中数据存在(NSUserDefaults)账号和密码就将值赋值给TextField, 如果没有就给赋值成@""空的字符串
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.phoneTextField.text = @"";
    self.markTextField.text = @"";
    self.passwordTextField.text = @"";
    NSLog(@"我是李四");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    NSLog(@"我是王五");
    
    
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
