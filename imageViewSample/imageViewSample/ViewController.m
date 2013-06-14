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
@synthesize imageView;
@synthesize dlData;


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
    imageView.image = image;
    
    
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

- (IBAction)downloadAction:(id)sender {
    NSString *urlPath = @"http://img5.blogs.yahoo.co.jp/ybi/1/e3/40/tktty914/folder/431534/img_431534_1667464_0?1174748196";
    
    // 文字列をNSURLに変換して、NSURLRequestを作成する
    NSURL *url = [NSURL URLWithString: urlPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // NSURLRequestを指定してNSURLConectionを作成
    NSURLConnection *connection;
    connection = [NSURLConnection connectionWithRequest:request delegate: self];
    
    if ( connection ) {
        self.dlData = [[NSMutableData alloc] initWithLength:0];
    }
}

// ダウンロードの最初に呼ばれる
- (void) connection: (NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response
{
    // ダウンロード中、必要ならばここでインジケーターを表示したり
    // ユーザーに操作を行わせないよう、ユーザーインタフェースを
    // 無効化したりする
    // ここでは、ステータスバーのインジケーターを表示している
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

// ダウロード中継続的に呼ばれる
- (void) connection: (NSURLConnection *) connection didReceiveData:(NSData *)data
{
    // ダウンロードされたデータをNSMutableDataに継ぎ足していく
    [self.dlData appendData:data];
}

// 何かしらのエラーでダウンロードが失敗した場合に呼ばれる
- (void) connection: (NSURLConnection *) connection didFailWithError:(NSError *)error
{
    // プロパティをクリアする
    self.dlData = nil;
    
    // インジケーターを停止する
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

// ダウンロード完了時に呼ばれる
- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
    // ダウンロードされたNSDataのオブジェクトからUIImageを作成する
    UIImage * image = [UIImage imageWithData:self.dlData];
    imageView.image = image;
    
    // プロパティをクリアする
    self.dlData = nil;
    
    // インジケーターを停止する
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
