#include "vector.cuh"

Vec::Vec(double x, double y, double z) {
    this->x = x;
    this->y = y;
    this->z = z;
}

Vec Vec::operator+(const Vec &b) {
     return Vec(x+b.x,y+b.y,z+b.z);
}

Vec Vec::operator-(const Vec &b) {
     return Vec(x-b.x,y-b.y,z-b.z);
}

Vec Vec::operator*(double b) {
    return Vec(x*b,y*b,z*b);
}

Vec Vec::cross(const Vec &b) {
    return Vec(y*b.z-z*b.y,z*b.x-x*b.z,x*b.y-y*b.x);
}

double Vec::dot(const Vec &b) {
    return x*b.x+y*b.y+z*b.z;
}

Vec& Vec::norm() {
    return *this = *this * (1/sqrt(x*x+y*y+z*z));
}
