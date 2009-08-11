#include <iostream>
#include <iomanip>
#include <string>
#include <stdlib.h>
#include <time.h>
using namespace std;
#include "target.h"
#include "cpucycles.h"


class uint32 {
  unsigned int x;
public:
  unsigned int uint() { return x; }
  inline uint32() { }
  inline uint32(unsigned int u) { x = u; }
  inline uint32(const uint32 &a) { x = a.x; }
  friend inline uint32 operator+(uint32 a,uint32 b) { return a.x + b.x; }
  friend inline uint32 operator|(uint32 a,uint32 b) { return a.x | b.x; }
  friend inline uint32 operator&(uint32 a,uint32 b) { return a.x & b.x; }
  friend inline uint32 operator^(uint32 a,uint32 b) { return a.x ^ b.x; }
  friend inline uint32 andnot(uint32 a,uint32 b) { return a.x & ~b.x; }
  friend inline uint32 rotate1(uint32 a) { return (a.x << 1) | (a.x >> 31); }
  friend inline uint32 rotate5(uint32 a) { return (a.x << 5) | (a.x >> 27); }
  friend inline uint32 rotate30(uint32 a) { return (a.x << 30) | (a.x >> 2); }
  friend ostream& operator<<(ostream& o,const uint32& u) {
    o << hex << setw(2) << setfill('0') << ((u.x >> 24) & 255);
    o << hex << setw(2) << setfill('0') << ((u.x >> 16) & 255);
    o << hex << setw(2) << setfill('0') << ((u.x >> 8) & 255);
    o << hex << setw(2) << setfill('0') << ((u.x) & 255);
    return o;
  }
} ;

