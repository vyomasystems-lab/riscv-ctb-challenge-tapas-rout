# See https://gitlab.com/vyoma_systems/common/-/blob/main/LICENSE.vyoma for more details
 
#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64M
RVTEST_CODE_BEGIN

  .align 2
  .option norvc

  li TESTNUM, 2
  la t4, mtvec_handler
  csrw mtvec, t4

illegal_instruction:
  .word 0
  addi t3, t4, t4

  .align 8
  .global mtvec_handler
mtvec_handler:
  li t1, CAUSE_ILLEGAL_INSTRUCTION
  csrr t0, mcause
  bne t0, t1, fail
  csrr t2, mepc
  addi t2, t2, 4
  csrw mepc, t2
  mret

TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END