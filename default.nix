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
  python3Packages,
  xorg,
  xorgserver,
  ...
}:
stdenv.mkDerivation (f: {
  pname = "compiz-reloaded";
  version = "0.8.18git.20240206T150536~fe274c9f";
#  shortVersion = "${lib.versions.majorMinor f.version}.${lib.versions.patch f.version}";
  src = fetchFromGitLab {
    owner = "compiz";
    repo = "compiz-core";
    rev = "fe274c9f3d8d657dffaaa594be4c851e40ad623c";
    hash = "sha256-XSyh7c03TnkZJ+Ij8WHyBWrgCCH4pcgt5hRswqi52kQ=";
  };

  nativeBuildInputs = [
    autoconf
    automake
    libtool
    pkg-config
    makeWrapper
    xorg.libXdmcp.dev
    pcre2.dev
    libxml2.dev
  ];
  buildInputs = [
    boost
    cairo
    fuse
    glibmm
    gnome.metacity
    intltool
#    libmarco-private
    libnotify
    libstartup_notification
    libwnck3
    libxml2
    libxslt
    mesa_glu
    pcre2
    pcre2.dev
    protobuf
    python3Packages.cython
    python3Packages.pycairo
    python3Packages.pygobject3
    python3Packages.setuptools
    xorg.libXcursor
    xorg.libXdmcp
    xorg.libXdmcp.dev
    xorgserver
  ];
  buildPhase = ''
  NOCONFIGURE=1 ./autogen.sh --prefix=$out
  ./configure \
  --with-gtk=3.0   \
  --host=x86_64-unknown-linux-gnu \
  --prefix=$out \
  --with-default-plugins=core,ccp,decoration,dbus,commands,ezoom,fade,minimize,mousepoll,move,place,png,regex,resize,session,snap,switcher,vpswitch,wall,workarounds,matecompat
  PREFIX=$out make
  '';
  installPhase = ''
  PREFIX=$out make install
  '';
#  postInstall = ''
#    sed -i "s|/usr/bin/metacity|${gnome.metacity}/bin/metacity|" $out/bin/compiz-decorator
#    sed -i "s|/usr/bin/compiz-decorator|$out/bin/compiz-decorator|" $out/share/compiz/decor.xml
#    wrapProgram $out/bin/compiz \
#      --suffix LD_LIBRARY_PATH : "$out/lib" \
#      --suffix COMPIZ_BIN_PATH : "$out/bin/"
#  '';

  patches = [
  
  ];
  
  configureFlags = [
 #   "--enable-marco"
    "--with-gtk=3.0"
    "--host=x86_64-unknown-linux-gnu"
    "--with-default-plugins=core,ccp,decoration,dbus,commands,ezoom,fade,minimize,mousepoll,move,place,png,regex,resize,session,snap,switcher,vpswitch,wall,workarounds,matecompat"
  ];

})
