//
//  ViewController.m
//  imageViewSample
//
//  Created by kazuyoshi kawakami on 13/06/10.
//  Copyright (c) 2013年 kazuyoshi kawakami. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openImageAction:(id)sender {
    
    // ハンドルから画像ファイルを読み込んでUIImageのオブジェクトを作成
    UIImage *image = [UIImage imageNamed:@"haruna_png"];
    
    // UIImageViewのimageプロパティに設定
    self.imageView.image = image;
    
    
    // 画像を保存する
    NSArray *pathTable;
    
    // Documentディレクトリのパスを取得
    pathTable = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docPath = [pathTable objectAtIndex:0];
    NSString *path = [docPath stringByAppendingPathComponent:@"harunachan.png"];
    
    NSData *data = UIImagePNGRepresentation(image);
    [data writeToFile:path atomically:YES];
    
}

- (IBAction)openImageAction2:(id)sender {
    NSArray *pathTable;
    
    // Documentディレクトリのパスを取得
    pathTable = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docPath = [pathTable objectAtIndex:0];
    NSString *path = [docPath stringByAppendingPathComponent:@"haruna.jpg"];
    
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    self.imageView.image = image;
    
}
@end
