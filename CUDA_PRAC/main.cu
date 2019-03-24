#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include "ray.cuh"
#include "vector.cuh"
#include "camera.cuh"

#include <vector>
#include <stdio.h>
#include <iostream>

#include <stdio.h>
#include <ctime>
#include <curand_kernel.h>

#define M_PI 3.141592

#include <iostream>

using namespace std;

__global__ void initializeRays(Camera* cam, Ray* rays) {// initialize rays on the host
	int x = (blockIdx.x * blockDim.x) + threadIdx.x;
	int y = (blockIdx.y * blockDim.y) + threadIdx.y;
	int index = x + (y * cam->width);

	curandState state;
	curand_init((unsigned long long)clock() + index, 0, 0, &state);
	curand_uniform_double(&state);

	Vec center = cam->position + cam->direction * cam->vp_dist;
	double vp_width = 2 * cam->vp_dist * tan((cam->FOV / 2) * M_PI / 180.0);
	double vp_height = 1. / cam->ratio * vp_width;

	double px_width = vp_width / cam->width;
	double px_height = vp_height / cam->height;

	Vec start_pixel = center - cam->x_direction * (vp_width / 2) + cam->y_direction * (vp_height / 2);
	Vec target_pixel = start_pixel + cam->x_direction * px_width * (x + 0.5) - cam->y_direction * px_height * (y + 0.5);

	// jitter for anti-aliasing
	double jitter_x = curand_uniform_double(&state)-0.5;
	double jitter_y = curand_uniform_double(&state)-0.5;

	Vec jittered_target = target_pixel + cam->x_direction * jitter_x * px_width + cam->y_direction * jitter_y * px_height;
	//

	double e1 = curand_uniform_double(&state)-0.5;
	double e2 = curand_uniform_double(&state)-0.5;
	double e3 = curand_uniform_double(&state)-0.5;
	double d = cam->radius * curand_uniform_double(&state);

	Vec rand_vec = Vec(e1, e2, e3);

	Vec orth = (cam->direction.cross(rand_vec)).norm();
	Vec jittered_position = cam->position + orth * d;
	//
	rays[index].origin = jittered_position;
	rays[index].direction = (jittered_target - jittered_position).norm();
}

int main() {
    int N = 500;

	Vec origin(0, 500, 1400);
    Vec dest(0, 500, 0);
	Camera* camera = new Camera(origin, dest, 500, 500, 1400, 60);
	Camera* cuda_camera;

	cudaMalloc(&cuda_camera, sizeof(Camera));
	cudaMemcpy(cuda_camera, camera, sizeof(Camera), cudaMemcpyHostToDevice);

    Ray *rays;
	Vec *colors;

	cudaMallocManaged(&rays, N * sizeof(Ray));
	cudaMallocManaged(&colors, N * sizeof(Vec));

    initializeRays <<<N, 1>>> (cuda_camera, rays);

	cudaDeviceSynchronize();

	for (int i = 0; i < 500; i++) {
		cout << rays[i].direction.x << ", " << rays[i].direction.y << ", " << rays[i].direction.z << endl;
	}
}
