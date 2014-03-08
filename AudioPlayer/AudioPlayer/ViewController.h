//
//  ViewController.h
//  AudioPlayer
//
//  Created by Daniel Arndt Alves on 3/8/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

// @import substitui o link no sumário do projeto e o #import arquivo no .h
// A partir do Xcode 5.0
// @import AVFoundation;

@interface ViewController : UIViewController

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) AVAudioRecorder *gravador;

@end
