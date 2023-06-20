# JQ - Shell Functions

## `param`

Convert json objects into shell parameter declarations:

```bash
jq -r 'import "shell" as sh; sh::param' << 'EOF'
{
  "my-assoc": {
    "k1": "val",
    "k2": "val"
  },
  "my-array": [
    "foo",
    "bar",
    "baz"
  ],
  "my-string": "string",
  "my-int": 42,
  "my-float": 3.14
}
[
  "what about",
  "an array?"
]
EOF
```

> ```bash
> typeset -A _myassoc=(['k1']='val' ['k2']='val')
> typeset -a _myarray=('foo' 'bar' 'baz')
> typeset _mystring='string'
> typeset -i _myint=42
> [[ -v ZSH_ARGZERO ]] && typeset -F _myfloat=3.14
> set -- 'what about' 'an array?'
> ```

## Installation

Copy/Symlink `shell.jq` into your `~/.jq` directory.
