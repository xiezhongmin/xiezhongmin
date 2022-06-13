//
//  ViewController.m
//  DKKitDemo
//
//  Created by admin on 2022/3/10.
//
//#define DK_NSLOG_LEVEL (-1)

#import "ViewController.h"
#import <DKKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DKLog(@"DKLog DKLog DKLog DKLog");
    DKLogError(@"DKLogError DKLogError DKLogError");
    DKLogWarn(@"DKLogWarn DKLogWarn DKLogWarn");
    DKLogInfo(@"DKLogInfo DKLogInfo DKLogInfo");
    DKLogDebug(@"DKLogDebug DKLogDebug DKLogDebug");
    DKLogVerbose(@"DKLogVerbose DKLogVerbose DKLogVerbose");
    DKLogFileLine(@"DKLogFileLine DKLogFileLine DKLogFileLine");
}

@end



