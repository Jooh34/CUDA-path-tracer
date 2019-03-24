#ifndef RAY_H
#define RAY_H

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include "vector.cuh"

class Ray {
public:
    Vec origin;
    Vec direction;
	Ray(Vec origin, Vec direction);
};

#endif
