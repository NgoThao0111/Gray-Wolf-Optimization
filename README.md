# Hybrid Grey Wolf Optimizer (HGWO) Benchmark Project

## Overview

This project evaluates and compares three optimization algorithms: -
**GWO** (Grey Wolf Optimizer) - **IGWO** (Improved GWO with parabolic
control parameter) - **HGWO** (Hybrid GWO combined with PSO refinement)

The purpose of this project is to analyze how modifications to the
original GWO improve convergence speed, exploration--exploitation
balance, and robustness against local minima.

## Algorithms Included

### 1. Grey Wolf Optimizer (GWO)

The baseline algorithm inspired by the leadership hierarchy and hunting
behavior of grey wolves.\
Uses a **linearly decreasing parameter a** from 2 to 0.

### 2. Improved GWO (IGWO)

This version modifies the control parameter using a **parabolic decay**:

a(t) = 2 \* (1 - (t / MaxIter)\^2)

This allows the algorithm to **maintain exploration longer** and reduces
the risk of premature convergence.

### 3. Hybrid GWO (HGWO)

HGWO integrates a **PSO-based velocity term** to improve local search:

-   GWO guides the global search.
-   PSO fine-tunes around promising regions.
-   Velocity is clamped to maintain stability.

This hybrid structure achieves faster convergence, especially on
multimodal problems.

## Benchmark Function

All algorithms are tested on the **Rastrigin function**, a standard
multimodal benchmark for global optimization:

f(x) = 10n + sum( x_i\^2 - 10\*cos(2πx_i) )

-   Global minimum: f(0,...,0) = 0
-   Highly multimodal → useful for testing exploitation/exploration
    balance

## Experimental Setup

-   Population size: 30 wolves
-   Dimensions: 30
-   Iterations: 300
-   Boundaries: \[-5.12, 5.12\]

The project runs all algorithms and records: - Best fitness per
iteration - Final best solution - Convergence curves

## Results Summary

-   **GWO** shows slow convergence and stagnates early.
-   **IGWO** significantly improves global search due to parabolic
    decay.
-   **HGWO** achieves the best performance:
    -   Fastest descent
    -   Strong exploitation via PSO
    -   Reaches values near 0 much earlier

## Repository Structure

-   `GWO.m` --- Standard Grey Wolf Optimizer\
-   `IGWO.m` --- Improved GWO with parabolic control\
-   `HGWO.m` --- Hybrid GWO with PSO refinement\
-   `objective.m` --- Rastrigin function\
-   `main.m` --- Runs all algorithms and plots comparison\
-   `plots/` --- Output convergence curves
