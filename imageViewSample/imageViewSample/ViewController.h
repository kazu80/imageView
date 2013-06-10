//
//  ViewController.h
//  imageViewSample
//
//  Created by kazuyoshi kawakami on 13/06/10.
//  Copyright (c) 2013年 kazuyoshi kawakami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)openImageAction:(id)sender;

@end