class hash {
  uint32 state[5];
public:
  hash() { }
  hash(const hash &x) {
    state[0] = x.state[0];
    state[1] = x.state[1];
    state[2] = x.state[2];
    state[3] = x.state[3];
    state[4] = x.state[4];
  }
  hash(const unsigned int x[5]) {
    state[0] = x[0];
    state[1] = x[1];
    state[2] = x[2];
    state[3] = x[3];
    state[4] = x[4];
  }
  void init()
  {
    state[0] = 0x67452301;
    state[1] = 0xefcdab89;
    state[2] = 0x98badcfe;
    state[3] = 0x10325476;
    state[4] = 0xc3d2e1f0;
  }
  int hammingdistance(hash b) {
    unsigned int x0 = (state[0] ^ b.state[0]).uint();
    unsigned int x1 = (state[1] ^ b.state[1]).uint();
    unsigned int x2 = (state[2] ^ b.state[2]).uint();
    unsigned int x3 = (state[3] ^ b.state[3]).uint();
    unsigned int x4 = (state[4] ^ b.state[4]).uint();
    // 32 1-bit chunks
    x0 = (x0 & 0x55555555) + ((x0 >> 1) & 0x55555555);
    x1 = (x1 & 0x55555555) + ((x1 >> 1) & 0x55555555);
    x2 = (x2 & 0x55555555) + ((x2 >> 1) & 0x55555555);
    x3 = (x3 & 0x55555555) + ((x3 >> 1) & 0x55555555);
    x4 = (x4 & 0x55555555) + ((x4 >> 1) & 0x55555555);
    // 16 2-bit chunks: 012,012,012,012,012,012,012,012,012,012,012,012,012,012,012,012
    x0 = (x0 & 0x33333333) + ((x0 >> 2) & 0x33333333);
    x1 = (x1 & 0x33333333) + ((x1 >> 2) & 0x33333333);
    x2 = (x2 & 0x33333333) + ((x2 >> 2) & 0x33333333);
    x3 = (x3 & 0x33333333) + ((x3 >> 2) & 0x33333333);
    x4 = (x4 & 0x33333333) + ((x4 >> 2) & 0x33333333);
    // 8 4-bit chunks: 01234,01234,01234,01234,01234,01234,01234,01234
    x0 = (x0 & 0x0f0f0f0f) + ((x0 >> 4) & 0x0f0f0f0f);
    x1 = (x1 & 0x0f0f0f0f) + ((x1 >> 4) & 0x0f0f0f0f);
    x2 = (x2 & 0x0f0f0f0f) + ((x2 >> 4) & 0x0f0f0f0f);
    x3 = (x3 & 0x0f0f0f0f) + ((x3 >> 4) & 0x0f0f0f0f);
    x4 = (x4 & 0x0f0f0f0f) + ((x4 >> 4) & 0x0f0f0f0f);
    // 4 8-bit chunks: 012345678,012345678,012345678,012345678
    x0 = (x0 * 16843009) >> 24;
    x1 = (x1 * 16843009) >> 24;
    x2 = (x2 * 16843009) >> 24;
    x3 = (x3 * 16843009) >> 24;
    x4 = (x4 * 16843009) >> 24;
    return x0 + x1 + x2 + x3 + x4;
  }
  friend ostream& operator<<(ostream& o,const hash& h) {
    o << h.state[0];
    o << h.state[1];
    o << h.state[2];
    o << h.state[3];
    o << h.state[4];
    return o;
  }
  void update(const unsigned int *in,unsigned long long inblocks) {
    uint32 a = state[0];
    uint32 b = state[1];
    uint32 c = state[2];
    uint32 d = state[3];
    uint32 e = state[4];
    uint32 f;
    uint32 x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15;
  
    while (inblocks > 0) {
      x0 = in[0];
      f = (c & b) | andnot(d,b);
      e = rotate5(a) + f + e + 0x5a827999 + x0;
      b = rotate30(b);
      x1 = in[1];
      f = (b & a) | andnot(c,a);
      d = rotate5(e) + f + d + 0x5a827999 + x1;
      a = rotate30(a);
      x2 = in[2];
      f = (a & e) | andnot(b,e);
      c = rotate5(d) + f + c + 0x5a827999 + x2;
      e = rotate30(e);
      x3 = in[3];
      f = (e & d) | andnot(a,d);
      b = rotate5(c) + f + b + 0x5a827999 + x3;
      d = rotate30(d);
      x4 = in[4];
      f = (d & c) | andnot(e,c);
      a = rotate5(b) + f + a + 0x5a827999 + x4;
      c = rotate30(c);
      x5 = in[5];
      f = (c & b) | andnot(d,b);
      e = rotate5(a) + f + e + 0x5a827999 + x5;
      b = rotate30(b);
      x6 = in[6];
      f = (b & a) | andnot(c,a);
      d = rotate5(e) + f + d + 0x5a827999 + x6;
      a = rotate30(a);
      x7 = in[7];
      f = (a & e) | andnot(b,e);
      c = rotate5(d) + f + c + 0x5a827999 + x7;
      e = rotate30(e);
      x8 = in[8];
      f = (e & d) | andnot(a,d);
      b = rotate5(c) + f + b + 0x5a827999 + x8;
      d = rotate30(d);
      x9 = in[9];
      f = (d & c) | andnot(e,c);
      a = rotate5(b) + f + a + 0x5a827999 + x9;
      c = rotate30(c);
      x10 = in[10];
      f = (c & b) | andnot(d,b);
      e = rotate5(a) + f + e + 0x5a827999 + x10;
      b = rotate30(b);
      x11 = in[11];
      f = (b & a) | andnot(c,a);
      d = rotate5(e) + f + d + 0x5a827999 + x11;
      a = rotate30(a);
      x12 = in[12];
      f = (a & e) | andnot(b,e);
      c = rotate5(d) + f + c + 0x5a827999 + x12;
      e = rotate30(e);
      x13 = in[13];
      f = (e & d) | andnot(a,d);
      b = rotate5(c) + f + b + 0x5a827999 + x13;
      d = rotate30(d);
      x14 = in[14];
      f = (d & c) | andnot(e,c);
      a = rotate5(b) + f + a + 0x5a827999 + x14;
      c = rotate30(c);
      x15 = in[15];
      f = (c & b) | andnot(d,b);
      e = rotate5(a) + f + e + 0x5a827999 + x15;
      b = rotate30(b);
      x0 = rotate1(x13 ^ x8 ^ x2 ^ x0);
      f = (b & a) | andnot(c,a);
      d = rotate5(e) + f + d + 0x5a827999 + x0;
      a = rotate30(a);
      x1 = rotate1(x14 ^ x9 ^ x3 ^ x1);
      f = (a & e) | andnot(b,e);
      c = rotate5(d) + f + c + 0x5a827999 + x1;
      e = rotate30(e);
      x2 = rotate1(x15 ^ x10 ^ x4 ^ x2);
      f = (e & d) | andnot(a,d);
      b = rotate5(c) + f + b + 0x5a827999 + x2;
      d = rotate30(d);
      x3 = rotate1(x0 ^ x11 ^ x5 ^ x3);
      f = (d & c) | andnot(e,c);
      a = rotate5(b) + f + a + 0x5a827999 + x3;
      c = rotate30(c);
      x4 = rotate1(x1 ^ x12 ^ x6 ^ x4);
      f = b ^ c ^ d;
      e = rotate5(a) + f + e + 0x6ed9eba1 + x4;
      b = rotate30(b);
      x5 = rotate1(x2 ^ x13 ^ x7 ^ x5);
      f = a ^ b ^ c;
      d = rotate5(e) + f + d + 0x6ed9eba1 + x5;
      a = rotate30(a);
      x6 = rotate1(x3 ^ x14 ^ x8 ^ x6);
      f = e ^ a ^ b;
      c = rotate5(d) + f + c + 0x6ed9eba1 + x6;
      e = rotate30(e);
      x7 = rotate1(x4 ^ x15 ^ x9 ^ x7);
      f = d ^ e ^ a;
      b = rotate5(c) + f + b + 0x6ed9eba1 + x7;
      d = rotate30(d);
      x8 = rotate1(x5 ^ x0 ^ x10 ^ x8);
      f = c ^ d ^ e;
      a = rotate5(b) + f + a + 0x6ed9eba1 + x8;
      c = rotate30(c);
      x9 = rotate1(x6 ^ x1 ^ x11 ^ x9);
      f = b ^ c ^ d;
      e = rotate5(a) + f + e + 0x6ed9eba1 + x9;
      b = rotate30(b);
      x10 = rotate1(x7 ^ x2 ^ x12 ^ x10);
      f = a ^ b ^ c;
      d = rotate5(e) + f + d + 0x6ed9eba1 + x10;
      a = rotate30(a);
      x11 = rotate1(x8 ^ x3 ^ x13 ^ x11);
      f = e ^ a ^ b;
      c = rotate5(d) + f + c + 0x6ed9eba1 + x11;
      e = rotate30(e);
      x12 = rotate1(x9 ^ x4 ^ x14 ^ x12);
      f = d ^ e ^ a;
      b = rotate5(c) + f + b + 0x6ed9eba1 + x12;
      d = rotate30(d);
      x13 = rotate1(x10 ^ x5 ^ x15 ^ x13);
      f = c ^ d ^ e;
      a = rotate5(b) + f + a + 0x6ed9eba1 + x13;
      c = rotate30(c);
      x14 = rotate1(x11 ^ x6 ^ x0 ^ x14);
      f = b ^ c ^ d;
      e = rotate5(a) + f + e + 0x6ed9eba1 + x14;
      b = rotate30(b);
      x15 = rotate1(x12 ^ x7 ^ x1 ^ x15);
      f = a ^ b ^ c;
      d = rotate5(e) + f + d + 0x6ed9eba1 + x15;
      a = rotate30(a);
      x0 = rotate1(x13 ^ x8 ^ x2 ^ x0);
      f = e ^ a ^ b;
      c = rotate5(d) + f + c + 0x6ed9eba1 + x0;
      e = rotate30(e);
      x1 = rotate1(x14 ^ x9 ^ x3 ^ x1);
      f = d ^ e ^ a;
      b = rotate5(c) + f + b + 0x6ed9eba1 + x1;
      d = rotate30(d);
      x2 = rotate1(x15 ^ x10 ^ x4 ^ x2);
      f = c ^ d ^ e;
      a = rotate5(b) + f + a + 0x6ed9eba1 + x2;
      c = rotate30(c);
      x3 = rotate1(x0 ^ x11 ^ x5 ^ x3);
      f = b ^ c ^ d;
      e = rotate5(a) + f + e + 0x6ed9eba1 + x3;
      b = rotate30(b);
      x4 = rotate1(x1 ^ x12 ^ x6 ^ x4);
      f = a ^ b ^ c;
      d = rotate5(e) + f + d + 0x6ed9eba1 + x4;
      a = rotate30(a);
      x5 = rotate1(x2 ^ x13 ^ x7 ^ x5);
      f = e ^ a ^ b;
      c = rotate5(d) + f + c + 0x6ed9eba1 + x5;
      e = rotate30(e);
      x6 = rotate1(x3 ^ x14 ^ x8 ^ x6);
      f = d ^ e ^ a;
      b = rotate5(c) + f + b + 0x6ed9eba1 + x6;
      d = rotate30(d);
      x7 = rotate1(x4 ^ x15 ^ x9 ^ x7);
      f = c ^ d ^ e;
      a = rotate5(b) + f + a + 0x6ed9eba1 + x7;
      c = rotate30(c);
      x8 = rotate1(x5 ^ x0 ^ x10 ^ x8);
      f = (b & c) | (b & d) | (c & d);
      e = rotate5(a) + f + e + 0x8f1bbcdc + x8;
      b = rotate30(b);
      x9 = rotate1(x6 ^ x1 ^ x11 ^ x9);
      f = (a & b) | (a & c) | (b & c);
      d = rotate5(e) + f + d + 0x8f1bbcdc + x9;
      a = rotate30(a);
      x10 = rotate1(x7 ^ x2 ^ x12 ^ x10);
      f = (e & a) | (e & b) | (a & b);
      c = rotate5(d) + f + c + 0x8f1bbcdc + x10;
      e = rotate30(e);
      x11 = rotate1(x8 ^ x3 ^ x13 ^ x11);
      f = (d & e) | (d & a) | (e & a);
      b = rotate5(c) + f + b + 0x8f1bbcdc + x11;
      d = rotate30(d);
      x12 = rotate1(x9 ^ x4 ^ x14 ^ x12);
      f = (c & d) | (c & e) | (d & e);
      a = rotate5(b) + f + a + 0x8f1bbcdc + x12;
      c = rotate30(c);
      x13 = rotate1(x10 ^ x5 ^ x15 ^ x13);
      f = (b & c) | (b & d) | (c & d);
      e = rotate5(a) + f + e + 0x8f1bbcdc + x13;
      b = rotate30(b);
      x14 = rotate1(x11 ^ x6 ^ x0 ^ x14);
      f = (a & b) | (a & c) | (b & c);
      d = rotate5(e) + f + d + 0x8f1bbcdc + x14;
      a = rotate30(a);
      x15 = rotate1(x12 ^ x7 ^ x1 ^ x15);
      f = (e & a) | (e & b) | (a & b);
      c = rotate5(d) + f + c + 0x8f1bbcdc + x15;
      e = rotate30(e);
      x0 = rotate1(x13 ^ x8 ^ x2 ^ x0);
      f = (d & e) | (d & a) | (e & a);
      b = rotate5(c) + f + b + 0x8f1bbcdc + x0;
      d = rotate30(d);
      x1 = rotate1(x14 ^ x9 ^ x3 ^ x1);
      f = (c & d) | (c & e) | (d & e);
      a = rotate5(b) + f + a + 0x8f1bbcdc + x1;
      c = rotate30(c);
      x2 = rotate1(x15 ^ x10 ^ x4 ^ x2);
      f = (b & c) | (b & d) | (c & d);
      e = rotate5(a) + f + e + 0x8f1bbcdc + x2;
      b = rotate30(b);
      x3 = rotate1(x0 ^ x11 ^ x5 ^ x3);
      f = (a & b) | (a & c) | (b & c);
      d = rotate5(e) + f + d + 0x8f1bbcdc + x3;
      a = rotate30(a);
      x4 = rotate1(x1 ^ x12 ^ x6 ^ x4);
      f = (e & a) | (e & b) | (a & b);
      c = rotate5(d) + f + c + 0x8f1bbcdc + x4;
      e = rotate30(e);
      x5 = rotate1(x2 ^ x13 ^ x7 ^ x5);
      f = (d & e) | (d & a) | (e & a);
      b = rotate5(c) + f + b + 0x8f1bbcdc + x5;
      d = rotate30(d);
      x6 = rotate1(x3 ^ x14 ^ x8 ^ x6);
      f = (c & d) | (c & e) | (d & e);
      a = rotate5(b) + f + a + 0x8f1bbcdc + x6;
      c = rotate30(c);
      x7 = rotate1(x4 ^ x15 ^ x9 ^ x7);
      f = (b & c) | (b & d) | (c & d);
      e = rotate5(a) + f + e + 0x8f1bbcdc + x7;
      b = rotate30(b);
      x8 = rotate1(x5 ^ x0 ^ x10 ^ x8);
      f = (a & b) | (a & c) | (b & c);
      d = rotate5(e) + f + d + 0x8f1bbcdc + x8;
      a = rotate30(a);
      x9 = rotate1(x6 ^ x1 ^ x11 ^ x9);
      f = (e & a) | (e & b) | (a & b);
      c = rotate5(d) + f + c + 0x8f1bbcdc + x9;
      e = rotate30(e);
      x10 = rotate1(x7 ^ x2 ^ x12 ^ x10);
      f = (d & e) | (d & a) | (e & a);
      b = rotate5(c) + f + b + 0x8f1bbcdc + x10;
      d = rotate30(d);
      x11 = rotate1(x8 ^ x3 ^ x13 ^ x11);
      f = (c & d) | (c & e) | (d & e);
      a = rotate5(b) + f + a + 0x8f1bbcdc + x11;
      c = rotate30(c);
      x12 = rotate1(x9 ^ x4 ^ x14 ^ x12);
      f = b ^ c ^ d;
      e = rotate5(a) + f + e + 0xca62c1d6 + x12;
      b = rotate30(b);
      x13 = rotate1(x10 ^ x5 ^ x15 ^ x13);
      f = a ^ b ^ c;
      d = rotate5(e) + f + d + 0xca62c1d6 + x13;
      a = rotate30(a);
      x14 = rotate1(x11 ^ x6 ^ x0 ^ x14);
      f = e ^ a ^ b;
      c = rotate5(d) + f + c + 0xca62c1d6 + x14;
      e = rotate30(e);
      x15 = rotate1(x12 ^ x7 ^ x1 ^ x15);
      f = d ^ e ^ a;
      b = rotate5(c) + f + b + 0xca62c1d6 + x15;
      d = rotate30(d);
      x0 = rotate1(x13 ^ x8 ^ x2 ^ x0);
      f = c ^ d ^ e;
      a = rotate5(b) + f + a + 0xca62c1d6 + x0;
      c = rotate30(c);
      x1 = rotate1(x14 ^ x9 ^ x3 ^ x1);
      f = b ^ c ^ d;
      e = rotate5(a) + f + e + 0xca62c1d6 + x1;
      b = rotate30(b);
      x2 = rotate1(x15 ^ x10 ^ x4 ^ x2);
      f = a ^ b ^ c;
      d = rotate5(e) + f + d + 0xca62c1d6 + x2;
      a = rotate30(a);
      x3 = rotate1(x0 ^ x11 ^ x5 ^ x3);
      f = e ^ a ^ b;
      c = rotate5(d) + f + c + 0xca62c1d6 + x3;
      e = rotate30(e);
      x4 = rotate1(x1 ^ x12 ^ x6 ^ x4);
      f = d ^ e ^ a;
      b = rotate5(c) + f + b + 0xca62c1d6 + x4;
      d = rotate30(d);
      x5 = rotate1(x2 ^ x13 ^ x7 ^ x5);
      f = c ^ d ^ e;
      a = rotate5(b) + f + a + 0xca62c1d6 + x5;
      c = rotate30(c);
      x6 = rotate1(x3 ^ x14 ^ x8 ^ x6);
      f = b ^ c ^ d;
      e = rotate5(a) + f + e + 0xca62c1d6 + x6;
      b = rotate30(b);
      x7 = rotate1(x4 ^ x15 ^ x9 ^ x7);
      f = a ^ b ^ c;
      d = rotate5(e) + f + d + 0xca62c1d6 + x7;
      a = rotate30(a);
      x8 = rotate1(x5 ^ x0 ^ x10 ^ x8);
      f = e ^ a ^ b;
      c = rotate5(d) + f + c + 0xca62c1d6 + x8;
      e = rotate30(e);
      x9 = rotate1(x6 ^ x1 ^ x11 ^ x9);
      f = d ^ e ^ a;
      b = rotate5(c) + f + b + 0xca62c1d6 + x9;
      d = rotate30(d);
      x10 = rotate1(x7 ^ x2 ^ x12 ^ x10);
      f = c ^ d ^ e;
      a = rotate5(b) + f + a + 0xca62c1d6 + x10;
      c = rotate30(c);
      x11 = rotate1(x8 ^ x3 ^ x13 ^ x11);
      f = b ^ c ^ d;
      e = rotate5(a) + f + e + 0xca62c1d6 + x11;
      b = rotate30(b);
      x12 = rotate1(x9 ^ x4 ^ x14 ^ x12);
      f = a ^ b ^ c;
      d = rotate5(e) + f + d + 0xca62c1d6 + x12;
      a = rotate30(a);
      x13 = rotate1(x10 ^ x5 ^ x15 ^ x13);
      f = e ^ a ^ b;
      c = rotate5(d) + f + c + 0xca62c1d6 + x13;
      e = rotate30(e);
      x14 = rotate1(x11 ^ x6 ^ x0 ^ x14);
      f = d ^ e ^ a;
      b = rotate5(c) + f + b + 0xca62c1d6 + x14;
      d = rotate30(d);
      x15 = rotate1(x12 ^ x7 ^ x1 ^ x15);
      f = c ^ d ^ e;
      a = rotate5(b) + f + a + 0xca62c1d6 + x15;
      c = rotate30(c);
  
      a = a + state[0];
      b = b + state[1];
      c = c + state[2];
      d = d + state[3];
      e = e + state[4];
      state[0] = a;
      state[1] = b;
      state[2] = c;
      state[3] = d;
      state[4] = e;
  
      --inblocks;
      in += 16; 
    }
  }
} ;

