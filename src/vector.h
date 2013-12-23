#ifndef __VECTOR_H
#define __VECTOR_H

typedef struct _2d_vector{
    double x;
    double y;
} nvector;


extern nvector* nvector_zero();
extern nvector* nvector_new(double x, double y);
extern nvector* nvector_copy(const nvector *v);
extern nvector* nvector_del(nvector *v);

extern void nvector_add(nvector *left, const nvector *right);
extern void nvector_sub(nvector *left, const nvector *right);
extern void nvector_mul(nvector *left, double right);
extern double nvector_dot(const nvector *left, const nvector *right);

extern double nvector_mag(const nvector *v);
extern nvector* nvector_normalize(const nvector *v);
extern void nvector_setmag(nvector *v, double mag);
extern double nvector_angle_between(const nvector *v1, const nvector *v2);
extern double nvector_angle(const nvector *v);


#endif
