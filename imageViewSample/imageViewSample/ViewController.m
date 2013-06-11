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

    // イメージピッカーを作成する
    UIImagePickerController *imagePicker;
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    // カメラが使用可能かのチェック
    if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing = YES; // 撮影後編集可能にする
    }
    else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    // イメージピッカーをモーダルビューとして表示する
    [self presentViewController:imagePicker animated:YES completion:^{
       
        //表示後の処理
        
    }];
    
    
}

// 写真の使用決定時に呼ばれる
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if ( image) {
        self.imageView.image = image;
    }
    
    // モーダルビューを閉じる
    [self dismissViewControllerAnimated:YES completion:^{
        // 閉じた時の処理を記述
        NSLog(@"didFinishPickingMediaWithInfo");
    }];
}

// 写真の使用キャンセル時に呼ばれる
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // モーダルビューを閉じる
    [self dismissViewControllerAnimated:YES completion:^{
        // 閉じた時の処理を書く
        NSLog(@"didCancel");
    }];
}


















@end
