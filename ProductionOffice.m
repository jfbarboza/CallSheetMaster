//
//  ProductionOffice.m
//  CallSheetMaster
//
//  Created by Jorge Barboza on 3/18/15.
//  Copyright (c) 2015 Jorge Barboza. All rights reserved.
//

#import "ProductionOffice.h"

@implementation ProductionOffice

- (void)viewDidLoad {
    self.title = [NSString stringWithFormat:@"Production Office: %@", self.thisProduction.prodTitle];
    [super viewDidLoad];
}
@end
