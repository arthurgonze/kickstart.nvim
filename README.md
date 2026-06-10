# Neovim Configuration

This is my personal Neovim configuration, originally forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and expanded into a Windows-first setup. It uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management and is aimed at Unreal Engine and game-development workflows, especially C++ and Python. It also supports general-purpose development in Lua, TypeScript, CSS, and HTML.

## Managing Plugins

### Adding a plugin

Create a new file in `lua/plugins/` that returns a lazy.nvim plugin spec table. Those plugin specs are loaded through `lua/setup/lazy.lua`, so keeping each plugin in its own file is the intended workflow.

### Removing a plugin

Delete the plugin file in `lua/plugins/`, empty it, or remove the plugin spec you no longer want. If you want to keep the file around, you can also disable the plugin in place.

### Disabling a plugin temporarily

Add `enabled = false` to the plugin spec table.

```lua
return {
  'plugin/name',
  enabled = false,
  -- other options...
}
```

### Machine-specific paths

Copy `machine.json.template` to `machine.json` and fill in your machine-specific paths for `basedpyright`, `clangd`, and optionally `ue_python`. The file is gitignored, so your local changes will never be committed to the repository.

## Setting Up Plugins

- Mason installs the configured LSP servers, formatters, linters, and DAP adapters automatically.
- If you are not using Mason, install the required binaries yourself and keep them on `PATH`.
- Node.js is required for `typescript-language-server`, `vscode-langservers-extracted`, `prettier`, and `markdownlint-cli`.
- Python is required for `basedpyright`, `ruff`, and `debugpy`.
- `basedpyright`, `clangd`, and optionally `ue_python` can be set in `machine.json` when you do not want to rely on `PATH`.

## Keybinds

Leader key: `<Space>`

### Navigation

