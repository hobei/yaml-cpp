This fork exists to bring yaml-cpp in line with the YAML 1.2 spec, so most
issues change what the parser accepts or what `Load` returns. A behaviour change
is **not** by itself a reason for human review when all of these hold:

- the issue or approved design cites the YAML 1.2 spec production or example
  that requires it
- the change is limited to the cases that citation covers
- tests show the new behaviour and guard the neighbouring cases
- existing spec-example tests pass unchanged

Still require human review for changes to public headers under
`include/yaml-cpp/` (API or ABI), emitter output that existing users would see
change, and behaviour changes the spec doesn't require.
