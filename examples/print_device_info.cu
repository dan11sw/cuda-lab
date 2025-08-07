#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "./common/book.h"
#include <stdio.h>
#include <vector>
#include <iostream>

int main() {
	cudaDeviceProp prop;

	int count = 0;

	// Получаем кол-во устройств, которые поддерживают архитектуру CUDA
	HANDLE_ERROR(cudaGetDeviceCount(&count));

	for(int i = 0; i < count; i++) {
		// Получение информации об устройстве
		HANDLE_ERROR(cudaGetDeviceProperties(&prop, i));

		// Вывод информации об устройстве
		std::cout << "Name: " << prop.name << std::endl;
		std::cout << "TotalGlobalMem (Gb): " << prop.totalGlobalMem / (1024.0 * 1024 * 1024) << std::endl;
		std::cout << "SharedMemPerBlock: " << prop.sharedMemPerBlock << std::endl; 
		std::cout << "WarpSize: " << prop.warpSize << std::endl;
		std::cout << "MaxThreadsPerBlock: " << prop.maxThreadsPerBlock << std::endl << std::endl;
	}

	system("PAUSE");
    return 0;
}