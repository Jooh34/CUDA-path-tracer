#ifndef CAMERA_H
#define CAMERA_H

#include "vector.cuh"
#include "ray.cuh"

class Camera {

public:
    Vec position;
    Vec target;
    Vec direction;

    int width;
    int height;
    double vp_dist;
    int FOV;
    double ratio;

    Vec x_direction;
    Vec y_direction;
    Vec look_up;

    double radius;
    
    __host__ __device__ Camera(Vec position, Vec target, int width, int height, float vp_dist, int FOV);
};

#endif
