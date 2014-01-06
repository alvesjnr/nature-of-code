
#include "nvector.h"

#include <stdlib.h>
#include <math.h>


nvector* nvector_zero(){
    nvector *v;
    v = (nvector*)malloc(sizeof(nvector));
    v->x = v->y = v->z = 0;
    return v;
}

nvector* nvector_new(double x, double y, double z){
    nvector *v;
    v = (nvector*)malloc(sizeof(nvector));
    v->x = x;
    v->y = y;
    v->z = z;
    return v;
}

nvector* nvector_new2d(double x, double y){
    nvector *v;
    v = (nvector*)malloc(sizeof(nvector));
    v->x = x;
    v->y = y;
    v->z = 0;
    return v;
}

nvector* nvector_copy(const nvector *v){
    nvector *n_v = nvector_new(v->x, v->y, v->z);
    return n_v;
}

void nvector_del(nvector *v){
    free(v);
}

void nvector_add(nvector *left, nvector *right){
    left->x += right->x;
    left->y += right->y;
    left->z += right->z;
}

void nvector_sub(nvector *left, const nvector *right){
    left->x -= right->x;
    left->y -= right->y;
    left->z -= right->z;
}


double nvector_dot(const nvector *left, const nvector *right){
    return left->x * right->x + left->y * right->y + left->z * right->z;
}


void nvector_mul(nvector *left, double right){
    left->x *= right;
    left->y *= right;
    left->z *= right;
}


void nvector_cross(nvector *left, const nvector *right){
    int i, j, k;

    i = left->y*right->z - left->z*right->y;
    j = left->z*right->x - left->x*right->z;
    k = left->x*right->y - left->y*right->x;

    left->x = i;
    left->y = j;
    left->z = k;
}


double nvector_mag(const nvector *v){
    return sqrt(pow(v->x,2) + pow(v->y,2) + pow(v->z,2));
}


void nvector_normalize(nvector *v){
    double size = nvector_mag(v);

    v->x /= size;
    v->y /= size;
    v->z /= size;
}


void nvector_setmag(nvector *v, double mag){
    nvector_normalize(v);
    v->x *= mag;
    v->y *= mag;
    v->z *= mag;
}

double nvector_angle_between(const nvector *v1, const nvector *v2){
    return acos(nvector_dot(v1, v2) / (nvector_mag(v1) * nvector_mag(v2)));
}

double nvector_angle(const nvector *v){
    return acos( v->x / nvector_mag(v) );
}

