# Preempt environment with lin-group configuration
export PATH="{{BIN}}:$PATH"
export CPATH="{{INCLUDE}}:$CPATH"
export CPPFLAGS="-I{{INCLUDE}} $CPPFLAGS"
export LDFLAGS="-L{{LIB}} $LDFLAGS"
export LD_LIBRARY_PATH="{{LIB}}:{{MKL_LIBRARY_PATH}}$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="{{PKGCONFIG}}:$PKG_CONFIG_PATH"
export PROJ_LIB="{{SHARE}}/proj"
