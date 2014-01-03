
cdef extern from "nvector.h":
    
    # cdef struct nvector:
    ctypedef struct nvector:
        double x
        double y

    # extern nvector* nvector_zero()
    nvector* nvector_new(double x, double y)
    nvector* nvector_copy(nvector *v)
    # extern nvector* nvector_del(nvector *v)
    void nvector_add(nvector *left, nvector *right)
    # extern void nvector_sub(nvector *left,  nvector *right)
    # extern void nvector_mul(nvector *left, double right)
    # extern double nvector_dot( nvector *left,  nvector *right)
    # extern double nvector_mag( nvector *v)
    # extern nvector* nvector_normalize( nvector *v)
    # extern void nvector_setmag(nvector *v, double mag)
    # extern double nvector_angle_between( nvector *v1,  nvector *v2)
    # extern double nvector_angle( nvector *v)


cdef class Vector(object):
    
    cdef nvector* _vector
    cdef nvector* _aux_vector

    def __cinit__(self, double x=0.0, double y=0.0):
        self._vector = <nvector*> nvector_new(x,y)
    
    def __repr__(self):
        return '<Vector({},{})>'.format(self._vector.x, self._vector.y)

    def __add__(Vector left, Vector right):
        if isinstance(right, Vector) and isinstance(left, Vector):
            # _aux_vector = nvector
            left._aux_vector = <nvector*> nvector_copy(<nvector*>left._vector)
            nvector_add( <nvector*> left._aux_vector, <nvector*>right._vector)

            v = Vector(left._aux_vector.x, left._aux_vector.y)
            return v
        else:
            return NotImplemented

    def print_xy(self):
        print self._vector.x, self._vector.y
