//
//  ViewController.m
//  LoginAndRegistDemo
//
//  Created by lanouhn on 15/11/24.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPRequestOperationManager.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextFied;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.accountTextFied.text = @"";
    self.passwordTextField.text = @"";
}
//登录方法
- (IBAction)loginAction:(id)sender {
    NSString *urlStr = @"http://washtest.cheguchina.com/api/user/signIn";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *dic = @{@"phone":self.accountTextFied.text, @"password":self.passwordTextField.text};
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求成功数据:%@", responseObject);
        NSDictionary *temDic = responseObject;
        NSLog(@"%@", [temDic objectForKey:@"message"]);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error :%@", error);
    }];
    
}
//注册方法
- (IBAction)registAction:(id)sender {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
