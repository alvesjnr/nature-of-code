
#include "vector.h"

#include <stdlib.h>
#include <math.h>


nvector* nvector_zero(){
    nvector *v;
    v = (nvector*)malloc(sizeof(nvector));
    v->x = v->y = 0;
    return v;
}

nvector* nvector_new(double x, double y){
    nvector *v;
    v = (nvector*)malloc(sizeof(nvector));
    v->x = x;
    v->y = y;
    return v;
}

nvector* nvector_copy(const nvector *v){
    nvector *n_v = nvector_new(v->x, v->y);
    return n_v;
}

nvector* nvector_del(nvector *v){
    free(v);
}

void nvector_add(nvector *left, const nvector *right){
    left->x += right->x;
    left->y += right->y;
}

void nvector_sub(nvector *left, const nvector *right){
    left->x -= right->x;
    left->y -= right->y;
}

double nvector_dot(const nvector *left, const nvector *right){
    return left->x * right->x + left->y * right->y;
}


void nvector_mul(nvector *left, double right){
    left->x *= right;
    left->y *= right;
}


double nvector_mag(const nvector *v){
    return sqrt(pow(v->x,2) + pow(v->y,2));
}

nvector* nvector_normalize(const nvector *v){
    nvector *n_v = nvector_zero();
    double size = nvector_mag(v);

    n_v->x /= size;
    n_v->y /= size;

    return n_v;
}

void nvector_setmag(nvector *v, double mag){
    v->x *= mag;
    v->y *= mag;
}

double nvector_angle_between(const nvector *v1, const nvector *v2){
    return acos(nvector_dot(v1, v2) / (nvector_mag(v1) * nvector_mag(v2)));
}

double nvector_angle(const nvector *v){
    return acos( v->x / nvector_mag(v) );
}

