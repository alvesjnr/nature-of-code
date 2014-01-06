
cdef extern from "nvector.h":

    ctypedef struct nvector:
        double x
        double y

    extern nvector* nvector_zero()
    nvector* nvector_new(double x, double y)
    nvector* nvector_copy(nvector *v)
    extern nvector* nvector_del(nvector *v)
    void nvector_add(nvector *left, nvector *right)#
    extern void nvector_sub(nvector *left,  nvector *right)#
    extern void nvector_mul(nvector *left, double right)#
    extern double nvector_dot( nvector *left,  nvector *right)#
    extern double nvector_mag( nvector *v)#
    extern nvector* nvector_normalize( nvector *v)
    extern void nvector_setmag(nvector *v, double mag)
    extern double nvector_angle_between( nvector *v1,  nvector *v2)#
    extern double nvector_angle( nvector *v)#


cdef class Vector:
    
    cdef nvector* _vector
    cdef nvector* _aux_vector

    def __cinit__(self, double x=0.0, double y=0.0):
        self._vector = <nvector*> nvector_new(x,y)
    
    def __repr__(self):
        return '<Vector({},{})>'.format(self._vector.x, self._vector.y)

    def __add__(Vector left, Vector right):

        if isinstance(right, Vector) and isinstance(left, Vector):
            left._aux_vector = <nvector*> nvector_copy(<nvector*>left._vector)
            nvector_add( <nvector*> left._aux_vector, <nvector*>right._vector)

            v = Vector(left._aux_vector.x, left._aux_vector.y)
            return v
        else:
            return NotImplemented

    def __sub__(Vector left, Vector right):

        #__sub__ is left - right

        if isinstance(right, Vector) and isinstance(left, Vector):
            left._aux_vector = <nvector*> nvector_copy(<nvector*>left._vector)
            nvector_sub( <nvector*> left._aux_vector, <nvector*>right._vector)

            v = Vector(left._aux_vector.x, left._aux_vector.y)
            return v
        else:
            return NotImplemented

    def __mul__(left, right):

        if isinstance(left, (int, float)) ^ isinstance(right, (int, float)):
            #lets put int/float at right side
            if isinstance(left, (int,float)):
                right, left = left, right
            return (<Vector>left).mul(right)
        
        elif isinstance(right, Vector) and isinstance(left, Vector):
            return (<Vector>left).cross(right)

        else:
            return NotImplemented

    cdef mul(Vector self, float m):
        self._aux_vector = <nvector*> nvector_copy(<nvector*>self._vector)
        nvector_mul(<nvector*>self._aux_vector, m)
        return Vector(self._aux_vector.x, self._aux_vector.y)

    def dot(Vector self, Vector right):
        return nvector_dot(<nvector*>self._vector, <nvector*>right._vector)

    cdef cross(Vector left, Vector right):
        return NotImplemented

    cdef mag(Vector self):
        return nvector_mag(<nvector*> self._vector)

    def __abs__(self):
        return self.mag()

    def angle(Vector self):
        return nvector_angle(<nvector*> self._vector)

    def angle_between(Vector self, Vector other):
        return nvector_angle_between(<nvector*> self._vector, <nvector*> other._vector)

