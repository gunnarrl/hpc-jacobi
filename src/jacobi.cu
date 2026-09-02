#include <iostream>
#include <cuda_runtime.h>

// 1. The Kernel (runs on the GPU)
__global__ void incrementGPU(int* d_val) {
    *d_val = *d_val + 1;
}

int main() {
    int h_val = 41; // Host (CPU) variable
    int* d_val;     // Device (GPU) pointer

    // 2. Allocate memory on the GPU
    cudaMalloc((void**)&d_val, sizeof(int));

    // 3. Copy data from CPU to GPU
    cudaMemcpy(d_val, &h_val, sizeof(int), cudaMemcpyHostToDevice);

    // 4. Launch the kernel with 1 block and 1 thread
    incrementGPU<<<1, 1>>>(d_val);

    // 5. Copy the result back from GPU to CPU
    cudaMemcpy(&h_val, &d_val, sizeof(int), cudaMemcpyDeviceToHost);

    // 6. Print result and clean up GPU memory
    std::cout << "Result from GPU: " << h_val << std::endl; // Prints 42
    cudaFree(d_val);

    return 0;
}
