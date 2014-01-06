
cdef extern from "nvector.h":

    ctypedef struct nvector:
        double x
        double y

    nvector* nvector_new(double x, double y)
    nvector* nvector_copy(nvector *v)
    void nvector_del(nvector *v)
    void nvector_add(nvector *left, nvector *right)#
    void nvector_sub(nvector *left,  nvector *right)#
    void nvector_mul(nvector *left, double right)#
    double nvector_dot( nvector *left,  nvector *right)#
    double nvector_mag( nvector *v)#
    nvector* nvector_normalize( nvector *v)
    void nvector_setmag(nvector *v, double mag)
    double nvector_angle_between( nvector *v1,  nvector *v2)#
    double nvector_angle( nvector *v)#


cdef class Vector:
    
    cdef nvector* _vector
    cdef nvector* _aux_vector

    def __cinit__(self, double x=0.0, double y=0.0):
        self._vector = nvector_new(x,y)

    def __dealloc__(Vector self):
        nvector_del(self._vector)
        nvector_del(self._aux_vector)

    def __repr__(self):
        return '<Vector({},{})>'.format(self._vector.x, self._vector.y)

    def __add__(Vector left, Vector right):

        if isinstance(right, Vector) and isinstance(left, Vector):
            left._aux_vector = nvector_copy(left._vector)
            nvector_add( left._aux_vector, right._vector)

            v = Vector(left._aux_vector.x, left._aux_vector.y)
            return v
        else:
            return NotImplemented

    def __sub__(Vector left, Vector right):

        #__sub__ is left - right

        if isinstance(right, Vector) and isinstance(left, Vector):
            left._aux_vector = nvector_copy(left._vector)
            nvector_sub( left._aux_vector, right._vector)

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
        self._aux_vector = nvector_copy(self._vector)
        nvector_mul(self._aux_vector, m)
        return Vector(self._aux_vector.x, self._aux_vector.y)

    def dot(Vector self, Vector right):
        return nvector_dot(self._vector, right._vector)

    cdef cross(Vector left, Vector right):
        return NotImplemented

    cdef mag(Vector self):
        return nvector_mag(self._vector)

    def __abs__(self):
        return self.mag()

    def angle(Vector self):
        return nvector_angle(self._vector)

    def angle_between(Vector self, Vector other):
        return nvector_angle_between(self._vector,other._vector)

