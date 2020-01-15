 param (
    [Parameter(Mandatory=$true)][string]$vcpkgdir,
    [Parameter(Mandatory=$true)][string]$ociodir,
    [switch]$keepoutput = $false
)

$cmakefile = (Resolve-Path $vcpkgdir\scripts\buildsystems\vcpkg.cmake).Path

& $vcpkgdir\vcpkg.exe install ilmbase:x64-windows

$origdir = Get-Location

try {

    cd $ociodir

    if ((Test-Path build) -and (!$keepoutput)) {
        Remove-Item -Recurse -Force build
        mkdir build
    }
    cd build

    cmake -DCMAKE_TOOLCHAIN_FILE="$cmakefile" -DOCIO_BUILD_TESTS=OFF -DOCIO_BUILD_APPS=OFF -DOCIO_BUILD_NUKE=OFF -DOCIO_BUILD_DOCS=OFF -G "Visual Studio 14 2015" -A x64 ..\
    cmake --build . --config Release --target Package
} finally {
    Set-Location $origdir
}