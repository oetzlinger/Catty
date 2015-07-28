/**
 *  Copyright (C) 2010-2015 The Catrobat Team
 *  (http://developer.catrobat.org/credits)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  An additional term exception under section 7 of the GNU Affero
 *  General Public License, version 3, is available at
 *  (http://developer.catrobat.org/license_additional_term)
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/.
 */

#import "ImagePicker.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@implementation ImagePicker

- (id) initWithDrawViewCanvas:(PaintViewController *)canvas
{
  self = [super init];
  if(self)
  {
    self.canvas = canvas;
  }
  return self;
}

- (void)cameraImagePickerAction
{
  AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
  UIAlertController *alertControllerCamera = [UIAlertController
                                              alertControllerWithTitle:nil
                                              message:kLocalizedNoAccesToCameraCheckSettingsDescription
                                              preferredStyle:UIAlertControllerStyleAlert];
    
  UIAlertAction *cancelAction = [UIAlertAction
                                 actionWithTitle:kLocalizedCancel
                                 style:UIAlertActionStyleCancel
                                 handler:nil];
    
  UIAlertAction *settingsAction = [UIAlertAction
                                   actionWithTitle:kLocalizedSettings
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                   }];
    
    
  [alertControllerCamera addAction:cancelAction];
  [alertControllerCamera addAction:settingsAction];

  //IMAGEPICKER CAMERA
  if(authStatus == AVAuthorizationStatusAuthorized)
  {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
  
    [self.canvas presentViewController:picker animated:YES completion:NULL];
  }
  else{
    [self.canvas presentViewController:alertControllerCamera animated:YES completion:nil];
  }
}

- (void)imagePickerAction
{
  ALAuthorizationStatus statusCameraRoll = [ALAssetsLibrary authorizationStatus];
  UIAlertController *alertControllerCameraRoll = [UIAlertController
                                              alertControllerWithTitle:nil
                                              message:kLocalizedNoAccesToImagesCheckSettingsDescription
                                              preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction *cancelAction = [UIAlertAction
                                 actionWithTitle:kLocalizedCancel
                                 style:UIAlertActionStyleCancel
                                 handler:nil];
  
  UIAlertAction *settingsAction = [UIAlertAction
                                   actionWithTitle:kLocalizedSettings
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                   }];
    
  [alertControllerCameraRoll addAction:cancelAction];
  [alertControllerCameraRoll addAction:settingsAction];

  //IMAGEPICKER CameraRoll
  if (statusCameraRoll == ALAuthorizationStatusAuthorized) {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  
    [self.canvas presentViewController:picker animated:YES completion:NULL];
  }else
  {
    [self.canvas presentViewController:alertControllerCameraRoll animated:YES completion:nil];
  }
}
#pragma mark imagePicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  
  self.originalImage = info[UIImagePickerControllerEditedImage];
  
  //TODO change size of image
  [self.canvas setImagePickerImage:self.originalImage];
  
  [picker dismissViewControllerAnimated:YES completion:NULL];
  
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  
  [picker dismissViewControllerAnimated:YES completion:NULL];
  
}


@end
