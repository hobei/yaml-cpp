This is a C++ YAML 1.2 parser/emitter built with ASan and UBSan. When checking
correctness, look specifically at:

- spec conformance: the change matches the YAML 1.2 spec production or example
  the issue cites, and doesn't start accepting or rejecting other valid input
- regressions: the existing spec-example tests still pass unchanged
- public API and ABI: no breaking changes to `include/yaml-cpp/` unless approved
- memory safety and undefined behaviour: out-of-bounds reads in the scanner,
  dangling references to nodes, signed overflow
- the coding rules in `CLAUDE.md`
