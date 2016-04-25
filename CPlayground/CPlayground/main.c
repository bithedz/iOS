//
//  main.c
//  CPlayground
//
//  Created by Wira on 4/7/16.
//  Copyright © 2016 Wira. All rights reserved.
//

#include <math.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <limits.h>
#include <stdbool.h>

int main(){
    
    long long int a[10],n,i,sum=0;
    
    scanf("%lld",&n);
    
    for(i=0;i<n;i++)
        scanf("%lld",&a[i]);
    
    for(i=0;i<n;i++)
        sum=sum+a[i];
    
    printf("%lld",sum);
    return 0;
}