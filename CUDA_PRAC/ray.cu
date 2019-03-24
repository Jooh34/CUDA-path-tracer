#include "vector.cuh"
#include "ray.cuh"

Ray::Ray(Vec origin, Vec direction) {
    this->origin = origin;
    this->direction = direction;
}
