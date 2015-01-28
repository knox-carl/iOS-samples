//
//  RWViewController.h
//  ShowTracker
//
//  Created by Carl R. Knox on 01/28/15.
//  Copyright (c) 2015 Carl R. Knox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate>
@property (nonatomic, weak) IBOutlet UIScrollView *showsScrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *showsPageControl;
- (IBAction)pageChanged:(id)sender;
@end
