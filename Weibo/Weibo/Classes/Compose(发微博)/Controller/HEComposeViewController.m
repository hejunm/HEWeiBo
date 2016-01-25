//
//  HEComposeViewController.m
//  Weibo
//
//  Created by 贺俊孟 on 15/9/17.
//  Copyright (c) 2015年 贺俊孟. All rights reserved.
//

#import "HEComposeViewController.h"
#import "HENavigationViewController.h"
#import "HETextView.h"
#import "HEAccountTool.h"
#import "HEAccount.h"
#import "HEComposeToolBar.h"
#import "EmotionKeyboard.h"
#import "HEEmotionTextView.h"
#import "HEEmotionTextAttachment.h"
#import "HEStatusTool.h"
#import "HMSendStatusParam.h"
#import "HMSendStatusResult.h"
#import "MBProgressHUD+MJ.h"
#import "HMComposePhotosView.h"
#import "HMSendImageStatusParam.h"
#import "HMSendImageStatusResult.h"
#import "HeFormDataModel.h"

@interface HEComposeViewController ()<UITextViewDelegate,HEComposeToolbarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/** 自定义输入 textView*/
@property (nonatomic,weak) HEEmotionTextView *textView;

/** 自定义工具条*/
@property (nonatomic,weak) HEComposeToolBar *composeToolBar;

/** 自定义表情键盘*/
@property (nonatomic,strong) EmotionKeyboard *emotionKeyboard;

/** 是否在切换键盘*/
@property (nonatomic,assign,getter=isChangeingKeyboard) BOOL changeingKeyboard;

/***/
@property (nonatomic, weak) HMComposePhotosView *photosView;

@end

@implementation HEComposeViewController


-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    /** 叫出键盘*/
    [self.textView becomeFirstResponder];
}

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    // 1,  设置导航栏信息
    [self setupNavInfo];
    
    // 2,  创建自定义的 textView
    [self setupTextView];
    
    //3,  设置HEComposeToolBar, 发微博的工具条
    [self setupComposeToolBar];
    
    // 4, 设置显示微博图片的HMComposePhotosView
    [self setupPhotosView];
    
    //5,  设置通知
    [self setNotification];
    
}

/** 设置导航栏信息 */
-(void) setupNavInfo{
    NSString *name = [HEAccountTool account].name;
    NSString *prefix = @"发微博";
    if (name) {
        NSString *text = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:text];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:
         [text rangeOfString:prefix]];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[text rangeOfString:name]];
        // 创建label
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.attributedText = str;
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.width = 100;
        titleLabel.height = 44;
        self.navigationItem.titleView = titleLabel;
    }else{
        self.title = prefix;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    
    //[self.navigationItem.rightBarButtonItem setEnabled:NO];
}

/** 创建自定义textView*/
-(void) setupTextView{
    HEEmotionTextView *textView = [[HEEmotionTextView alloc]initWithFrame:self.view.frame];
    
    textView.alwaysBounceVertical = YES;  // 在垂直方向上面一直有弹簧效果
    
    textView.frame = self.view.bounds;
    
    textView.delegate = self;
    
    [self.view addSubview:textView];
    
    self.textView = textView;
    self.textView.placehoder = @"分享新鲜事...";
    self.textView.font = [UIFont systemFontOfSize:15];
  
   
}

/** 设置HEComposeToolBar, 发微博的工具条*/
-(void) setupComposeToolBar{
    HEComposeToolBar *composeToolBar = [[HEComposeToolBar alloc]init];
    composeToolBar.height = 44;
    composeToolBar.width = self.view.width;
    composeToolBar.x = 0;
    composeToolBar.y = self.view.height-  composeToolBar.height ;
    
    composeToolBar.delegate = self;
    
    [self.view addSubview:composeToolBar];
    
    self.composeToolBar = composeToolBar;
}

/** 4, 设置显示微博图片的HMComposePhotosView*/
-(void) setupPhotosView{
    HMComposePhotosView *photosView = [[HMComposePhotosView alloc] init];
    photosView.width = self.textView.width;
    photosView.height = self.textView.height;
    photosView.y = 70;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

/**  设置通知*/
-(void) setNotification{
    // 监听表情键盘选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedEmotion:) name:HMEmotionDidSelectedNotification object:nil];
    
    // 监听表情键盘删除按钮点击时的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteEmotion) name:HMEmotionDidDeletedNotification object:nil];
    
    
    // 监听键盘的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //  监听键盘的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    // 监听输入文字的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextViewTextDidChangeNotification object:self.textView];
}


/** 移除通知*/
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




#pragma mark 懒加载

/**创建表情键盘 */
-(EmotionKeyboard *)emotionKeyboard{
    if (_emotionKeyboard == nil) {
        _emotionKeyboard = [EmotionKeyboard keyboard];
        _emotionKeyboard.width = HMScreenW;
        _emotionKeyboard.height =  HMEmotionKeyboardHeight;
    }
    return _emotionKeyboard;
}



#pragma mark HEComposeToolbarDelegate 
-(void)composeTool:(HEComposeToolBar *)toolbar didClickedButton:(HEComposeToolbarButtonType)buttonType{
    HELog(@"%s",__func__);
    HELog(@"点击工具栏中的按钮 %d",buttonType);
    
    switch (buttonType) {
        case HEComposeToolbarButtonTypeCamera: // 照相机
        {
            [self openCamera];
            break;
        }
        case HEComposeToolbarButtonTypePicture: // 相册
        {
            [self openPicture];
            break;
        }
        case HEComposeToolbarButtonTypeMention: // 提到@
        {
            [self openMention];
            break;
        }
        case HEComposeToolbarButtonTypeTrend: // 话题
        {
            [self openTrend];
            break;
        }
        case HEComposeToolbarButtonTypeEmotion: // 表情
        {
           [self openEmotion];
            break;
        }
        default:
            break;
    }
    
    
}


#pragma mark HEComposeToolBar   button点击事件处理

/**打开相机*/
-(void) openCamera{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/** 打开相册*/
-(void)openPicture{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];

}

/** 提到*/
-(void) openMention{
    
}

/** 话题*/
-(void) openTrend{
    
}

/**打开表情键盘*/
-(void) openEmotion{
    
    // 设置正在切换键盘标志位
    self.changeingKeyboard = YES;
    
    if (self.textView.inputView) { // 从自定义的表情键盘切换到系统键盘
        
        self.textView.inputView = nil;
        
        self.composeToolBar.showEmotionButton = YES;
        
    }else{   //从系统键盘切换到自定义的表情键盘
        
        self.textView.inputView = self.emotionKeyboard;
        
        self.composeToolBar.showEmotionButton = NO;
        
    }
    [self.textView resignFirstResponder];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder]; // 重新获得焦点
    });
}



