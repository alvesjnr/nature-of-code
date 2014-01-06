
cdef extern from "nvector.h":

    ctypedef struct nvector:
        double x
        double y
        double z

    nvector* nvector_new(double x, double y, double z)
    nvector* nvector_copy(nvector *v)
    void nvector_del(nvector *v)
    void nvector_add(nvector *left, nvector *right)
    void nvector_sub(nvector *left,  nvector *right)
    void nvector_mul(nvector *left, double right)
    double nvector_dot(nvector *left,  nvector *right)
    void nvector_cross(nvector *left, const nvector *right)
    double nvector_mag(nvector *v)
    void nvector_normalize(nvector *v)
    void nvector_setmag(nvector *v, double mag)
    double nvector_angle_between(nvector *v1,  nvector *v2)
    double nvector_angle(nvector *v)


cdef class Vector:
    
    cdef nvector* _vector
    cdef nvector* _aux_vector

    def __cinit__(self, double x=0.0, double y=0.0, double z=0.0):
        self._vector = nvector_new(x,y,z)

    def __dealloc__(Vector self):
        nvector_del(self._vector)
        nvector_del(self._aux_vector)

    def __repr__(self):
        if self._vector.z == 0:
            return '<Vector({},{})>'.format(self._vector.x, self._vector.y)
        else:
            return '<Vector(x={}, y={}, z={})>'.format(self._vector.x, self._vector.y, self._vector.z)


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

            v = Vector(left._aux_vector.x, left._aux_vector.y, left._aux_vector.z)
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

    cdef cross(Vector self, Vector right):
        self._aux_vector = nvector_copy(self._vector)
        nvector_cross(self._aux_vector, right._vector)
        return Vector(self._aux_vector.x, self._aux_vector.y, self._aux_vector.z)

    cdef mag(Vector self):
        return nvector_mag(self._vector)

    def __abs__(self):
        return self.mag()

    def angle(Vector self):
        return nvector_angle(self._vector)

    def angle_between(Vector self, Vector other):
        return nvector_angle_between(self._vector,other._vector)

    def normalized(Vector self):
        """
            return a normalized (unitary length) copy of self
        """
        self._aux_vector = nvector_copy(self._vector)
        nvector_normalize(self._aux_vector)
        return Vector(self._aux_vector.x, self._aux_vector.y, self._aux_vector.z)

    def scaled(Vector self, double mag):
        """
            return a copy of self with length equals to mag
        """
        self._aux_vector = nvector_copy(self._vector)
        nvector_setmag(self._aux_vector, mag)
        return Vector(self._aux_vector.x, self._aux_vector.y, self._aux_vector.z)
