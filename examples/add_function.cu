#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "./common/book.h"
#include <stdio.h>

__global__ void add(int a, int b, int* c) {
	*c = a + b;
}

int main(void) {
	int c;
	int* dev_c;

	// Выделяем память на устройстве GPU с помощью метода cudaMalloc
	HANDLE_ERROR(cudaMalloc((void**)&dev_c, sizeof(int)));

	// Вызываем функцию add на устройстве GPU, передавая ей в качестве аргумента выделенную память под GPU устройство
	add<<<1, 1>>>(2, 7, dev_c);

	// Осуществляем перенос данных из указателя размещённом в памяти GPU в указатель размещённый в CPU
	HANDLE_ERROR(cudaMemcpy(&c, dev_c, sizeof(int), cudaMemcpyKind::cudaMemcpyDeviceToHost));

	printf("2 + 7 = %d\n", c);

	// Освобождение занимаемой памяти в GPU
	cudaFree(dev_c);
	system("pause");
	return 0;
}