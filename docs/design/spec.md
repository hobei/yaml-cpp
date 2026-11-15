# Design: yaml-cpp

This is the **living design spec** for this fork. It describes the library as it
is (or, on an open design PR, as it will be once that PR lands). Per-change goals
and acceptance criteria live on the GitHub issue and design PR, not here.

This fork is a test vehicle for an agent software factory. Changes should be
small and focused, and should match upstream yaml-cpp style.

## Goals

- Parse and emit YAML as defined by the [YAML 1.2 spec](https://yaml.org/spec/1.2.2/).
- C++11-compatible public API, with no dependencies beyond the standard library.
- Stable public API: existing user code keeps compiling and keeps its behaviour
  unless an issue explicitly approves a change.

## Architecture

| Layer | Files | Role |
|---|---|---|
| Stream and scanner | `src/stream.*`, `src/scanner.*`, `src/scan*.cpp`, `src/exp.*`, `src/regex*` | Turns characters into tokens. Indentation, flow/block context, scalar folding. |
| Parser | `src/parser.cpp`, `src/singledocparser.*`, `src/directives.*`, `src/tag.*` | Turns tokens into events (`EventHandler` callbacks). |
| Node API | `include/yaml-cpp/node/**`, `src/node*.cpp`, `src/nodebuilder.*`, `src/convert.cpp` | `YAML::Load`/`LoadAll` build a `YAML::Node` tree; `convert<T>` maps to C++ types. |
| Emitter | `include/yaml-cpp/emitter*.h`, `src/emitter*.cpp`, `src/emit*.cpp` | `YAML::Emitter` and `operator<<` write YAML text. |
| Errors | `include/yaml-cpp/exceptions.h`, `src/exceptions.cpp` | `ParserException`, `BadConversion` etc., with a `Mark` (line/column). |

## Behaviour rules

- Input the spec rejects must raise `YAML::ParserException` with a useful mark,
  not be silently accepted.
- Input the spec accepts must load with the same structure, tags and values the
  spec describes.
- Null resolution: a node with empty content loads as Null (`OnNull`) when
  it is untagged, has the non-specific `?` tag, or has the explicit tag
  `tag:yaml.org,2002:null` (e.g. `!!null`). An empty node with any other
  tag (e.g. `!`, `!!str`, `!foo`) loads as an empty-string Scalar that
  keeps its tag.
- Emitted YAML must load back to an equal node tree (round trip).
- No undefined behaviour or leaks: tests run under ASan and UBSan.

## Tests

GoogleTest suite under `test/`. Spec examples live in
`test/integration/handler_spec_test.cpp` and `test/integration/node_spec_test.cpp`.
Parser/loader bugs get a regression test in `test/integration/load_node_test.cpp`
or the closest existing file. Emitter changes get tests in
`test/integration/emitter_test.cpp`.
