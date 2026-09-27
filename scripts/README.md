1. **Store the Script:**
Save the script to `~/.local/bin/up` (without the `.sh` extension) and make it executable:

```bash
mkdir -p ~/.local/bin
chmod +x ~/.local/bin/up
```

`~/.local/bin` is the standard location for user-specific executables on modern Linux distributions.


2. **Run in Bash Shell:**
Ensure `~/.local/bin` is in your Bash `$PATH`. Add this line to your `~/.bashrc`:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Once added, source your config or restart the terminal. You can then run the script simply by typing:

```bash
up
```


3. **Run in Fish Shell:**
Ensure `~/.local/bin` is in your Fish path by adding it via the Fish environment config or running:

```fish
fish_add_path ~/.local/bin
```

Because the script contains the shebang (`#!/usr/bin/env bash`), Fish will automatically execute it using the Bash interpreter when you type `up`.
