//
//  ViewController.m
//  codepath-canvas
//
//  Created by Jim Challenger on 11/12/15.
//  Copyright © 2015 Jim Challenger. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *trayView;
@property (nonatomic, assign) CGPoint trayOriginalCenter;
@property (nonatomic, assign) CGPoint trayCenterWhenOpen;
@property (nonatomic, assign) CGPoint trayCenterWhenClosed;

- (IBAction)onTrayPanGesture:(UIPanGestureRecognizer *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.trayCenterWhenOpen = self.trayView.center;
    self.trayCenterWhenClosed = CGPointMake(self.trayView.center.x, self.trayView.center.y + CGRectGetHeight(self.trayView.frame) - 50);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTrayPanGesture:(UIPanGestureRecognizer *)sender {
    // Absolute (x,y) coordinates in parentView
    CGPoint translation = [sender translationInView:self.trayView];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.trayOriginalCenter = self.trayView.center;
        NSLog(@"Gesture began at: %@", NSStringFromCGPoint(translation));
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        NSLog(@"Gesture changed at: %@", NSStringFromCGPoint(translation));
        self.trayView.center = CGPointMake(self.trayOriginalCenter.x,
                                           self.trayOriginalCenter.y + translation.y);
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"Gesture ended at: %@", NSStringFromCGPoint(translation));
        CGPoint velocity = [sender velocityInView:self.trayView];
        if (velocity.y > 0) {
            [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
                self.trayView.center = self.trayCenterWhenClosed;
            } completion:^(BOOL finished) {
            }];
            
        } else {
            [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
                self.trayView.center = self.trayCenterWhenOpen;
            } completion:^(BOOL finished) {
            }];
        }
    }
}
@end
