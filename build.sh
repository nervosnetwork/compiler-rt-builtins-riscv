set -ex

rm -rf build-compiler-rt
mkdir -p build-compiler-rt
cd build-compiler-rt

FLAGS="--target=riscv64-unknown-elf -march=rv64imac_zba_zbb_zbc_zbs -mabi=lp64"
cmake ../compiler-rt/lib/builtins \
    -DCMAKE_C_COMPILER=/usr/bin/clang-16 \
    -DCMAKE_AR=/usr/bin/llvm-ar-16 \
    -DCMAKE_NM=/usr/bin/llvm-nm-16 \
    -DCMAKE_RANLIB=/usr/bin/llvm-ranlib-16 \
    -DCMAKE_C_COMPILER_TARGET="riscv64-unknown-elf" \
    -DCMAKE_ASM_COMPILER_TARGET="riscv64-unknown-elf" \
    -DCOMPILER_RT_DEFAULT_TARGET_ONLY=ON \
    -DCMAKE_C_FLAGS="$FLAGS" \
    -DCMAKE_ASM_FLAGS="$FLAGS" \
    -DCOMPILER_RT_OS_DIR="baremetal" \
    -DCOMPILER_RT_BAREMETAL_BUILD=ON \
    -DLLVM_CONFIG_PATH=/usr/bin/llvm-config-16
make
