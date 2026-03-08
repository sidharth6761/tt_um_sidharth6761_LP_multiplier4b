# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):

    dut._log.info("Start test")

    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0

    await ClockCycles(dut.clk, 5)

    dut.rst_n.value = 1

    # -------- Test Case 1 --------
    A = 3
    B = 2

    dut.ui_in.value = (B << 4) | A

    await ClockCycles(dut.clk, 1)

    expected = A * B
    dut._log.info(f"A={A} B={B} Expected={expected} Output={dut.uo_out.value}")

    assert dut.uo_out.value == expected


    # -------- Test Case 2 --------
    A = 4
    B = 5

    dut.ui_in.value = (B << 4) | A

    await ClockCycles(dut.clk, 1)

    expected = A * B
    dut._log.info(f"A={A} B={B} Expected={expected} Output={dut.uo_out.value}")

    assert dut.uo_out.value == expected


    # -------- Test Case 3 --------
    A = 7
    B = 3

    dut.ui_in.value = (B << 4) | A

    await ClockCycles(dut.clk, 1)

    expected = A * B
    dut._log.info(f"A={A} B={B} Expected={expected} Output={dut.uo_out.value}")

    assert dut.uo_out.value == expected
