#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "./common/book.h"
#include <stdio.h>
#include <vector>
#include <iostream>

// Ядро CUDA для вывода элементов массива
__global__ void print_vector(int* arr, int size) {
    int idx = threadIdx.x + blockIdx.x * blockDim.x;
	
    if (idx < size) {
        printf("GPU: arr[%d] = %d\n", idx, arr[idx]); // Вывод из GPU
    }
}

int main() {
    const int N = 10;
	// CPU array
    std::vector<int> host_array(N, 0);

	// GPU array
    int *dev_array;

    // Инициализируем массив CPU
    for (int i = 0; i < N; i++) {
        host_array[i] += i;
    }

	// Выделение памяти на GPU
    HANDLE_ERROR(cudaMalloc((void**)&dev_array, N * sizeof(int)));

    // Копируем данные из CPU массива в GPU массив
    HANDLE_ERROR(cudaMemcpy(dev_array, host_array.data(), N * sizeof(int), cudaMemcpyKind::cudaMemcpyHostToDevice));

    // Запускаем ядро для вывода массива на GPU
    int blockSize = 256;
    int gridSize = (N + blockSize - 1) / blockSize;

    print_vector<<<gridSize, blockSize>>>(dev_array, N);

    // Ожидаем завершения работы ядра
    cudaDeviceSynchronize();

    // Освобождаем занятую память
    cudaFree(dev_array);

	system("PAUSE");
    return 0;
}