__device__ unsigned int andnot(unsigned int a,unsigned int b)
{
  return a & ~b;
}

__device__ unsigned int rotate1(unsigned int a)
{
  return (a << 1) | (a >> 31);
}

__device__ unsigned int rotate5(unsigned int a)
{
  return (a << 5) | (a >> 27);
}

__device__ unsigned int rotate30(unsigned int a)
{
  return (a << 30) | (a >> 2);
}

class gpu_hash {
  unsigned int state0;
  unsigned int state1;
  unsigned int state2;
  unsigned int state3;
  unsigned int state4;
public:
  __device__ gpu_hash() { }
  __device__ gpu_hash(const gpu_hash &x) {
    state0 = x.state0;
    state1 = x.state1;
    state2 = x.state2;
    state3 = x.state3;
    state4 = x.state4;
  }
  __device__ gpu_hash(const unsigned int x[5]) {
    state0 = x[0];
    state1 = x[1];
    state2 = x[2];
    state3 = x[3];
    state4 = x[4];
  }
  __device__ void init()
  {
    state0 = 0x67452301;
    state1 = 0xefcdab89;
    state2 = 0x98badcfe;
    state3 = 0x10325476;
    state4 = 0xc3d2e1f0;
  }
  __device__ int hammingdistance(gpu_hash b) {
    unsigned int x0 = (state0 ^ b.state0);
    unsigned int x1 = (state1 ^ b.state1);
    unsigned int x2 = (state2 ^ b.state2);
    unsigned int x3 = (state3 ^ b.state3);
    unsigned int x4 = (state4 ^ b.state4);
    // 32 1-bit chunks
    x0 = (x0 & 0x55555555) + ((x0 >> 1) & 0x55555555);
    x1 = (x1 & 0x55555555) + ((x1 >> 1) & 0x55555555);
    x2 = (x2 & 0x55555555) + ((x2 >> 1) & 0x55555555);
    x3 = (x3 & 0x55555555) + ((x3 >> 1) & 0x55555555);
    x4 = (x4 & 0x55555555) + ((x4 >> 1) & 0x55555555);
    // 16 2-bit chunks: 012,012,012,012,012,012,012,012,012,012,012,012,012,012,012,012
    x0 = (x0 & 0x33333333) + ((x0 >> 2) & 0x33333333);
    x1 = (x1 & 0x33333333) + ((x1 >> 2) & 0x33333333);
    x2 = (x2 & 0x33333333) + ((x2 >> 2) & 0x33333333);
    x3 = (x3 & 0x33333333) + ((x3 >> 2) & 0x33333333);
    x4 = (x4 & 0x33333333) + ((x4 >> 2) & 0x33333333);
    // 8 4-bit chunks: 01234,01234,01234,01234,01234,01234,01234,01234
    x0 = (x0 & 0x0f0f0f0f) + ((x0 >> 4) & 0x0f0f0f0f);
    x1 = (x1 & 0x0f0f0f0f) + ((x1 >> 4) & 0x0f0f0f0f);
    x2 = (x2 & 0x0f0f0f0f) + ((x2 >> 4) & 0x0f0f0f0f);
    x3 = (x3 & 0x0f0f0f0f) + ((x3 >> 4) & 0x0f0f0f0f);
    x4 = (x4 & 0x0f0f0f0f) + ((x4 >> 4) & 0x0f0f0f0f);
    // 4 8-bit chunks: 012345678,012345678,012345678,012345678
    x0 = (x0 * 16843009) >> 24;
    x1 = (x1 * 16843009) >> 24;
    x2 = (x2 * 16843009) >> 24;
    x3 = (x3 * 16843009) >> 24;
    x4 = (x4 * 16843009) >> 24;
    return x0 + x1 + x2 + x3 + x4;
  }
  __device__ void update(const unsigned int *in,unsigned long long inblocks) {
    unsigned int a = state0;
    unsigned int b = state1;
    unsigned int c = state2;
    unsigned int d = state3;
    unsigned int e = state4;
    unsigned int f;
    unsigned int x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15;
  
    while (inblocks > 0) {
      x0 = in[0];
      f = (c & b) | andnot(d,b);
      e = rotate5(a) + f + e + 0x5a827999 + x0;
      b = rotate30(b);
      x1 = in[1];
      f = (b & a) | andnot(c,a);
      d = rotate5(e) + f + d + 0x5a827999 + x1;
      a = rotate30(a);
      x2 = in[2];
      f = (a & e) | andnot(b,e);
      c = rotate5(d) + f + c + 0x5a827999 + x2;
      e = rotate30(e);
      x3 = in[3];
      f = (e & d) | andnot(a,d);
      b = rotate5(c) + f + b + 0x5a827999 + x3;
      d = rotate30(d);
      x4 = in[4];
      f = (d & c) | andnot(e,c);
      a = rotate5(b) + f + a + 0x5a827999 + x4;
      c = rotate30(c);
      x5 = in[5];
      f = (c & b) | andnot(d,b);
      e = rotate5(a) + f + e + 0x5a827999 + x5;
      b = rotate30(b);
      x6 = in[6];
      f = (b & a) | andnot(c,a);
      d = rotate5(e) + f + d + 0x5a827999 + x6;
      a = rotate30(a);
      x7 = in[7];
      f = (a & e) | andnot(b,e);
      c = rotate5(d) + f + c + 0x5a827999 + x7;
      e = rotate30(e);
      x8 = in[8];
      f = (e & d) | andnot(a,d);
      b = rotate5(c) + f + b + 0x5a827999 + x8;
      d = rotate30(d);
      x9 = in[9];
      f = (d & c) | andnot(e,c);
      a = rotate5(b) + f + a + 0x5a827999 + x9;
      c = rotate30(c);
      x10 = in[10];
      f = (c & b) | andnot(d,b);
      e = rotate5(a) + f + e + 0x5a827999 + x10;
      b = rotate30(b);
      x11 = in[11];
      f = (b & a) | andnot(c,a);
      d = rotate5(e) + f + d + 0x5a827999 + x11;
      a = rotate30(a);
      x12 = in[12];
      f = (a & e) | andnot(b,e);
      c = rotate5(d) + f + c + 0x5a827999 + x12;
      e = rotate30(e);
      x13 = in[13];
      f = (e & d) | andnot(a,d);
      b = rotate5(c) + f + b + 0x5a827999 + x13;
      d = rotate30(d);
      x14 = in[14];
      f = (d & c) | andnot(e,c);
      a = rotate5(b) + f + a + 0x5a827999 + x14;
      c = rotate30(c);
      x15 = in[15];
      f = (c & b) | andnot(d,b);
      e = rotate5(a) + f + e + 0x5a827999 + x15;
      b = rotate30(b);
      x0 = rotate1(x13 ^ x8 ^ x2 ^ x0);
      f = (b & a) | andnot(c,a);
      d = rotate5(e) + f + d + 0x5a827999 + x0;
      a = rotate30(a);
      x1 = rotate1(x14 ^ x9 ^ x3 ^ x1);
      f = (a & e) | andnot(b,e);
      c = rotate5(d) + f + c + 0x5a827999 + x1;
      e = rotate30(e);
      x2 = rotate1(x15 ^ x10 ^ x4 ^ x2);
      f = (e & d) | andnot(a,d);
      b = rotate5(c) + f + b + 0x5a827999 + x2;
      d = rotate30(d);
      x3 = rotate1(x0 ^ x11 ^ x5 ^ x3);
      f = (d & c) | andnot(e,c);
      a = rotate5(b) + f + a + 0x5a827999 + x3;
      c = rotate30(c);
      x4 = rotate1(x1 ^ x12 ^ x6 ^ x4);
      f = b ^ c ^ d;
      e = rotate5(a) + f + e + 0x6ed9eba1 + x4;
      b = rotate30(b);
      x5 = rotate1(x2 ^ x13 ^ x7 ^ x5);
      f = a ^ b ^ c;
      d = rotate5(e) + f + d + 0x6ed9eba1 + x5;
      a = rotate30(a);
      x6 = rotate1(x3 ^ x14 ^ x8 ^ x6);
      f = e ^ a ^ b;
      c = rotate5(d) + f + c + 0x6ed9eba1 + x6;
      e = rotate30(e);
      x7 = rotate1(x4 ^ x15 ^ x9 ^ x7);
      f = d ^ e ^ a;
      b = rotate5(c) + f + b + 0x6ed9eba1 + x7;
      d = rotate30(d);
      x8 = rotate1(x5 ^ x0 ^ x10 ^ x8);
      f = c ^ d ^ e;
      a = rotate5(b) + f + a + 0x6ed9eba1 + x8;
      c = rotate30(c);
      x9 = rotate1(x6 ^ x1 ^ x11 ^ x9);
      f = b ^ c ^ d;
      e = rotate5(a) + f + e + 0x6ed9eba1 + x9;
      b = rotate30(b);
      x10 = rotate1(x7 ^ x2 ^ x12 ^ x10);
      f = a ^ b ^ c;
      d = rotate5(e) + f + d + 0x6ed9eba1 + x10;
      a = rotate30(a);
      x11 = rotate1(x8 ^ x3 ^ x13 ^ x11);
      f = e ^ a ^ b;
      c = rotate5(d) + f + c + 0x6ed9eba1 + x11;
      e = rotate30(e);
      x12 = rotate1(x9 ^ x4 ^ x14 ^ x12);
      f = d ^ e ^ a;
      b = rotate5(c) + f + b + 0x6ed9eba1 + x12;
      d = rotate30(d);
      x13 = rotate1(x10 ^ x5 ^ x15 ^ x13);
      f = c ^ d ^ e;
      a = rotate5(b) + f + a + 0x6ed9eba1 + x13;
      c = rotate30(c);
      x14 = rotate1(x11 ^ x6 ^ x0 ^ x14);
      f = b ^ c ^ d;
      e = rotate5(a) + f + e + 0x6ed9eba1 + x14;
      b = rotate30(b);
      x15 = rotate1(x12 ^ x7 ^ x1 ^ x15);
      f = a ^ b ^ c;
      d = rotate5(e) + f + d + 0x6ed9eba1 + x15;
      a = rotate30(a);
      x0 = rotate1(x13 ^ x8 ^ x2 ^ x0);
      f = e ^ a ^ b;
      c = rotate5(d) + f + c + 0x6ed9eba1 + x0;
      e = rotate30(e);
      x1 = rotate1(x14 ^ x9 ^ x3 ^ x1);
      f = d ^ e ^ a;
      b = rotate5(c) + f + b + 0x6ed9eba1 + x1;
      d = rotate30(d);
      x2 = rotate1(x15 ^ x10 ^ x4 ^ x2);
      f = c ^ d ^ e;
      a = rotate5(b) + f + a + 0x6ed9eba1 + x2;
      c = rotate30(c);
      x3 = rotate1(x0 ^ x11 ^ x5 ^ x3);
      f = b ^ c ^ d;
      e = rotate5(a) + f + e + 0x6ed9eba1 + x3;
      b = rotate30(b);
      x4 = rotate1(x1 ^ x12 ^ x6 ^ x4);
      f = a ^ b ^ c;
      d = rotate5(e) + f + d + 0x6ed9eba1 + x4;
      a = rotate30(a);
      x5 = rotate1(x2 ^ x13 ^ x7 ^ x5);
      f = e ^ a ^ b;
      c = rotate5(d) + f + c + 0x6ed9eba1 + x5;
      e = rotate30(e);
      x6 = rotate1(x3 ^ x14 ^ x8 ^ x6);
      f = d ^ e ^ a;
      b = rotate5(c) + f + b + 0x6ed9eba1 + x6;
      d = rotate30(d);
      x7 = rotate1(x4 ^ x15 ^ x9 ^ x7);
      f = c ^ d ^ e;
      a = rotate5(b) + f + a + 0x6ed9eba1 + x7;
      c = rotate30(c);
      x8 = rotate1(x5 ^ x0 ^ x10 ^ x8);
      f = (b & c) | (b & d) | (c & d);
      e = rotate5(a) + f + e + 0x8f1bbcdc + x8;
      b = rotate30(b);
      x9 = rotate1(x6 ^ x1 ^ x11 ^ x9);
      f = (a & b) | (a & c) | (b & c);
      d = rotate5(e) + f + d + 0x8f1bbcdc + x9;
      a = rotate30(a);
      x10 = rotate1(x7 ^ x2 ^ x12 ^ x10);
      f = (e & a) | (e & b) | (a & b);
      c = rotate5(d) + f + c + 0x8f1bbcdc + x10;
      e = rotate30(e);
      x11 = rotate1(x8 ^ x3 ^ x13 ^ x11);
      f = (d & e) | (d & a) | (e & a);
      b = rotate5(c) + f + b + 0x8f1bbcdc + x11;
      d = rotate30(d);
      x12 = rotate1(x9 ^ x4 ^ x14 ^ x12);
      f = (c & d) | (c & e) | (d & e);
      a = rotate5(b) + f + a + 0x8f1bbcdc + x12;
      c = rotate30(c);
      x13 = rotate1(x10 ^ x5 ^ x15 ^ x13);
      f = (b & c) | (b & d) | (c & d);
      e = rotate5(a) + f + e + 0x8f1bbcdc + x13;
      b = rotate30(b);
      x14 = rotate1(x11 ^ x6 ^ x0 ^ x14);
      f = (a & b) | (a & c) | (b & c);
      d = rotate5(e) + f + d + 0x8f1bbcdc + x14;
      a = rotate30(a);
      x15 = rotate1(x12 ^ x7 ^ x1 ^ x15);
      f = (e & a) | (e & b) | (a & b);
      c = rotate5(d) + f + c + 0x8f1bbcdc + x15;
      e = rotate30(e);
      x0 = rotate1(x13 ^ x8 ^ x2 ^ x0);
      f = (d & e) | (d & a) | (e & a);
      b = rotate5(c) + f + b + 0x8f1bbcdc + x0;
      d = rotate30(d);
      x1 = rotate1(x14 ^ x9 ^ x3 ^ x1);
      f = (c & d) | (c & e) | (d & e);
      a = rotate5(b) + f + a + 0x8f1bbcdc + x1;
      c = rotate30(c);
      x2 = rotate1(x15 ^ x10 ^ x4 ^ x2);
      f = (b & c) | (b & d) | (c & d);
      e = rotate5(a) + f + e + 0x8f1bbcdc + x2;
      b = rotate30(b);
      x3 = rotate1(x0 ^ x11 ^ x5 ^ x3);
      f = (a & b) | (a & c) | (b & c);
      d = rotate5(e) + f + d + 0x8f1bbcdc + x3;
      a = rotate30(a);
      x4 = rotate1(x1 ^ x12 ^ x6 ^ x4);
      f = (e & a) | (e & b) | (a & b);
      c = rotate5(d) + f + c + 0x8f1bbcdc + x4;
      e = rotate30(e);
      x5 = rotate1(x2 ^ x13 ^ x7 ^ x5);
      f = (d & e) | (d & a) | (e & a);
      b = rotate5(c) + f + b + 0x8f1bbcdc + x5;
      d = rotate30(d);
      x6 = rotate1(x3 ^ x14 ^ x8 ^ x6);
      f = (c & d) | (c & e) | (d & e);
      a = rotate5(b) + f + a + 0x8f1bbcdc + x6;
      c = rotate30(c);
      x7 = rotate1(x4 ^ x15 ^ x9 ^ x7);
      f = (b & c) | (b & d) | (c & d);
      e = rotate5(a) + f + e + 0x8f1bbcdc + x7;
      b = rotate30(b);
      x8 = rotate1(x5 ^ x0 ^ x10 ^ x8);
      f = (a & b) | (a & c) | (b & c);
      d = rotate5(e) + f + d + 0x8f1bbcdc + x8;
      a = rotate30(a);
      x9 = rotate1(x6 ^ x1 ^ x11 ^ x9);
      f = (e & a) | (e & b) | (a & b);
      c = rotate5(d) + f + c + 0x8f1bbcdc + x9;
      e = rotate30(e);
      x10 = rotate1(x7 ^ x2 ^ x12 ^ x10);
      f = (d & e) | (d & a) | (e & a);
      b = rotate5(c) + f + b + 0x8f1bbcdc + x10;
      d = rotate30(d);
      x11 = rotate1(x8 ^ x3 ^ x13 ^ x11);
      f = (c & d) | (c & e) | (d & e);
      a = rotate5(b) + f + a + 0x8f1bbcdc + x11;
      c = rotate30(c);
      x12 = rotate1(x9 ^ x4 ^ x14 ^ x12);
      f = b ^ c ^ d;
      e = rotate5(a) + f + e + 0xca62c1d6 + x12;
      b = rotate30(b);
      x13 = rotate1(x10 ^ x5 ^ x15 ^ x13);
      f = a ^ b ^ c;
      d = rotate5(e) + f + d + 0xca62c1d6 + x13;
      a = rotate30(a);
      x14 = rotate1(x11 ^ x6 ^ x0 ^ x14);
      f = e ^ a ^ b;
      c = rotate5(d) + f + c + 0xca62c1d6 + x14;
      e = rotate30(e);
      x15 = rotate1(x12 ^ x7 ^ x1 ^ x15);
      f = d ^ e ^ a;
      b = rotate5(c) + f + b + 0xca62c1d6 + x15;
      d = rotate30(d);
      x0 = rotate1(x13 ^ x8 ^ x2 ^ x0);
      f = c ^ d ^ e;
      a = rotate5(b) + f + a + 0xca62c1d6 + x0;
      c = rotate30(c);
      x1 = rotate1(x14 ^ x9 ^ x3 ^ x1);
      f = b ^ c ^ d;
      e = rotate5(a) + f + e + 0xca62c1d6 + x1;
      b = rotate30(b);
      x2 = rotate1(x15 ^ x10 ^ x4 ^ x2);
      f = a ^ b ^ c;
      d = rotate5(e) + f + d + 0xca62c1d6 + x2;
      a = rotate30(a);
      x3 = rotate1(x0 ^ x11 ^ x5 ^ x3);
      f = e ^ a ^ b;
      c = rotate5(d) + f + c + 0xca62c1d6 + x3;
      e = rotate30(e);
      x4 = rotate1(x1 ^ x12 ^ x6 ^ x4);
      f = d ^ e ^ a;
      b = rotate5(c) + f + b + 0xca62c1d6 + x4;
      d = rotate30(d);
      x5 = rotate1(x2 ^ x13 ^ x7 ^ x5);
      f = c ^ d ^ e;
      a = rotate5(b) + f + a + 0xca62c1d6 + x5;
      c = rotate30(c);
      x6 = rotate1(x3 ^ x14 ^ x8 ^ x6);
      f = b ^ c ^ d;
      e = rotate5(a) + f + e + 0xca62c1d6 + x6;
      b = rotate30(b);
      x7 = rotate1(x4 ^ x15 ^ x9 ^ x7);
      f = a ^ b ^ c;
      d = rotate5(e) + f + d + 0xca62c1d6 + x7;
      a = rotate30(a);
      x8 = rotate1(x5 ^ x0 ^ x10 ^ x8);
      f = e ^ a ^ b;
      c = rotate5(d) + f + c + 0xca62c1d6 + x8;
      e = rotate30(e);
      x9 = rotate1(x6 ^ x1 ^ x11 ^ x9);
      f = d ^ e ^ a;
      b = rotate5(c) + f + b + 0xca62c1d6 + x9;
      d = rotate30(d);
      x10 = rotate1(x7 ^ x2 ^ x12 ^ x10);
      f = c ^ d ^ e;
      a = rotate5(b) + f + a + 0xca62c1d6 + x10;
      c = rotate30(c);
      x11 = rotate1(x8 ^ x3 ^ x13 ^ x11);
      f = b ^ c ^ d;
      e = rotate5(a) + f + e + 0xca62c1d6 + x11;
      b = rotate30(b);
      x12 = rotate1(x9 ^ x4 ^ x14 ^ x12);
      f = a ^ b ^ c;
      d = rotate5(e) + f + d + 0xca62c1d6 + x12;
      a = rotate30(a);
      x13 = rotate1(x10 ^ x5 ^ x15 ^ x13);
      f = e ^ a ^ b;
      c = rotate5(d) + f + c + 0xca62c1d6 + x13;
      e = rotate30(e);
      x14 = rotate1(x11 ^ x6 ^ x0 ^ x14);
      f = d ^ e ^ a;
      b = rotate5(c) + f + b + 0xca62c1d6 + x14;
      d = rotate30(d);
      x15 = rotate1(x12 ^ x7 ^ x1 ^ x15);
      f = c ^ d ^ e;
      a = rotate5(b) + f + a + 0xca62c1d6 + x15;
      c = rotate30(c);
  
      a = a + state0;
      b = b + state1;
      c = c + state2;
      d = d + state3;
      e = e + state4;
      state0 = a;
      state1 = b;
      state2 = c;
      state3 = d;
      state4 = e;
  
      --inblocks;
      in += 16; 
    }
  }
} ;

