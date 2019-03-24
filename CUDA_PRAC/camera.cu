#include "vector.cuh"
#include "camera.cuh"
#include "ray.cuh"
#include <iostream>

using namespace std;

Camera::Camera(Vec position, Vec target, int width, int height, float vp_dist, int FOV) {
    this->position = position;
    this->target = target;
    this->width = width;
    this->height = height;
    this->vp_dist = vp_dist;
    this->FOV = FOV;

    ratio = (double)width/(double)height;
    direction = (target - position).norm();

    look_up = Vec(0, 1, 0);
    radius = 0;

    x_direction = direction.cross(look_up).norm();
    y_direction = x_direction.cross(direction).norm();
}
