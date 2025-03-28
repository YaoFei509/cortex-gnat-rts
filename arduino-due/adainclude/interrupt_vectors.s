        @ Copyright (C) 2021-24 Free Software Foundation, Inc.

        @ This file is part of the FreeRTOS-Ada project. This file is
	@ free software; you can redistribute it and/or modify it under
	@ terms of the GNU General Public License as published by the Free
	@ Software Foundation; either version 3, or (at your option) any
	@ later version. This file is distributed in the hope that it will
	@ be useful, but WITHOUT ANY WARRANTY; without even the implied
	@ warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

	@ As a special exception under Section 7 of GPL version 3, you are
	@ granted additional permissions described in the GCC Runtime
	@ Library Exception, version 3.1, as published by the Free Software
	@ Foundation.

	@ You should have received a copy of the GNU General Public License
	@ and a copy of the GCC Runtime Library Exception along with this
	@ program; see the files COPYING3 and COPYING.RUNTIME respectively.
	@ If not, see <http://www.gnu.org/licenses/>.

	@ This is the Vector Table, described in 11057 23-mar-15, Chapter 10.6.4

	@ The capitalized handlers are defined in startup.adb, using
	@ weak symbols (they can't be defined here, unlike _fault, or
	@ the linker satisfies the requirement immediately).

	.syntax unified
	.cpu cortex-m4
	.thumb

	.text
        .section .isr_vector
        .align 2
	.global _isr_vector
        .type _isr_vector, %object

_isr_vector:
        /* Startup */
        .word   _end_stack              /* top of stack, from linker script. */
        .word   program_initialization  /* entry point */

	/* Cortex-M core interrupts */
	.word   _fault             /* -14 NMI. */
	.word   HardFault_Handler  /* -13 Hard fault. */
	.word   _fault             /* -12 Mem manage. */
	.word   _fault             /* -11 Bus fault. */
	.word   _fault             /* -10 Usage fault. */
	.word   _fault             /* -9 reserved. */
	.word   _fault             /* -8 reserved. */
	.word   _fault             /* -7 reserved. */
	.word   _fault             /* -6 reserved. */
	.word   SVC_Handler        /* -5 SVCall. */
	.word   _fault             /* -4 Breakpoint. */
	.word   _fault             /* -3 reserved. */
	.word   PendSV_Handler     /* -2 PendSV. */
	.word   SysTick_Handler    /* -1 Systick. */

	/* MCU interrupts */
        .rept 45                   /* 0 .. 44, standard */
        .word IRQ_Handler
        .endr

        .size _isr_vector, . - _isr_vector

        .section .text

        .thumb_func
        .type _fault, %function
_fault: b _fault
        .size _fault, . - _fault