__constant__ const char ALPHABET[65] =
"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/_";

#define ALPHABETTOP 32
#define ALPHABETBOT 62

unsigned int words[64 + 16 * ((sizeof s + sizeof target) / 64)];

__global__ void doit(unsigned char *s,unsigned long long slen,
  unsigned int sblocks,unsigned int sblockspre,
  unsigned int *targetstate,unsigned int *results)
{
  int tid = blockIdx.x * blockDim.x + threadIdx.x;
  int c0;
  int c1;
  int c2;
  int c3;
  int c4;
  int i;
  unsigned int words[32];

  for (i = 0;i < sizeof words;++i) ((unsigned char *) words)[i] = 0;
  for (i = 0;i < slen - 5;++i) ((unsigned char *) words)[i ^ 3] = s[i];
  ((unsigned char *) words)[slen ^ 3] = 0x80;
  words[sblocks * 16 - 1] = slen * 8;

  gpu_hash shashpre;
  shashpre.init();
  shashpre.update(words,sblockspre);

  gpu_hash targethash(targetstate);

  c0 = tid % ALPHABETTOP;
  c1 = (tid / ALPHABETTOP) % ALPHABETTOP;
  c2 = ((tid / ALPHABETTOP) / ALPHABETTOP) % ALPHABETTOP;

  ((unsigned char *) words)[(slen - 5) ^ 3] = ALPHABET[c0];
  ((unsigned char *) words)[(slen - 4) ^ 3] = ALPHABET[c1];
  ((unsigned char *) words)[(slen - 3) ^ 3] = ALPHABET[c2];
  for (c3 = 0;c3 < ALPHABETBOT;++c3) {
    ((unsigned char *) words)[(slen - 2) ^ 3] = ALPHABET[c3];
    for (c4 = 0;c4 < ALPHABETBOT;++c4) {
      ((unsigned char *) words)[(slen - 1) ^ 3] = ALPHABET[c4];

      gpu_hash shash(shashpre);
      shash.update(words + sblockspre * 16,sblocks - sblockspre);
      int d = shash.hammingdistance(targethash);

      if (d < 38) {
        results[0] = tid;
        results[1] = ALPHABET[c0];
        results[2] = ALPHABET[c1];
        results[3] = ALPHABET[c2];
        results[4] = ALPHABET[c3];
        results[5] = ALPHABET[c4];
      }
    }
  }
}

