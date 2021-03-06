#ifndef __NVECTOR_H
#define __NVECTOR_H

typedef struct _2d_vector{
    double x;
    double y;
    double z;
} nvector;


extern nvector* nvector_zero();
extern nvector* nvector_new(double x, double y, double z);
extern nvector* nvector_copy(const nvector *v);
extern void nvector_del(nvector *v);

extern void nvector_add(nvector *left, nvector *right);
extern void nvector_sub(nvector *left, const nvector *right);
extern void nvector_mul(nvector *left, double right);
extern double nvector_dot(const nvector *left, const nvector *right);
extern void nvector_cross(nvector *left, const nvector *right);

extern double nvector_mag(const nvector *v);
extern void nvector_normalize(nvector *v);
extern void nvector_setmag(nvector *v, double mag);
extern double nvector_angle_between(const nvector *v1, const nvector *v2);
extern double nvector_angle(const nvector *v);


#endif
