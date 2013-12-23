
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


cdef class Vector:
    
    cdef nvector* __vector

    def __cinit__(self, double x=0.0, double y=0.0):
        self.__vector = <nvector*> nvector_new(x,y)
    
    def __repr__(self):
        return '<Vector({},{})>'.format(self.__vector.x, self.__vector.y)

    def __add__(self, right):
        cdef nvector *v = <nvector*> nvector_copy(<nvector*>self.__vector)
        nvector_add( <nvector*> v, <nvector*>right._Vector__vector)
        return Vector(x=v.x, y=v.y)
