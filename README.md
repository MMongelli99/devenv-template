# devenv template

My personal (work-in-progress) template for starting new projects with
[devenv](https://devenv.sh/).

## Motivation

I effectively want to develop as if I'm on a different machine in every project.
This is achieved by configuring a devenv shell with the following in mind:

- **hermeticity** - ensuring that you take nothing from your user/global
  environment into your project development environment
- **isolation** - per the above, the home directory is set to the project
  `.devenv/state` directory, ensuring that whatever you do within the devenv
  shell does not modify state outside your project
- **reproducibility** - by ensuring that your global environment does not
  interact with your development environment, and vice versa, you can have
  confidence that all project dependencies are made explicit, making your
  project trivial to distribute

## Structure

The logical components of this template are:

- `devenv.nix` - use this to tailor your environment to the needs of each
  project.
- `devenv` - (arbitrary, but convenient) place to put custom modules, such as
  the `dx` module provided by this template.
- `devenv/dx` - a module to set up the developer experience for the project. You
  could always expose your global shell configuration (granularly or entirely)
  within the devenv shell if you like, but given the goals of this template, I
  choose to set up developer tooling per each project, e.g. I don't want
  project-specific neovim configuration to be part of my global neovim config,
  I'd introduce a tailored neovim configuration for each project from a generic
  template.
- `.devenv/state` - the `$HOME` of your project, capturing any mutation to
  global state introduced by tools used within the devenv shell (e.g. `.npmrc`,
  `~/.config/direnv`, `.gitconfig`, etc.), and protecting your actual home
  configuration from any intended changes (see `devenv/dx/xdg.nix`).

## Installation

1. Clone this repo via
   `git clone https://github.com/MMongelli99/devenv-template.git`
2. Install the Nix package manager via the official installer (see devenv's
   [Getting Started](https://devenv.sh/getting-started/)).
3. Install devenv or use it in temporary shell via `nix shell nixpkgs#devenv`
4. Run `devenv shell` at the root of this repo.
5. You're in! Read some devenv docs, get assistance generating `devenv.nix`
   using [devenv.new](https://devenv.new/) edit `devenv.nix`, `devenv.yaml`,
   write your own modules, etc. as needed for your project(s).
