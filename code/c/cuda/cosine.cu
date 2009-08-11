/* Cuda GPU Based Program that use GPU processor for finding cosine of numbers */

/* --------------------------- header secton ----------------------------*/
#include<stdio.h>
#include<cuda.h>

#define COS_THREAD_CNT 200
#define N 10000

/* --------------------------- target code ------------------------------*/
struct cosParams {
  float *arg;
  float *res;
  int n;
};

__global__ void cos_main(struct cosParams parms) {
  int i;
  for (i = threadIdx.x; i < parms.n; i += COS_THREAD_CNT) {
    parms.res[i] = __cosf(parms.arg[i] );
  }
}

/* --------------------------- host code ------------------------------*/
int main (int argc, char *argv[])
{
  int i = 0;
  cudaError_t cudaStat;
  float* cosRes = 0;
  float* cosArg = 0;
  float* arg = (float *) malloc(N*sizeof(arg[0]));
  float* res = (float *) malloc(N*sizeof(res[0]));
  struct cosParams funcParams;

  /* ... fill arguments array "arg" .... */
  for(i=0; i < N; i++ ){
    arg[i] = (float)i;
  }

  cudaStat = cudaMalloc ((void **)&cosArg, N * sizeof(cosArg[0]));
  if( cudaStat )
    printf(" value = %d : Memory Allocation on GPU Device failed\n", cudaStat);

  cudaStat = cudaMalloc ((void **)&cosRes, N * sizeof(cosRes[0]));
  if( cudaStat )
    printf(" value = %d : Memory Allocation on GPU Device failed\n", cudaStat);

  cudaStat = cudaMemcpy (cosArg, arg, N * sizeof(arg[0]), cudaMemcpyHostToDevice);
  if( cudaStat )
    printf(" Memory Copy from Host to Device failed.\n", cudaStat);

  funcParams.res = cosRes;
  funcParams.arg = cosArg;
  funcParams.n = N;
  cos_main<<<1,COS_THREAD_CNT>>>(funcParams);

  cudaStat = cudaMemcpy (res, cosRes, N * sizeof(cosRes[0]), cudaMemcpyDeviceToHost);
  if( cudaStat )
    printf(" Memory Copy from Device to Host failed.\n" , cudaStat);

  for(i=0; i < N; i++ ){
    if ( i%10 == 0 )
      printf("\n cosf(%f) = %f ", arg[i], res[i] );
  }
}

/* nvcc cosine.cu -use_fast_math */
