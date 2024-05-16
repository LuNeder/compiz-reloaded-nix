# Compiz for NixOS

This is a (still WIP) attempt to package compiz-reloaded for NixOS.

TODO:
- [ ] Compiz-core
  - Compiles, but screen stays black when running compiz --replace (at least on virtualbox, please do test it on a real system and let me know)
- [ ] Compiz-plugins-main
- [ ] Compiz-plugins-extra
- [ ] Emerald
- [ ] Probably something else I'm forgetting


Tragically, Nix decided to remove Compiz from nixpkgs like ages ago. This is the only thing curently stopping me from migrating to NixOS (since I use compiz at least until I can make my own wayland wm :3)

This is a fork of [Gabriel's repo](https://github.com/Misterio77/compiz-nix). He fully packaged Compiz 0.9 and it does work, except for CompizConfig (the compiz09 branch on this repo is a still wip attempt to fix that). Aditionally, do note that as far as I'm aware Compiz 0.9 is now unmaintained (unlike compiz 0.8 / [compiz-reloaded](https://gitlab.com/compiz/compiz-core)), hence why I'm trying to package compiz-reloaded which is still very much alive.   
Gabs is like the proest of pros when it comes to Nix, so he'll help me packaging this if I can't get it to work soon!