#pragma mark UITextViewDelegate
//下拉时隐藏键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.textView resignFirstResponder];
}

#pragma mark - UIImagePickerControllerDelegate
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    // 1.取出选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addImage:image];
}

#pragma mark 键盘处理
-(void)keyboardWillShow:(NSNotification *)noti{
    //导航条随着键盘的出现向上移动
    HELog(@"%s",__func__);
    HELog(@"%@",noti);
    //键盘弹出动画持续事件
    CGFloat duration = [noti.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    //键盘最终位置坐标
    CGRect endBounds = [noti.userInfo[@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    CGFloat keyboardH = endBounds.size.height;
    // 工具条跟着键盘进行移动
    
    [UIView animateWithDuration:duration animations:^{
         self.composeToolBar.transform = CGAffineTransformMakeTranslation(0, -keyboardH);
    } completion:^(BOOL finished) {
        [self textChanged];
    }];
    
}

-(void)keyboardWillHide:(NSNotification *)noti{  //导航条随着键盘的消失向下移动
   
    HELog(@"%s",__func__);
    HELog(@"%@",noti);
    /**
     当点击切换键盘时， 设置标志位YES，使得工具栏不随着键盘下移。 标志位使用完后，初始化标志位
     
     当其他方式使键盘收起时， 标志位NO, 工具栏随着键盘向下移动
     */
    if (self.isChangeingKeyboard) {
        self.changeingKeyboard = NO;
    }else{
        //键盘弹出动画持续时间
        CGFloat duration = [noti.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
        // 工具条跟着键盘进行移动
        [UIView animateWithDuration:duration animations:^{
            self.composeToolBar.transform = CGAffineTransformIdentity;
            
            //将输入框恢复到原位置
            self.textView.transform = CGAffineTransformIdentity;
        }];
    }
}

#pragma mark 表情键盘点击时的通知

// 选中表情
-(void)selectedEmotion:(NSNotification *)noti{
    HELog(@"%s  %@",__func__, noti);
    [self.textView appendEmotion:noti.userInfo[HMSelectedEmotion]];
}

// 点击删除
-(void) deleteEmotion{
    // 往回删
    [self.textView deleteBackward];
    
}

/** self.textView 中的内容改变时触发*/
-(void) textChanged{
    
    //1， 求得现在文字的尺寸
    NSAttributedString *attributedStr = self.textView.attributedText;
    CGSize maxSize = CGSizeMake(self.textView.width-15, MAXFLOAT);
    CGSize textSize = [attributedStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    //2,  为了防止键盘挡住输入的文字将 textView 向上移动
    CGFloat offset =textSize.height- self.composeToolBar.y+80;
    
    //3， 使用动画， 使photosView对着输入文字的的增多而下移。
    [UIView animateWithDuration:0.25 animations:^{
        
        self.photosView.y = textSize.height +40;
        
        if (offset>0) {
            self.textView.transform = CGAffineTransformMakeTranslation(0, -offset);
        }
    }];
}


#pragma mark 发微博/取消发送 按钮事件相应
/**取消发微博*/
- (void)cancel{
    [self.textView resignFirstResponder]; //隐藏键盘
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**发送微博*/
- (void)send{
    [self.view endEditing:YES];
    if (self.photosView.images.count) { // 有图
        [self sendWithImage];
    }else{ // 无图
        [self sendWithoutImage];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}

/** 发送无图微博*/
-(void) sendWithoutImage{
    // 获取纯文本信息
    NSString *str = [self.textView realText];
    
    // 发微博
    HMSendStatusParam *sendStatusParam = [HMSendStatusParam param];
    sendStatusParam.status = str;
    
    [HEStatusTool sendStatusWithParam:sendStatusParam success:^(HMSendStatusResult *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
        
    }];
}

/** 发送有图微博*/
-(void) sendWithImage{
    
    //封装请求参数
    HMSendImageStatusParam *param = [HMSendImageStatusParam param];
    param.status = self.textView.realText;
    
    //封装发送的数据
    NSMutableArray *formDatas = [NSMutableArray array];
    for (UIImage *image in self.photosView.images) {
        HeFormDataModel *dataModel = [[HeFormDataModel alloc]init];
        dataModel.data = UIImageJPEGRepresentation(image, 1.0);
        dataModel.filename = @"status.jpg";
        dataModel.name = @"pic";
        dataModel.mimeType = @"image/jpeg";
        
        [formDatas addObject:dataModel];
    }
    
   [HEStatusTool sendImageStatusWithParam:param formDataArray:formDatas success:^(HMSendImageStatusResult *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"发送失败"];
    }];
}


@end
