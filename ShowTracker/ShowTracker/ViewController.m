//
//  RWViewController.m
//  ShowTracker
//
//  Created by Carl R. Knox on 01/28/15.
//  Copyright (c) 2015 Carl R. Knox. All rights reserved.
//

#import "ViewController.h"
#import "TraktAPIClient.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TraktAPIClient *client = [TraktAPIClient sharedClient];
    
    [client getShowsForDate:[NSDate date]
                   username:@"galignok"
               numberOfDays:3
                    success:^(NSURLSessionDataTask *task, id responseObject) {
                        NSLog(@"Success -- %@", responseObject);
                    }
                    failure:^(NSURLSessionDataTask *task, NSError *error) {
                        NSLog(@"Failure -- %@", error);
                    }];
}

#pragma mark - Actions

- (IBAction)pageChanged:(id)sender
{
    
}

@end
