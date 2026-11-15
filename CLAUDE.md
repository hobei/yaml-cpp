# Project guide for agents

This is a fork of [yaml-cpp](https://github.com/jbeder/yaml-cpp), a C++ YAML 1.2
parser and emitter. Here it is a **test vehicle for an agent software factory**
(the workflow in `.github/`). Issues in this fork are copies of upstream issues.
Keep changes small and focused.

## Layout

- `include/yaml-cpp/`: public headers. `src/`: implementation.
- `test/`: GoogleTest suite. `test/googletest-*` is vendored and must not change.
- `docs/design/spec.md`: living design spec. Per-change designs live on the
  GitHub issue / PR. Other files in `docs/` are user documentation.
- `scripts/build.sh`, `scripts/test.sh`: the only supported build and test commands.
- `.github/`, `scripts/`, CMake and Bazel files: agents must not modify them.

## Build and test

```sh
./scripts/build.sh   # Debug + ASan/UBSan, tests on
./scripts/test.sh
```

## Coding rules

- Follow the YAML 1.2 spec. When an issue says the parser accepts or rejects
  something wrongly, cite the spec production or example that decides it.
- Keep the public API source compatible. No new dependencies.
- Match the surrounding style (`.clang-format`).
- Every behaviour change needs a test. Never weaken or delete tests to get a pass.
- No features beyond the approved design.
