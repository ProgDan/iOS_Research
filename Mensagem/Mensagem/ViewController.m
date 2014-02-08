//
//  ViewController.m
//  Mensagem
//
//  Created by Daniel Arndt Alves on 2/8/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    int contador;
}
@property (weak, nonatomic) IBOutlet UITextView *txtvMensagens;
@property (weak, nonatomic) IBOutlet UILabel *lblLetras;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    contador = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSMutableString *strMensagem = [[NSMutableString alloc]initWithString:self.txtvMensagens.text];
    [strMensagem appendFormat:@"\n%@",textField.text];
    self.txtvMensagens.text = strMensagem;
    
    if([textField.text isEqualToString:@"senha"]){
        NSLog(@"Palavra premiada");
    }

    textField.text = @"";
    self.lblLetras.text = @"0";
    
    [textField resignFirstResponder];

    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    // Efetua a alteração digitada pelo texto
    NSMutableString *texto = [[NSMutableString alloc]initWithString:textField.text];
    [texto replaceCharactersInRange:range withString:string];
    
    // calcula o tamanho do texto resultante
    contador = texto.length;
    
    self.lblLetras.text = [[NSString alloc]initWithFormat:@"%d",contador];
    
    return YES;
}

@end
