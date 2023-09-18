# Build compiler-rt/builtins for riscv

This project is **completely** copied and cut from the llvm project:

- Repo: `https://github.com/llvm/llvm-project`,
- Branch: `release/16.x`
- Commit: `7cbf1a259`

You can execute the `check.sh` script to confirm that we have not made any modifications to the source code.

To build it, run `build.sh`, the static library will be generated at `build-compiler-rt/lib/baremetal/libclang_rt.builtins-riscv64.a`.
