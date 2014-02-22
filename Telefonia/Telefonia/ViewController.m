//
//  ViewController.m
//  Telefonia
//
//  Created by Daniel Arndt Alves on 2/22/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong)CTCallCenter *centralChamadas;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // Informações de Operadora
    
    CTTelephonyNetworkInfo *infoRede = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *operadora = infoRede.subscriberCellularProvider;
    
    NSString *nomeOperadora = operadora.carrierName;
    NSString *codISOPais = operadora.isoCountryCode;
    NSString *mobileCountryCode = operadora.mobileCountryCode;
    NSString *mobileNetworkCode = operadora.mobileNetworkCode;
    
    NSString *voip;
    
    if (operadora.allowsVOIP) {
        voip = @"Permite voip";
    }
    else {
        voip = @"Não permite voip";
    }
    
    NSLog(@"Nome:%@ ISO:%@ Country code:%@ network code:%@ VOIP: %@", nomeOperadora, codISOPais, mobileCountryCode, mobileNetworkCode, voip);
    
    // Informações de Chamada
    
    self.centralChamadas = [CTCallCenter new];
    
    [self.centralChamadas setCallEventHandler:^(CTCall *chamada) {
        if ([chamada.callState isEqualToString:CTCallStateIncoming]) {
            NSLog(@"Recebendo Ligação");
        }
        else if ([chamada.callState isEqualToString:CTCallStateConnected]){
            NSLog(@"Atendeu Chamada");
        }
        else if([chamada.callState isEqualToString:CTCallStateDisconnected]){
            NSLog(@"Desligou ligação");
        }
        else if ([chamada.callState isEqualToString:CTCallStateDialing]){
            NSLog(@"Discando");
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
