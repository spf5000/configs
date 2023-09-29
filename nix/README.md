## Overview

This is notes on my collection of nix/NixOS configurations.

## How is this setup

If you look over the history of this repo, you'll see I've updated the ways I configure NixOS/Home Manager. I'm sure it'll change again in the future too as I learn more :)

That said, at the time of this writing, I currently manage my systems using Nix flakes. In addition, I am creating a flake per system.

With flakes, I can manage and pin inputs for the nixOS configurations, giving me confidence things won't break unexpectedly. In addition, by creating a flake per system, I can update the inputs to the flake in the lock file without breaking another system (ex: my Raspberry pi home-server which I generally tinker with in inconsistent bursts). However, the risk here is that the shared modules break across systems, something I'm interested to see the impact of.

I currently have an input.nix file that my modules (configuration.nix/home.nix) files reference for system specific information. This lets me re-use modules while still having system specific setups. Currently, these inputs contain some "private" information, so I only push an example file to github for reference. (Long term, I plan on moving this all to some secure encryption mechanism so the inputs are still backed up, but I've been too lazy so far to do that.)

I've also attempted to put anything shared into home-manager. This lets me leverage this across systems, including non-nixos systems where I use home-manager for a consistent setup (ex: my work machine).
