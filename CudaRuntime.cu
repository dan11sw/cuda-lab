
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>

// Ядро CUDA (выполняется на GPU)
__global__ void helloFromGPU() {
    printf("Hello World from GPU! (Thread %d)\n", threadIdx.x);
}

int main() {
    printf("Hello World from CPU!\n");

    // Запуск ядра на GPU (1 блок, 10 потоков)
    helloFromGPU << <1, 10 >> > ();

    // Синхронизация и проверка ошибок
    cudaDeviceSynchronize();
    if (cudaGetLastError() != cudaSuccess) {
        fprintf(stderr, "Kernel launch failed: %s\n", cudaGetErrorString(cudaGetLastError()));
        return 1;
    }

    system("PAUSE");

    return 0;
}