# Claude Container
A simple Nix [Flake](https://nix.dev/concepts/flakes.html) for deploying [Claude Code](https://code.claude.com/docs/en/cli-reference) inside a [Docker container](https://www.docker.com/resources/what-container/).

## Usage
To quickly get started run `just setup` and follow the given instructions.
The text block below lists the special bind-mount directories and files in this repo and what they do.
The *compose.yml* automatically creates [bind-mounts](https://docs.docker.com/engine/storage/bind-mounts/) for these directories so Claude code can have access to them inside the container.
NOTE: The included *.gitignore* ignores these directories, don't change it.
```txt
./
├─ .claude/ - Global Claude code state information. Copied from `~/.claude/` on host machine. Bind-mounts to `~/.claude`.
│
├─ skills/ - Symlink to `.claude/skills`, `git clone` skills repos into here
│
└─ src/ - The Claude workspace, contains all the files you want Claude to have access to. Bind-mounts to `~/src`.
   ├─ templates/ - markdown templates
   │
   └─ <repo_name>/ - can have multiple repos
      ├─ .claude/ - local project state
      ├─ skills/ - agent agnostic skills
      └─ mcp.json - mcp configuration, see: https://modelcontextprotocol.io/docs/getting-started/intro
```
