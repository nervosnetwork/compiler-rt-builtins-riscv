

CC := clang-16
LD := ld.lld-16
OBJCOPY := llvm-objcopy-16
AR := llvm-ar-16
RANLIB := llvm-ranlib-16

UNAME := $(shell uname)
ifeq ($(UNAME), Darwin)
	LD := ld.lld
	OBJCOPY := llvm-objcopy
	RANLIB := llvm-ranlib
	AR := llvm-ar
endif

CFLAGS := --target=riscv64-unknown-elf  -march=rv64imc_zba_zbb_zbc_zbs -mabi=lp64 
CFLAGS += -Os
CFLAGS += -fdata-sections -ffunction-sections -fno-builtin -fvisibility=hidden -fomit-frame-pointer
CFLAGS += -I compiler-rt/lib/builtins
CFLAGS += -DVISIBILITY_HIDDEN -DCOMPILER_RT_HAS_FLOAT16

RT_OBJ := build/fixunsdfdi.o \
build/absvdi2.o \
build/absvsi2.o \
build/absvti2.o \
build/adddf3.o \
build/addsf3.o \
build/addvdi3.o \
build/addvsi3.o \
build/addvti3.o \
build/apple_versioning.o \
build/ashldi3.o \
build/ashlti3.o \
build/ashrdi3.o \
build/ashrti3.o \
build/bswapdi2.o \
build/bswapsi2.o \
build/clzdi2.o \
build/clzsi2.o \
build/clzti2.o \
build/cmpdi2.o \
build/cmpti2.o \
build/comparedf2.o \
build/comparesf2.o \
build/ctzdi2.o \
build/ctzsi2.o \
build/ctzti2.o \
build/divdc3.o \
build/divdf3.o \
build/divdi3.o \
build/divmoddi4.o \
build/divmodsi4.o \
build/divmodti4.o \
build/divsc3.o \
build/divsf3.o \
build/divsi3.o \
build/divti3.o \
build/extendsfdf2.o \
build/extendhfsf2.o \
build/ffsdi2.o \
build/ffssi2.o \
build/ffsti2.o \
build/fixdfdi.o \
build/fixdfsi.o \
build/fixdfti.o \
build/fixsfdi.o \
build/fixsfsi.o \
build/fixsfti.o \
build/fixunsdfdi.o \
build/fixunsdfsi.o \
build/fixunsdfti.o \
build/fixunssfdi.o \
build/fixunssfsi.o \
build/fixunssfti.o \
build/floatdidf.o \
build/floatdisf.o \
build/floatsidf.o \
build/floatsisf.o \
build/floattidf.o \
build/floattisf.o \
build/floatundidf.o \
build/floatundisf.o \
build/floatunsidf.o \
build/floatunsisf.o \
build/floatuntidf.o \
build/floatuntisf.o \
build/fp_mode.o \
build/int_util.o \
build/lshrdi3.o \
build/lshrti3.o \
build/moddi3.o \
build/modsi3.o \
build/modti3.o \
build/muldc3.o \
build/muldf3.o \
build/muldi3.o \
build/mulodi4.o \
build/mulosi4.o \
build/muloti4.o \
build/mulsc3.o \
build/mulsf3.o \
build/multi3.o \
build/mulvdi3.o \
build/mulvsi3.o \
build/mulvti3.o \
build/negdf2.o \
build/negdi2.o \
build/negsf2.o \
build/negti2.o \
build/negvdi2.o \
build/negvsi2.o \
build/negvti2.o \
build/os_version_check.o \
build/paritydi2.o \
build/paritysi2.o \
build/parityti2.o \
build/popcountdi2.o \
build/popcountsi2.o \
build/popcountti2.o \
build/powidf2.o \
build/powisf2.o \
build/subdf3.o \
build/subsf3.o \
build/subvdi3.o \
build/subvsi3.o \
build/subvti3.o \
build/trampoline_setup.o \
build/truncdfhf2.o \
build/truncdfsf2.o \
build/truncsfhf2.o \
build/ucmpdi2.o \
build/ucmpti2.o \
build/udivdi3.o \
build/udivmoddi4.o \
build/udivmodsi4.o \
build/udivmodti4.o \
build/udivsi3.o \
build/udivti3.o \
build/umoddi3.o \
build/umodsi3.o \
build/umodti3.o \
build/addtf3.o \
build/comparetf2.o \
build/divtc3.o \
build/divtf3.o \
build/extenddftf2.o \
build/extendhftf2.o \
build/extendsftf2.o \
build/fixtfdi.o \
build/fixtfsi.o \
build/fixtfti.o \
build/fixunstfdi.o \
build/fixunstfsi.o \
build/fixunstfti.o \
build/floatditf.o \
build/floatsitf.o \
build/floattitf.o \
build/floatunditf.o \
build/floatunsitf.o \
build/floatuntitf.o \
build/multc3.o \
build/multf3.o \
build/powitf2.o \
build/subtf3.o \
build/trunctfdf2.o \
build/trunctfhf2.o \
build/trunctfsf2.o 

RISCV_OBJ := build/fp_mode.o build/muldi3.S.o
# build/save.o \
# build/restore.o\


all: build/libcompiler-rt.a

build/libcompiler-rt.a: $(RT_OBJ) $(RISCV_OBJ)
	$(AR) -rc $@ $^

build/%.o: compiler-rt/lib/builtins/%.c
	@echo build $<
	@$(CC) $(CFLAGS) -c -o $@ $<

build/%.o: compiler-rt/lib/builtins/riscv/*.c
	@echo build $<
	@$(CC) $(CFLAGS) -c -o $@ $<

build/muldi3.S.o: compiler-rt/lib/builtins/riscv/muldi3.S
	@echo build $<
	@$(CC) $(CFLAGS) -c -o $@ $<

clean: 
	rm -f build/*.o
	rm -f build/*.a
