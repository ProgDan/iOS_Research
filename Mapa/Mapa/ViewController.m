//
//  ViewController.m
//  Mapa
//
//  Created by Daniel Arndt Alves on 2/23/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapa;
@property (strong, nonatomic) CLLocationManager *locManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)mostraLocalização:(UIButton *)sender {
    if([CLLocationManager locationServicesEnabled]){
        if([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)
        {
            if(!self.locManager){
                // Inicializa o serviço
                self.locManager = [CLLocationManager new];
                self.locManager.delegate = self;
            }
            [self.locManager startUpdatingLocation];
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"Ops" message:@"Você não autorizou o app, agora, se vire!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }
        
    }
}

- (IBAction)mostraIai:(UIButton *)sender {
    MKPointAnnotation *pino = [MKPointAnnotation new];
    
    // Seta a coordenada do pino
    pino.coordinate = CLLocationCoordinate2DMake(-23.5816554, -46.6838368);
    
    // seta um título
    pino.title = @"¿iAi?";
    
    // adiciona no mapa
    [self.mapa addAnnotation:pino];
    
    // defina a quantidade de mapa que ficará visível na horizontal e na vertical
    MKCoordinateSpan zoom = MKCoordinateSpanMake(0.01, 0.01);
    
    // define o local onde será aplicado o zoom
    MKCoordinateRegion regiao = MKCoordinateRegionMake(pino.coordinate, zoom);
    [self.mapa setRegion:regiao animated:YES];
}

- (IBAction)mudaMapa:(UIButton *)sender {
    
    // muda o tipo de visualização do mapa
    if (self.mapa.mapType == MKMapTypeStandard) {
        self.mapa.mapType = MKMapTypeSatellite;
    }
    else if (self.mapa.mapType == MKMapTypeSatellite){
        self.mapa.mapType = MKMapTypeHybrid;
    }
    else {
        self.mapa.mapType = MKMapTypeStandard;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    [self.locManager stopUpdatingLocation];
    
    CLLocation *localizacao = [locations lastObject];
    
    MKCoordinateSpan zoom = MKCoordinateSpanMake(0.005,0.005);
    
    MKCoordinateRegion regiao = MKCoordinateRegionMake(localizacao.coordinate, zoom);
    
    [self.mapa setRegion:regiao animated: YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
