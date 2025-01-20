# Symmetries in Complex-Valued Spherical Harmonic Processing of Real-Valued Signals
This repository numerically validates and gives examples on how to apply the symmetries of complex-valued spherical harmonic (SH) and circular harmonic (CH) expansions given in

```
Thomas Deppisch and Jens Ahrens, 
"Symmetries in Complex-Valued Spherical Harmonic Processing of Real-Valued Signals," 
Proc. of the Annual German Conference on Acoustics (DAGA), 2025.
```

Considering these symmetries in signal processing algorithms that involve complex-valued SHs (or CHs) and are based on real-valued (time-domain) signals may significantly reduce the required computations and memory.

The validation scripts use SH implementations from the [Spherical Harmonic Transform Library](https://github.com/polarch/Spherical-Harmonic-Transform.git), which is linked as submodule under `dependencies`. 
Clone this repository using `git clone --recurse-submodules` to make sure the corresponding functions are available.