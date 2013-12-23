
#include "vector.h"

#include <math.h>
#include <stdio.h>
#include <assert.h>

//create integer value that contains 7 significant digits of input number
int adjust_num(double num) {
    double low_bound = 1e7;
    double high_bound = low_bound*10;
    double adjusted = num;
    int is_negative = (num < 0);
    if(num == 0) {
        return 0;
    }
    if(is_negative) {
        adjusted *= -1;
    }
    while(adjusted < low_bound) {
        adjusted *= 10;
    }
    while(adjusted >= high_bound) {
        adjusted /= 10;
    }
    if(is_negative) {
        adjusted *= -1;
    }
    //define int round(double) to be a function which rounds
    //correctly for your domain application.
    return round(adjusted);
}


int d_cmp(double a, double b){
	return adjust_num(a) == adjust_num(b);
}

int nvector_cmp(nvector *a, nvector *b){
	return d_cmp(a->x, b->x) && d_cmp(a->y, b->y);
}

int test_mag(){
	int i, j;
	for(i=0,j=0; i<100, j<100; i++,j++){
		nvector *v = nvector_new(i/10.0, j/10.0);
		assert( d_cmp(nvector_mag(v), sqrt(i*i/100.0 + j*j/100.0)) );
		nvector_del(v);
	}
}

int test_add(){

}

int main(){

	test_mag();
	test_add();

}