| Key           | Mode | Action                                   |
| ------------- | ---- | ---------------------------------------- |
| `\`           | n    | Open file tree (Neo-tree)                |
| `<C-h>`       | n    | Move to left split                       |
| `<C-j>`       | n    | Move to lower split                      |
| `<C-k>`       | n    | Move to upper split                      |
| `<C-l>`       | n    | Move to right split                      |
| `<A-h>`       | n    | Resize split left                        |
| `<A-j>`       | n    | Resize split down                        |
| `<A-k>`       | n    | Resize split up                          |
| `<A-l>`       | n    | Resize split right                       |
| `<C-d>`       | n    | Scroll half-page down (centered)         |
| `<C-u>`       | n    | Scroll half-page up (centered)           |
| `n` / `N`     | n    | Next/prev search result (centered)       |
| `]b` / `[b`   | n    | Next/prev buffer                         |
| `]d` / `[d`   | n    | Next/prev diagnostic                     |
| `]c` / `[c`   | n    | Next/prev git hunk (in git buffers)      |
| `]q` / `[q`   | n    | Next/prev quickfix item                  |
| `<leader>ma`  | n    | Add current file to Harpoon list         |
| `<leader>mm`  | n    | Toggle Harpoon quick menu                |
| `<leader>m1`  | n    | Jump to Harpoon file 1                   |
| `<leader>m2`  | n    | Jump to Harpoon file 2                   |
| `<leader>m3`  | n    | Jump to Harpoon file 3                   |
| `<leader>m4`  | n    | Jump to Harpoon file 4                   |
| `<leader>mp`  | n    | Go to previous Harpoon file              |
| `<leader>mn`  | n    | Go to next Harpoon file                  |
| `j` / `k`     | n    | Move by visual lines when no count given |
| `<C-h/j/k/l>` | i    | Move cursor in insert mode               |
| `J` / `K`     | v    | Move selected lines down/up              |

### Search (Telescope)

| Key                | Action                         |
| ------------------ | ------------------------------ |
| `<leader>sf`       | Find files                     |
| `<leader>sg`       | Live grep                      |
| `<leader>sw`       | Search current word            |
| `<leader>sd`       | Search diagnostics             |
| `<leader>sh`       | Search help tags               |
| `<leader>sk`       | Search keymaps                 |
| `<leader>ss`       | Select Telescope picker        |
| `<leader>sr`       | Resume last search             |
| `<leader>s.`       | Recent files                   |
| `<leader><leader>` | Find open buffers              |
| `<leader>/`        | Fuzzy search in current buffer |
| `<leader>s/`       | Grep in open files             |
| `<leader>sn`       | Search Neovim config files     |

### LSP

| Key          | Action                                                 |
| ------------ | ------------------------------------------------------ |
| `grd`        | Go to definition (Telescope)                           |
| `grD`        | Go to declaration                                      |
| `grr`        | Go to references (Telescope)                           |
| `gri`        | Go to implementation (Telescope)                       |
| `grt`        | Go to type definition (Telescope)                      |
| `gd`         | Go to definition (native)                              |
| `gO`         | Document symbols                                       |
| `gW`         | Workspace symbols                                      |
| `<leader>lh` | Hover documentation                                    |
| `<leader>lr` | Rename symbol                                          |
| `<leader>lc` | Code action (n/x)                                      |
| `<leader>ls` | Signature help                                         |
| `<leader>lH` | Switch header/source (Clangd only)                     |
| `<leader>ld` | Toggle diagnostic mode (all lines ↔ current line only) |
| `<leader>lD` | Line diagnostics float                                 |
| `<leader>li` | Toggle inlay hints (global)                            |
| `<leader>q`  | Send diagnostics to quickfix list                      |
| `<leader>pi` | Organize imports (Python/basedpyright)                 |

### Git

| Key          | Action                    |
| ------------ | ------------------------- |
| `<leader>ga` | Git add all               |
| `<leader>gs` | Git status (fugitive)     |
| `<leader>gc` | Git commit                |
| `<leader>gd` | Git diff split            |
| `<leader>gv` | Open Diffview             |
| `<leader>gh` | Diffview file history     |
| `<leader>gf` | Git fetch                 |
| `<leader>gP` | Git pull                  |
| `<leader>gB` | Git branch                |
| `<leader>gS` | Git stash                 |
| `<leader>gb` | Git blame (fugitive)      |
| `<leader>gl` | Git log                   |
| `<leader>gp` | Git push                  |
| `<leader>hs` | Stage hunk (n/v)          |
| `<leader>hr` | Reset hunk (n/v)          |
| `<leader>hS` | Stage buffer              |
| `<leader>hu` | Undo stage hunk           |
| `<leader>hR` | Reset buffer              |
| `<leader>hp` | Preview hunk (popup)      |
| `<leader>hP` | Preview hunk inline       |
| `<leader>hb` | Blame line                |
| `<leader>hd` | Diff against index        |
| `<leader>hD` | Diff against last commit  |
| `<leader>tb` | Toggle line blame         |
| `<leader>tD` | Toggle show deleted lines |
| `<leader>tw` | Toggle word diff          |

### Debug (DAP)

| Key          | Action                     |
| ------------ | -------------------------- |
| `<F5>`       | Start / Continue           |
| `<F1>`       | Step into                  |
| `<F2>`       | Step over                  |
| `<F3>`       | Step out                   |
| `<F7>`       | Toggle DAP UI              |
| `<leader>b`  | Toggle breakpoint          |
| `<leader>B`  | Set conditional breakpoint |
| `<leader>bt` | Terminate debug session    |
| `<leader>br` | Restart debug session      |
| `<leader>bR` | Open REPL                  |
| `<leader>bc` | Run to cursor              |
| `<leader>bB` | Step back                  |

### Build (CMake)

| Key           | Action         |
| ------------- | -------------- |
| `<leader>cmg` | CMake Generate |
| `<leader>cmb` | CMake Build    |
| `<leader>cmr` | CMake Run      |
| `<leader>cmd` | CMake Debug    |
| `<leader>cms` | CMake Stop     |

### Run

| Key          | Action                                  |
| ------------ | --------------------------------------- |
| `<leader>rp` | Run current Python file                 |
| `<leader>rf` | Run current file (`.py`, `.lua`, other) |

### AI

| Key          | Action                      |
| ------------ | --------------------------- |
| `<leader>ac` | CodeCompanion Chat toggle   |
| `<leader>aa` | CodeCompanion Actions (n/v) |
| `<leader>ad` | Generate docstring (visual) |

### Toggles & Utilities

| Key              | Action                                 |
| ---------------- | -------------------------------------- |
| `<C-\>`          | Toggle terminal (float)                |
| `<leader>tf`     | Toggle floating terminal               |
| `<leader>th`     | Toggle horizontal terminal             |
| `<Esc>`          | Clear search highlight                 |
| `<Space><Space>` | Clear search highlight                 |
| `<leader>jk`     | Escape (n/v/i/t)                       |
| `<leader>p`      | Paste over selection (v, no overwrite) |
| `<leader>d`      | Delete to black hole (n/v)             |

### Commands (no keybind, but worth knowing)

| Command                           | Action                             |
| --------------------------------- | ---------------------------------- |
| `:LspRestart <name>`              | Restart a named LSP server         |
| `:LspInfo`                        | Show comprehensive LSP info        |
| `:LspStatus`                      | Show LSP clients on current buffer |
| `:LspCapabilities`                | Show LSP capabilities              |
| `:LspDiagnostics`                 | Show diagnostic counts             |
| `:Unreal`                         | Manually initialize Unreal-Nvim    |
| `:LspPyrightOrganizeImports`      | Organize Python imports            |
| `:LspPyrightSetPythonPath <path>` | Set Python interpreter path        |

## Unreal Engine

### Auto-initialization

Unreal-Nvim auto-initializes when opening:

- `*.uproject`, `*.uplugin`, `*.Build.cs`, `*.Target.cs`
- C/C++ files (`*.cpp`, `*.h`, `*.hpp`, `*.c`) when the cwd contains a `.uproject`
- New C/C++ files created inside a UE project cwd

If auto-init does not trigger, run `:Unreal` manually.

### Keybinds

| Key          | Action                     |
| ------------ | -------------------------- |
| `<leader>ub` | UE Build Project           |
| `<leader>uh` | UE Generate Headers        |
| `<leader>uc` | UE Compile Commands        |
| `<leader>ul` | UE Clangd Config           |
| `<leader>uB` | UE Build Engine            |
| `<leader>uH` | UE Engine Headers          |
| `<leader>uC` | UE Engine Compile Commands |

### C++ Workflow

**First-time setup (new UE project):**

1. Open Neovim from the Unreal project root so Unreal-Nvim can initialize against the `.uproject`.
2. Press `<leader>uc` to generate `compile_commands.json` so `clangd` can resolve UE include paths and headers.
3. Press `<leader>ul` to write the project `.clangd` config.
4. Restart the C++ LSP with `:LspRestart clangd` if completion or diagnostics do not refresh immediately.
5. If you use a custom LLVM install, set the `clangd` path in `machine.json`.

**To build C++ changes:**

- Press `<leader>ub` to build through Unreal Build Tool with Unreal-Nvim's interactive target/config picker.
- If you prefer the CMake workflow, use `<leader>cmb` to run `CMakeBuild`.

**To generate headers (after adding `UPROPERTY`/`UFUNCTION` macros):**

- Press `<leader>uh` to run UHT and refresh generated reflection headers before compiling again.

**To debug C++:**

1. Set a breakpoint with `<leader>b`.
2. Press `<F5>` to start or continue the `codelldb` session.
3. Step into / over / out with `<F1>` / `<F2>` / `<F3>`.
4. Restart with `<leader>br` if you need a fresh session.
5. Stop the session with `<leader>bt`.

### Python (Editor Scripting)

**First-time setup:**

1. Set `ue_python` in `machine.json` to the Unreal Engine Python interpreter you want Neovim to use.
2. Open Neovim from the UE project root so Unreal-Nvim can expose the project Python environment.
3. `basedpyright` will then pick up `Intermediate/PythonStub` automatically, and plugin Python folders under `Plugins/*/Content/Python` are added to `extraPaths`.

**To run a Python script:**

- Press `<leader>rp` to run the current `.py` file in a horizontal ToggleTerm split.
- The output stays visible in the terminal pane; press `<Esc><Esc>` to return to normal mode.

**To debug Python:**

1. Set a breakpoint with `<leader>b`.
2. Press `<F5>` to start debugging with `debugpy`.
3. Step into / over / out with `<F1>` / `<F2>` / `<F3>`.
4. Stop the session with `<leader>bt`.

## Troubleshooting

### LSP not starting

- Run `:LspInfo` to check whether a client is attached
- Ensure the language server binary is on `PATH` or configured in `machine.json`
- Run `:LspRestart <name>` to force-restart a specific server

### Plugins not loading

- Run `:Lazy` to open the plugin manager UI
- Check `:Lazy log` for errors
- Run `:Lazy sync` to update all plugins

### machine.json missing

- Copy `machine.json.template` to `machine.json` and fill in the required paths
- Without it, LSP servers fall back to binaries on `PATH`, which may or may not work on your system

### Python debugging fails on first launch

- On first run, Mason installs `debugpy` in the background; Python DAP is wired automatically once installation completes
- If it still fails, restart Neovim and try again

### Unreal LSP/Python not working

- Ensure Neovim is opened from the Unreal project root (the directory containing the `.uproject`)
- Run `:Unreal` to manually trigger Unreal-Nvim initialization
- Check that `ue_python` is set in `machine.json` for the correct UE Python interpreter

### Clangd not finding headers

- Ensure a `compile_commands.json` or `compile_flags.txt` exists in the project root (generated by CMake or UBT)
- Set the `clangd` path in `machine.json` if you use a custom LLVM build
