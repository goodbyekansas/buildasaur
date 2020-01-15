 param (
    [Parameter(Mandatory=$true)][string]$vcpkgdir,
    [Parameter(Mandatory=$true)][string]$oiiodir,
    [switch]$keepoutput = $false
)

$cmakefile = (Resolve-Path $vcpkgdir\scripts\buildsystems\vcpkg.cmake).Path

& $vcpkgdir\vcpkg.exe install openexr:x64-windows ilmbase:x64-windows tiff:x64-windows openjpeg:x64-windows zlib:x64-windows libpng:x64-windows

$origdir = Get-Location

try {

    cd $oiiodir

    if ((Test-Path build) -and (!$keepoutput)) {
        Remove-Item -Recurse -Force build
        mkdir build
    }
    cd build

    cmake -DCMAKE_TOOLCHAIN_FILE="$cmakefile" -DUSE_PYTHON=ON -DOIIO_BUILD_TESTS=OFF -G "Visual Studio 14 2015" -A x64 ..\
    cmake --build . --config Release --target Package
} finally {
    Set-Location $origdir
}