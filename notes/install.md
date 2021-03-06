# Compilation and Installation

## OpenBabel

[Open Babel](http://openbabel.org/wiki/Main_Page) is a chemical toolbox designed to speak the many languages of chemical data. It's an open, collaborative project allowing anyone to search, convert, analyze, or store data from molecular modeling, chemistry, solid-state materials, biochemistry, or related areas.

### Requirements

* [CMake](https://cmake.org/)

Optional:

* [Eigen3](http://eigen.tuxfamily.org/)
* [Python](https://www.python.org/)

```bash
git git build-essential \
    cmake \
    libeigen3-dev \
    python3-dev
```

### Download

OpenBabel needs a few patches in order to work properly for flexible docking. Use the following fork: `https://github.com/RMeli/openbabel/tree/fix/icode`.

```bash
git clone https://github.com/RMeli/openbabel
cd openbabel
git checkout fix/icode
```

### Compilation

```bash
mkdir build && cd build
cmake .. \
    -DWITH_JSON:BOOLEAN=FALSE \
    -DPYTHON_BINDINGS=ON -DRUN_SWIG=ON -DPYTHON_EXECUTABLE=/usr/bin/python3 \
    -DCMAKE_INSTALL_PREFIX=$HOME/software/openbabel
make -j
ctest
```

### Installation

```bash
mkdir -p $HOME/software/openbabel
make install
```

The following variables have to be set in order to compile `smina` (and other software) with this custom installation of OpenBabel:

```bash
export LIBRARY_PATH=$HOME/software/openbabel/lib
export LD_LIBRARY_PATH=$HOME/software/openbabel/lib
```

`LIBRARY_PATH` is used before compilation to include directories containing static and/or shared libraries that have to be linked to the program. `LD_LIBRARY_PATH` is used by the program (successfully compiled and linked) to dinamically link shared libraries.

## Smina

[smina](https://sourceforge.net/projects/smina/) is a fork of [Autodock Vina](http://vina.scripps.edu/) that focuses on improving scoring and minimization.

### Requirements

* [Boost](https://www.boost.org/)
* [Eigen3](http://eigen.tuxfamily.org/)
* [Open Babel](http://openbabel.org/wiki/Main_Page)

```bash
apt install git build-essential libboost-all-dev libeigen3-dev
```

Install OpenBabel as described above.

The [Singularity](https://sylabs.io/singularity/) conteiner defined by `smina.def` already has all the requirements.

### Download

```bash
git clone https://git.code.sf.net/p/smina/code smina
```

### Compilation

Change the path to OpenBabel in `smina/build/linux/release/Makefile`:

```bash
OPENBABEL_INCLUDE=/usr/local/include/openbabel-2.0
```

```bash
cd smina/build/linux/release
make -j
```

## CMake

```bash
apt purge --auto-remove cmake
cmake_version=3.14
cmake_build=4
mkdir /cmake && cd /cmake
wget https://cmake.org/files/v${cmake_version}/cmake-${cmake_version}.${cmake_build}.tar.gz
tar -xzvf cmake-${cmake_version}.${cmake_build}.tar.gz
cd cmake-${cmake_version}.${cmake_build}/
./bootstrap
make -j 4
make install
cmake --version
```
