//
//  ViewController.m
//  TarefaBackground
//
//  Created by Daniel Arndt Alves on 4/6/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)iniciarProcessoClicado:(UIButton *)sender;

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

- (IBAction)iniciarProcessoClicado:(UIButton *)sender {
    // Iniciar uma tarefa em segundo plano
    // Solicitar uma autorização para o iOS para rodar por um tempo (+- 10 min)
    
    // Handler - executado quando o tempo da tarefa acabar
    UIBackgroundTaskIdentifier taskID =  [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        // o que quero que aconteça quando o tempo acabar
        
        
        // Encerrar a tarefa
        // Não podemos esquecer de fazer esse passo, senão o app corre o risco de ser encerrado pelo iOS.
        [[UIApplication sharedApplication] endBackgroundTask:taskID];
    }];
    
    // Tarefa em segundo plano
    
    // Disparar uma nova fila em outra thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        // Agora o processo acontece fora da main thread
        
        // Atividade demorada
        for (int i=0; i<100000; i++) {
            NSLog(@"Contando %d", i);
        }
        
        // Se precisar atualizar um componente visual, voltamos para a mainthread
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:nil message:@"Acabou contagem" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil] show];
        });
        
        // Encerrar a tarefa
        [[UIApplication sharedApplication] endBackgroundTask:taskID];
        
        // Fim da tarefa
        
    });
    
    
    
}

@end
