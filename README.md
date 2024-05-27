# Compiz for NixOS

**See the [compiz09](https://github.com/LuNeder/compiz-reloaded-nix/tree/compiz09) branch, Compiz 0.9 is fully packaged there and works!**

This is a (still WIP) attempt to package compiz-reloaded for NixOS.

TODO:
- [x] Compiz-core
- [ ] Compiz-plugins-main
- [ ] Compiz-plugins-extra
- [ ] Emerald
- [ ] Probably something else I'm forgetting


Tragically, Nix decided to remove Compiz from nixpkgs like ages ago. This is the only thing curently stopping me from migrating to NixOS (since I use compiz at least until I can make my own wayland wm :3)

This is a fork of [Gabriel's repo](https://github.com/Misterio77/compiz-nix). He [fully packaged](https://github.com/Misterio77/nix-config/tree/main/pkgs/compiz) Compiz 0.9 and it does work (see also the compiz09 branch on this repo), but as far as I'm aware Compiz 0.9 has some weird bugs (unlike compiz 0.8 / [compiz-reloaded](https://gitlab.com/compiz/compiz-core)). Hence why I'm trying to package compiz-reloaded which is still very much alive.   
Gabs is like the proest of pros when it comes to Nix, so he'll help me packaging this if I can't get it to work soon!
