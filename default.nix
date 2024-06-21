{
  stdenv,
  fetchurl,
  fetchFromGitLab,
  lib,
  autoconf,
  automake,
  libtool,
  cmake,
  pkg-config,
  makeWrapper,
  boost,
  cairo,
  fuse,
  glibmm,
  gnome,
  intltool,
  libnotify,
  libstartup_notification,
  libwnck3,
  libxml2,
  libxslt,
  mesa_glu,
  pcre2,
  protobuf,
  python3,
  python3Packages,
  xorg,
  xorgserver,
  wrapGAppsHook,
  ...
}:
stdenv.mkDerivation (f: {
  pname = "compiz-reloaded";
  version = "0.8.18git.20240206T150536~fe274c9f";
#  shortVersion = "${lib.versions.majorMinor f.version}.${lib.versions.patch f.version}";
  srcs = [
    (fetchFromGitLab {
      owner = "compiz";
      repo = "compiz-core";
      rev = "fe274c9f3d8d657dffaaa594be4c851e40ad623c";
      hash = "sha256-XSyh7c03TnkZJ+Ij8WHyBWrgCCH4pcgt5hRswqi52kQ=";
      name = "compiz-core";
    })
    (fetchFromGitLab {
      owner = "compiz";
      repo = "ccsm";
      rev = "0cc706c1c741a8234da3bd1a2c0460cae2804820";
      hash = "sha256-zY9Dz5Sd+NuZk5SrGgHrl71IEnVHgbjmypsoXrMv0p8=";
      name = "ccsm";
    })
  ];
  sourceRoot = ".";

  nativeBuildInputs = [
    autoconf
    automake
    libtool
    pkg-config
    makeWrapper
    xorg.libXdmcp.dev
    pcre2.dev
    libxml2.dev
    wrapGAppsHook
    python3Packages.wrapPython
  ];
  buildInputs = [
    boost
    cairo
    fuse
    glibmm
  #  gnome.metacity
    intltool
    libnotify
    libstartup_notification
    libwnck3
    libxml2
    libxslt
    mesa_glu
    pcre2
    pcre2.dev
    protobuf
    python3
    python3Packages.cython
    python3Packages.pycairo
    python3Packages.pygobject3
    python3Packages.setuptools
    xorg.libXcursor
    xorg.libXdmcp
    xorg.libXdmcp.dev
    xorgserver
  ];

  dontWrapGApps = true;

  pythonPath = with python3Packages; [
    pycairo
    pygobject3
  ];

  buildPhase = ''
  cd ./compiz-core
  NOCONFIGURE=1 ./autogen.sh --prefix=$out
  ./configure \
  --with-gtk=3.0   \
  --host=x86_64-unknown-linux-gnu \
  --prefix=$out \
  --with-default-plugins=core,ccp,decoration,dbus,commands,ezoom,fade,minimize,mousepoll,move,place,png,regex,resize,session,snap,switcher,vpswitch,wall,workarounds
  PREFIX=$out make
  cd ..
  '';

  installPhase = ''
  cd ./compiz-core
  PREFIX=$out make install
  cd ../ccsm
  python setup.py install --prefix=$out
  '';

  postFixup = ''
    wrapProgram "$out/bin/compiz" \
      --prefix COMPIZ_BIN_PATH : "$out/bin/" \
      --prefix LD_LIBRARY_PATH : "$out/lib"

    wrapProgram "$out/bin/compiz-decorator" \
      --prefix COMPIZ_BIN_PATH : "$out/bin/" 

    # Wrap CCSM with GApps and Python path
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
    wrapPythonPrograms
    wrapProgram $out/bin/ccsm \
      --prefix PATH : ${lib.makeBinPath [
        (python3.withPackages(pp: [pp.pygobject3]))
      ]}
    
  '';

  patches = [
  
  ];
  

})