int main(int argc,char **argv)
{
  int i;
  
  long long targetlen = 0;
  while (target[targetlen]) ++targetlen;
  long long targetblocks = (targetlen + 72) / 64;

  for (i = 0;i < sizeof words;++i) ((unsigned char *) words)[i] = 0;
  for (i = 0;i < targetlen;++i) ((unsigned char *) words)[i ^ 3] = target[i];
  ((unsigned char *) words)[targetlen ^ 3] = 0x80;
  words[targetblocks * 16 - 1] = targetlen * 8;

  hash targethash;
  targethash.init();
  targethash.update(words,targetblocks);

  cout << 0 << " " << targethash << " " << target << "\n";

  unsigned char flip[sizeof s];

  long long slen = 0;
  while (s[slen]) ++slen;
  if (slen < 5) return 100;
  long long sblocks = (slen + 72) / 64;
  long long sblockspre = (slen - 5) / 64;

#ifndef NONRANDOM
  srandom(cpucycles()); // XXX: randomize better
#endif
  for (i = 0;i < slen;++i) {
    flip[i] = 0;
    if (random() & 1) if (s[i] != ' ') s[i] ^= 32;
  }

  if (argv[1]) cudaSetDevice(atoi(argv[1]));

  int numgpu;
  cudaGetDeviceCount(&numgpu);
  int curgpu;
  cudaGetDevice(&curgpu);
  cout << "using GPU " << curgpu << " out of " << numgpu << "\n";

  unsigned int *gpu_targethash;
  cudaMalloc((void **) &gpu_targethash,5 * sizeof(unsigned int));

  unsigned int results[10];
  unsigned int *gpu_results;
  cudaMalloc((void **) &gpu_results,10 * sizeof(unsigned int));

  unsigned char *gpu_s;
  cudaMalloc((void **) &gpu_s,slen + 1);

  dim3 dimBlock(64);
  dim3 dimGrid((ALPHABETTOP * ALPHABETTOP * ALPHABETTOP) / 64);

  long long startcycles = cpucycles();
  long long innerloopcycles = 0;
  long long hashes = 1;
  long long printcycles = 0;

  for (;;) {
    ++printcycles;
    if (printcycles == 128) {
      cout << "cycles " << dec
        << (cpucycles() - startcycles) / (1.0 * hashes) << " "
        << (innerloopcycles) / (1.0 * hashes) << " "
        << s << "\n" << flush;
      printcycles = 0;
    }

    results[0] = 0;
    cudaMemcpy(gpu_targethash,&targethash,sizeof targethash,cudaMemcpyHostToDevice);
    cudaMemcpy(gpu_s,s,slen + 1,cudaMemcpyHostToDevice);
    cudaMemcpy(gpu_results,results,sizeof results,cudaMemcpyHostToDevice);
    innerloopcycles -= cpucycles();
    doit<<<dimGrid,dimBlock>>>(gpu_s,slen,sblocks,sblockspre,gpu_targethash,gpu_results);
    cudaMemcpy(results,gpu_results,sizeof results,cudaMemcpyDeviceToHost);
    innerloopcycles += cpucycles();

    hashes += ALPHABETTOP * (long long) ALPHABETTOP * (long long) ALPHABETTOP
      * (long long) ALPHABETBOT * (long long) ALPHABETBOT;

    if (results[0]) {
      s[slen - 5] = results[1];
      s[slen - 4] = results[2];
      s[slen - 3] = results[3];
      s[slen - 2] = results[4];
      s[slen - 1] = results[5];

      for (i = 0;i < sizeof words;++i) ((unsigned char *) words)[i] = 0;
      for (i = 0;i < slen;++i) ((unsigned char *) words)[i ^ 3] = s[i];
      ((unsigned char *) words)[slen ^ 3] = 0x80;
      words[sblocks * 16 - 1] = slen * 8;

      hash shash;
      shash.init();
      shash.update(words,sblocks);

      cout << dec << shash.hammingdistance(targethash) << " " << shash << " " << s << "\n" << flush;
    }

    for (i = 0;i < slen - 5;++i) if (s[i] != ' ') {
      s[i] ^= 32;
      flip[i] ^= 32;
      if (flip[i]) break;
    }

    if (i == slen - 5) return 0;
  }
}
