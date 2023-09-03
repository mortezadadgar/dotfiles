## Hashed directory stack
there's a small script that is excluded from this config which allow quickly
navigating between predefined directory using `hash` command-line:

```sh
#!/bin/zsh

typeset -A dirs
dirs=(
	[example]=~/workspace/Go/Projects/example
)

for key value in "${(@kv)dirs}"; do
	hash -d $key=$value
done
```

so all you need to navigate to `~/workspace/Go/Projects/example` is just typing
`cd example` and you're there :)
