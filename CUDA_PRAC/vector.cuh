#ifndef VECTOR_H
#define VECTOR_H

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <algorithm>
#include <math.h>
#include <stdint.h>

class Vec {
public:
    double x, y, z;
    __host__ __device__ Vec(double x=0, double y=0, double z=0);
	__host__ __device__ Vec operator+(const Vec &b);
	__host__ __device__ Vec operator-(const Vec &b);
	__host__ __device__ Vec operator*(double b);
	__host__ __device__ Vec cross(const Vec&b);
	__host__ __device__ double dot(const Vec &b);
	__host__ __device__ Vec& norm();
};

#endif // VECTOR_H
