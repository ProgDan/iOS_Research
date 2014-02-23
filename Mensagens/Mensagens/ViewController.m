//
//  ViewController.m
//  Mensagens
//
//  Created by Daniel Arndt Alves on 2/23/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>

@interface ViewController () <UINavigationControllerDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)enviaEmail:(UIButton *)sender {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *email = [MFMailComposeViewController new];
        
        email.mailComposeDelegate = self;
        
        [email setSubject:@"Assunto do meu email"];
        
        // destinatário - roberto.ferrazn@gmail.com; roberto@cac.to, roberto.ferrazn@facebook.com
        [email setToRecipients:[NSArray arrayWithObjects:@"progdan@me.com", nil]];
        
        [email setMessageBody:@"<b>Segue</b> a minha nave anexa" isHTML:YES];
        
        NSData *anexo = UIImagePNGRepresentation([UIImage imageNamed:@"nave"]);
        
        [email addAttachmentData:anexo mimeType:@"image/png" fileName:@"minha_nave.png"];
        
        [self presentViewController:email animated:YES completion:nil];
    }
}

- (IBAction)enviaMensagem:(UIButton *)sender {
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *sms = [MFMessageComposeViewController new];
        
        sms.messageComposeDelegate = self;
        
        // 7191789898
        [sms setRecipients:[NSArray arrayWithObjects:@"+5511999384524", nil]];
        
        [sms setBody:@"Mensagem"];
        
        [self presentViewController:sms animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MFMailComposeResultSent) {
        [[[UIAlertView alloc] initWithTitle:@"Good" message:@"Email enviado com sucesso" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    else if (result == MFMailComposeResultSaved){
        [[[UIAlertView alloc] initWithTitle:@"Good" message:@"Email salvo com sucesso" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MFMailComposeResultSent) {
        [[[UIAlertView alloc] initWithTitle:@"Good" message:@"Mensagem enviada com sucesso" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    else if (result == MFMailComposeResultSaved){
        [[[UIAlertView alloc] initWithTitle:@"Good" message:@"Mensagem salva com sucesso" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
